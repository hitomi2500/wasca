#include <yaul.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "font.h"
#include "input.h"
#include "video.h"
#include "control.h"
#include "video_vdp2.h"
#include "wascafs.h"

	video_screen_mode_t screenMode =
	{
		.scanmode = VIDEO_SCANMODE_480I,
		.x_res = VIDEO_X_RESOLUTION_320,
		.y_res = VDP2_TVMD_VERT_240,
		.x_res_doubled = true,
		.colorsystem = VDP2_TVMD_TV_STANDARD_NTSC,
	};

int global_frame_count = 0;
extern const uint8_t PC_FACE_MODERNDOS_8X16_FONT_LIST[256][16];
int wasca_found = 0;
volatile uint16_t * FSSTAT = (uint16_t*)0x23FFFA00;
volatile uint16_t * FSCNTRL = (uint16_t*)0x23FFFFF2;
volatile uint16_t* pWascaRegs = (uint16_t*)0x23FFFFE0;
volatile uint8_t * pFilesysCmdBuf = (uint8_t*)0x23FFF800;
volatile uint8_t * pFilesysReplyBuf = (uint8_t*)0x23FFF900;
volatile uint8_t * pFilesysDataBuf = (uint8_t*)0x23FFF000;

typedef struct {
	char name[64];
	char size[10];
	char date[10];
	int dir_flag;
} panel_entry_t;

panel_entry_t Panel_Entries[2][256];
int Panel_Entries_Count[2];
char Panel_Paths[2][256];

int Current_Panel = 0;
int Current_Panel_File = 0;
int Current_Panel_Offset = 0;

//char debug[256];

static void suite_vblank_out_handler(void *work __unused)
{
    global_frame_count++;
    
    if (0==video_is_inited())
        return;
    
    smpc_peripheral_intback_issue();
}

void draw_char(uint8_t char_code, int  x, int y, int palette) {
	uint32_t * p32 = (uint32_t *)VIDEO_VDP2_NBG0_PNDR_START;
	if (x>=64) {
		p32[64*63+y*128+x] = 2*(palette*512+char_code*2);
		p32[64*63+y*128+64+x] = 2*(palette*512+char_code*2+1);
	} else {
		p32[y*128+x] = 2*(palette*512+char_code*2);
		p32[y*128+64+x] = 2*(palette*512+char_code*2+1);
	}
}

void fill_rect(int left, int top, int width, int height, int palette) {
	for (int y=top; y<(top+height); y++)
		for (int x=left; x<(left+width); x++)
			draw_char(0,x,y,palette);
}

void draw_double_border(int left, int top, int width, int height, int palette) {
	for (int y=top+1; y<(top+height-1); y++) {
		draw_char(0xba,left,y,palette);
		draw_char(0xba,left+width-1,y,palette);
	}
	for (int x=left+1; x<(left+width-1); x++) {
		draw_char(0xcd,x,top,palette);
		draw_char(0xcd,x,top+height-1,palette);
	}
	draw_char(0xc9,left,top,palette);
	draw_char(0xbb,left+width-1,top,palette);
	draw_char(0xc8,left,top+height-1,palette);
	draw_char(0xbc,left+width-1,top+height-1,palette);
}

void draw_string(char * string, int left, int top, int palette) {
	int i=0;
	while (string[i]) {
		draw_char(string[i],left+i,top,palette);
		i++;
	}
}

void draw_horizontal_line(int left, int top, int width, int palette) {
	for (int x=left; x<(left+width); x++) {
		draw_char(0xc4,x,top,palette);
	}
}

void draw_vertical_line(int left, int top, int height, int palette) {
	for (int y=top; y<(top+height); y++) {
		draw_char(0xb3,left,y,palette);
	}
}

void execute_command(char * cmd_buf, char * reply_buf, char* data_buf) {
	volatile int timeout;
	if (0==wasca_found) {
		strcpy(reply_buf,"No cart");
		return;
	}

	if (FSSTAT[0] != 0) {
		strcpy(reply_buf,"NotIdle");
		//assuring idle state
		FSCNTRL[0] = 0;

		//waiting for cart to return to idle
		timeout = 0;
		while ((FSSTAT[0] != 0) && (timeout < 100000)) {
			FSCNTRL[0] = 0;
			timeout++;
		}
	}

	//sending cmd
	strcpy(pFilesysCmdBuf,cmd_buf);
	FSCNTRL[0] = 0xFFFF;

	//waiting until command is executed
	timeout = 0;
	while ((FSSTAT[0] == 0) && (timeout < 100000)) {
		timeout++;
	}

	if (timeout >= 100000)
		sprintf(pFilesysReplyBuf,"Tm%x %x %x",FSSTAT[0],FSSTAT[1],pWascaRegs[9]);
	else {
		FSCNTRL[0] = 0;
		pFilesysReplyBuf[255] = 0;//assuring string end
		strcpy(reply_buf,pFilesysReplyBuf);
		if (data_buf)
			memcpy(data_buf,pFilesysDataBuf,2048);
	}
}

int read_panel_files(char * path, panel_entry_t * entries) {
	char cmd_buf[256];
	char reply_buf[256];
	WFS_DateTime datetime;
	int current_file = 0;
	int end_of_folder = 0;
	char * ptr;
	//int i;
	int size;
	int dir_flag;

	for (int i=0;i<256;i++) {
		entries[i].name[0] = 0;
		entries[i].date[0] = 0;
		entries[i].size[0] = 0;
		entries[i].dir_flag = 0;
	}

	while (0 == end_of_folder) {
		wascafs_chdir(path);
		if (0 == current_file)
			wascafs_list(1,reply_buf);
		else
			wascafs_list(0,reply_buf);
		if (strlen(reply_buf)) {
			strcpy(entries[current_file].name,reply_buf);
		} else {
			end_of_folder = 1;
		}

		if (0 == end_of_folder) {
			wascafs_stat(entries[current_file].name,&size,&datetime,&dir_flag);
			entries[current_file].dir_flag = dir_flag;
			if (1 == dir_flag) {
				//directory
				strcpy(entries[current_file].size,"\x10SUB-DIR\x11");
			} else {
				//file
				sprintf(entries[current_file].size,"%d",size);
			}
			int _year = (datetime.year > 2000) ? datetime.year-2000 : datetime.year-1900;
			sprintf(entries[current_file].date,"%02d.%02d.%02d",datetime.date,datetime.month,_year);
		}
		current_file++;
		if (current_file >=256)
			end_of_folder = 1;
	}
	return current_file;
}

void draw_panel(int x_offset) {
	char buf[256];
	int panel_index = (x_offset) ? 1 : 0;
	
	draw_double_border(x_offset,0,40,28,0);
	fill_rect(x_offset+1,1,38,26,0);
	//status string divider
	draw_horizontal_line(x_offset+1,25,38,0);
	draw_char(0xc7,x_offset,25,0);
	draw_char(0xb6,x_offset+39,25,0);
	//column dividers
	draw_vertical_line(x_offset+20,1,25,0);
	draw_vertical_line(x_offset+30,1,25,0);
	draw_char(0xd1,x_offset+20,0,0);
	draw_char(0xd1,x_offset+30,0,0);
	draw_char(0xc1,x_offset+20,25,0);
	draw_char(0xc1,x_offset+30,25,0);
	//column labels
	draw_string("Name",x_offset+10,1,4);
	draw_string("Size",x_offset+24,1,4);
	draw_string("Date",x_offset+33,1,4);
	//panel path
	sprintf(buf," %.30s ",Panel_Paths[panel_index]);
	draw_string(buf,x_offset+(40-strlen(buf))/2,0,2);

	char name_buf[20];
	
	//files
	Panel_Entries_Count[panel_index] = read_panel_files(Panel_Paths[panel_index],Panel_Entries[panel_index]);
	for (int i=0;i<Panel_Entries_Count[0];i++) {
		memcpy(name_buf,Panel_Entries[panel_index][i].name,20);
		if (strlen(name_buf)>19) 
			name_buf[19] = 0;
		draw_string(name_buf,x_offset+1,i+2,0);
		draw_string(Panel_Entries[panel_index][i].size,x_offset+21,i+2,0);
		draw_string(Panel_Entries[panel_index][i].date,x_offset+31,i+2,0);
	}

	//active string
	if ( (Current_Panel == panel_index) ){
		draw_string("\xb3                  \xb3         \xb3        ",x_offset+1,Current_Panel_File+2,5);
		memcpy(name_buf,Panel_Entries[panel_index][Current_Panel_File].name,20);
			if (strlen(name_buf)>19) 
				name_buf[19] = 0;
		draw_string(name_buf,x_offset+1,Current_Panel_File+2,5);
		draw_string(Panel_Entries[panel_index][Current_Panel_File].size,x_offset+21,Current_Panel_File+2,5);
		draw_string(Panel_Entries[panel_index][Current_Panel_File].date,x_offset+31,Current_Panel_File+2,5);
	}
}

void draw_screen() {
	//panels
	draw_panel(0);
	draw_panel(40);
	//path
	draw_string(" 0:/",0,28,1);
	//buttons
	int button_x = 1;
	draw_string("A",button_x,29,1);button_x++;
	draw_string("View  ",button_x,29,2);button_x+=7;button_x++;
	draw_string("B",button_x,29,1);button_x++;
	draw_string("Copy  ",button_x,29,2);button_x+=7;button_x++;
	draw_string("C",button_x,29,1);button_x++;
	draw_string("Run   ",button_x,29,2);button_x+=7;button_x++;
	draw_string("X",button_x,29,1);button_x++;
	draw_string("Edit  ",button_x,29,2);button_x+=7;button_x++;
	draw_string("Y",button_x,29,1);button_x++;
	draw_string("Send  ",button_x,29,2);button_x+=7;button_x++;
	draw_string("Z",button_x,29,1);button_x++;
	draw_string("Delete",button_x,29,2);button_x+=7;button_x++;
	draw_string("L",button_x,29,1);button_x++;
	draw_string("LPanel",button_x,29,2);button_x+=7;button_x++;
	draw_string("R",button_x,29,1);button_x++;
	draw_string("RPanel",button_x,29,2);button_x+=7;button_x++;
	draw_string("S",button_x,29,1);button_x++;
	draw_string("Exit  ",button_x,29,2);button_x+=7;button_x++;
}

void draw_dialogbox(char * string, int palette) {
	int len = strlen(string);
	len+=4;
	draw_double_border(40-len/2,11,len,7,palette);
	fill_rect(40-len/2+1,12,len-2,5,palette);
	draw_string(string,40-len/2+2,14,palette);
}

void execute_selected_file() {
	char cmd_buf[256];
	char reply_buf[256];
	int handle;
	int offset;
	int data_len;
	char * p;
	//open dir
	if (wascafs_chdir(Panel_Paths[Current_Panel]) != WFS_OK) {
		draw_dialogbox("Dir open error",3);
		return;
	}
	//open file
	if (wascafs_open(Panel_Entries[Current_Panel][Current_Panel_File].name,"r",&handle) != WFS_OK) {
		draw_dialogbox("Open error",3);
		return;
	} else {
		draw_dialogbox("Loading...",3);
		//execute read until either error or eof
		offset = 0;
		data_len = 2048;
		while (2048 == data_len) {
			data_len = 2048;
			WFS_StatusType result = wascafs_read(handle,(uint8_t*)(CS0(offset)),offset,2048,&data_len);
			if (result != WFS_OK) {
				draw_dialogbox("Read error",3);
				return;
			}
			offset += data_len;
		}
		wascafs_close(handle);
		bios_execute();
	}
}

void copy_selected_file() {
	char cmd_buf[256];
	char reply_buf[256];
	char data_buffer[2048];
	int src_handle;
	int dst_handle;
	int offset;
	int data_len;
	char * p;
	//copy file
	if (strcmp(Panel_Paths[0],Panel_Paths[1]) == 0) {
		draw_dialogbox("Cannot copy to same folder",3);
		return;
	}
	//open source file
	if (wascafs_chdir(Panel_Paths[Current_Panel]) != WFS_OK) {
		draw_dialogbox("Source dir open error",3);
		return;
	}
	if (wascafs_open(Panel_Entries[Current_Panel][Current_Panel_File].name,"r",&src_handle) != WFS_OK) {
		draw_dialogbox("Source open error",3);
		return;
	}

	//open destination file
	if (wascafs_chdir(Panel_Paths[Current_Panel ? 0 : 1]) != WFS_OK) {
		draw_dialogbox("Destination dir open error",3);
		return;
	}
	if (wascafs_open(Panel_Entries[Current_Panel][Current_Panel_File].name,"w",&dst_handle) != WFS_OK) {
		draw_dialogbox("Destination open error",3);
		return;
	}
	
	draw_dialogbox("Copying...",3);

	//execute read until either error or eof
	WFS_StatusType result;
	offset = 0;
	data_len = 2048;
	while (2048 == data_len) {
		result = wascafs_read(src_handle,(uint8_t*)(CS0(offset)),offset,2048,&data_len);
		if (result != WFS_OK) {
			draw_dialogbox("Read error",3);
			return;
		}
		//using the same data buffer, just writing it back
		result = wascafs_write(dst_handle,(uint8_t*)(CS0(offset)),offset,data_len,&data_len);
		if (result != WFS_OK) {
			draw_dialogbox("Write error",3);
			return;
		}
		offset += data_len;				
	}

	wascafs_close(src_handle);
	wascafs_close(dst_handle);
	draw_dialogbox("Copy complete",3);
}

void enter_selected_folder() {
	char buf[256];
	sprintf(buf, "%s%s/",Panel_Paths[Current_Panel],Panel_Entries[Current_Panel][Current_Panel_File].name);
	strcpy(Panel_Paths[Current_Panel],buf);
	draw_dialogbox(buf,3);
	Current_Panel_File = 0;
}


int main(void)
{
	char string_buf[128];
	uint16_t counter;
	strcpy(Panel_Paths[0],"/");
	strcpy(Panel_Paths[1],"/");

	//setting mode, for debug
	//uint16_t* pWascaRegs = (uint16_t*)0x23FFFFE0;
	//pWascaRegs[10] = 8;

	//checking wasca signature
	uint8_t * p8 = (uint8_t *)CS0(0x1FFFFFA);
	if (memcmp(p8,"wasca ",6)) {
		wasca_found = 0;
	} else {
		wasca_found = 1;
	}

	video_init(screenMode,false);

	video_vdp2_clear_palette(0);

	video_vdp2_set_cycle_patterns_cpu(screenMode);

	FSCNTRL[0] = 0xFFFF;

	//load 8x16 font to VDP2 tiles
    p8 = (uint8_t *)VIDEO_VDP2_NBG0_CHPNDR_START;
	for (int i=0;i<256;i++) {
		for (int j=0;j<128;j++) {
			p8[i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 2:1; //cyan on blue
			p8[1*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 3:0; //gray on black
			p8[2*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 0:4; //black on greenish
			p8[3*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 6:5; //white on lightgray
			p8[4*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 7:1; //yellow on blue
			p8[5*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 1:2; //blue on cyan
		}
	}

	draw_screen();

	if (0 == wasca_found) {
		//char _buf[32];
		//sprintf(_buf,"id:%x %x %x %x %x %x",p8[0],p8[1],p8[2],p8[3],p8[4],p8[5]);
		draw_dialogbox("wasca cartridge not detected!",3);
		//draw_dialogbox(_buf,3);
		//while (1); //freeze
	}	

	video_vdp2_set_cycle_patterns_nbg(screenMode);

	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0, 0, 0), 0, 0);//black
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0, 0, 0x80), 1, 1);//blue
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0, 0xFF, 0xFF), 2, 2);//cyan
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0xC0, 0xC0, 0xC0), 3, 3);//gray
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0x04, 0xAA, 0xAC), 4, 4);//greenish
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0xAA, 0xAA, 0xAA), 5, 5);//lightgray
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0xFF, 0xFF, 0xFF), 6, 6);//white
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0xFC, 0xFE, 0x54), 7, 7);//yellow
	//SetFontPalette();

	//detect color system
	screenMode.colorsystem = vdp2_tvmd_tv_standard_get();

	//measure frame clock
	volatile int frame_counter=0;
	while (vdp2_tvmd_vblank_out())
		;
	while (vdp2_tvmd_vblank_in())
		frame_counter++;
	while (vdp2_tvmd_vblank_out())
		frame_counter++;

	//register vblank handler
	vdp_sync_vblank_out_set(suite_vblank_out_handler, NULL);
	
	//calculating advertising list size
	uint8_t* pAdvertiseList = (uint8_t*)0x23000000;

	int offset = 1;
	int list_size = 0;
	while ((pAdvertiseList[offset] != 0) &&(list_size < 24)) {
		list_size++; 
		offset+=64;
	}
	
	int update_required = 0;

	//DrawString("Text", 100, 100, FONT_WHITE);
	
	while(true)
	{
		vdp2_tvmd_vblank_out_wait();
		smpc_peripheral_process();
		get_digital_keypress_anywhere(&controller);
		
		update_required=0;

		if(controller.pressed.button.up) {
			wait_for_key_unpress();
			Current_Panel_File--;
			if (Current_Panel_File < 0)
				Current_Panel_File = Panel_Entries_Count[Current_Panel] - 2;				
			update_required = 1;
		}
		if(controller.pressed.button.down) {
			wait_for_key_unpress();
			Current_Panel_File++;
			if (Current_Panel_File >= (Panel_Entries_Count[Current_Panel]-1))
				Current_Panel_File = 0;	
			update_required = 1;			
		}
		if ((controller.pressed.button.left) || (controller.pressed.button.l)) {
			wait_for_key_unpress();
			Current_Panel = 0;
			update_required = 1;			
		}
		if ((controller.pressed.button.right) || (controller.pressed.button.r))  {
			wait_for_key_unpress();
			Current_Panel = 1;
			update_required = 1;			
		}
		if ((controller.pressed.button.a)) {
			wait_for_key_unpress();
		}
		if ((controller.pressed.button.b)) {
			wait_for_key_unpress();
			copy_selected_file();
			//update_required = 1;
		}
		if ((controller.pressed.button.c)) {
			wait_for_key_unpress();
			//execute file / open dir
			if (Panel_Entries[Current_Panel][Current_Panel_File].dir_flag) {
				enter_selected_folder();
				update_required = 1;			
			} else if (strstr(Panel_Entries[Current_Panel][Current_Panel_File].name,".ss") != 0)
				execute_selected_file();
			//else
			//	draw_dialogbox("wrong file",3);
		}

		if (update_required) {
			draw_screen();
		}

		/*if (go_reboot)
			bios_execute();
		else if (go_multiplayer)
			bios_cd_player_execute();*/
		
		vdp2_sync();
		vdp2_sync_wait();
	}
}

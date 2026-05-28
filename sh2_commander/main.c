#include <yaul.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "font.h"
#include "input.h"
#include "video.h"
#include "control.h"
#include "video_vdp2.h"

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
uint16_t * FSSTAT = (uint16_t*)0x23FFFA00;
uint16_t * FSCNTRL = (uint16_t*)0x23FFFFF2;
uint16_t* pWascaRegs = (uint16_t*)0x23FFFFE0;
uint8_t * pCmdBuf = (uint8_t*)0x23FFF800;
uint8_t * pReplyBuf = (uint8_t*)0x23FFF900;

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

void execute_command(char * command) {
	int timeout;
	if (0==wasca_found) 
		return;
	//video_vdp2_set_cycle_patterns_nbg(screenMode);

	if (FSSTAT[0] != 0) {
		strcpy(pReplyBuf,"NotIdle");
		//assuring idle state
		FSCNTRL[0] = 0;

		//waiting for cart to return to idle
		timeout = 0;
		while ((FSSTAT[0] != 0) && (timeout < 10)) {
			FSCNTRL[0] = 0;
			timeout++;
			vdp2_sync();
			vdp2_sync_wait();
		}
	}

	//sending cmd
	strcpy(pCmdBuf,command);
	FSCNTRL[0] = 0xFFFF;

	//waiting until command is executed
	timeout = 0;
	while ((FSSTAT[0] == 0) && (timeout < 300)) {
		timeout++;
		vdp2_sync();
		vdp2_sync_wait();
	}

	if (timeout >= 300)
		sprintf(pReplyBuf,"Tm%x %x %x",FSSTAT[0],FSSTAT[1],pWascaRegs[9]);
	else
		FSCNTRL[0] = 0;
	//going back to idle\
	//FSCNTRL[0] = 0;
	//video_vdp2_set_cycle_patterns_cpu(screenMode);
}

void draw_panel(int x_offset) {
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
	draw_string(" 0:/ ",x_offset+18,0,2);
	//test files
	/*draw_string("..",x_offset+1,2,0);
	draw_string("\x10UP--DIR\x11",x_offset+21,2,0);
	draw_string("00.00.00",x_offset+31,2,0);
	draw_string("SomeFolder",x_offset+1,3,0);
	draw_string("\x10SUB-DIR\x11",x_offset+21,3,0);
	draw_string("11.11.22",x_offset+31,3,0);
	draw_string("SomeFile.lza",x_offset+1,4,0);
	draw_string("   100500",x_offset+21,4,0);
	draw_string("02.05.96",x_offset+31,4,0);*/

	//reading files
	//issuing first list command for root folder 
	if (0 == wasca_found)
		pReplyBuf = (uint8_t*)LWRAM(0);
	sprintf(pReplyBuf,"No Reply");
	execute_command("LIST /");
	int line = 2;
	char * ptr = pReplyBuf;
	if (0 == memcmp("OK name=",pReplyBuf,7)) {
		ptr = &(pReplyBuf[9]);
		ptr[strlen(ptr)-1] = 0;
	}
	if (strlen(ptr)>20) 
		ptr[20] = 0;
	draw_string(ptr,x_offset+1,line,0);
	draw_string("    ????",x_offset+21,line,0);
	draw_string("??.??.??",x_offset+31,line,0);
	line++;
	while ((strlen(pReplyBuf))&&(line<20)) {
		execute_command("LIST");
		ptr = pReplyBuf;
		if (0 == memcmp("OK name=",pReplyBuf,7)) {
			ptr = &(pReplyBuf[9]);
			ptr[strlen(ptr)-1] = 0;
		}
		if (strlen(ptr)>20) 
			ptr[20] = 0;
		draw_string(ptr,x_offset+1,line,0);
		draw_string("????",x_offset+21,line,0);
		draw_string("??.??.??",x_offset+31,line,0);
		line++;
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


int main(void)
{
	char string_buf[128];
	uint16_t counter;

	video_init(screenMode,false);

	video_vdp2_clear_palette(0);

	video_vdp2_set_cycle_patterns_cpu(screenMode);

	FSCNTRL[0] = 0xFFFF;

	//load 8x16 font to VDP2 tiles
    uint8_t * p8 = (uint8_t *)VIDEO_VDP2_NBG0_CHPNDR_START;
	for (int i=0;i<256;i++) {
		for (int j=0;j<128;j++) {
			p8[i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 2:1; //cyan on blue
			p8[1*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 3:0; //gray on black
			p8[2*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 0:4; //black on greenish
			p8[3*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 6:5; //white on lightgray
			p8[4*256*128 + i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 7:1; //yellow on blue
		}
	}

	draw_screen();

	//checking wasca signature
	p8 = (uint8_t *)CS0(0x1FFFFFA);
	if (memcmp(p8,"wasca ",6)) {
		char _buf[32];
		//sprintf(_buf,"id:%x %x %x %x %x %x",p8[0],p8[1],p8[2],p8[3],p8[4],p8[5]);
		draw_dialogbox("wasca cartridge not detected!",3);
		//draw_dialogbox(_buf,3);
		//while (1); //freeze
		wasca_found = 0;
	} else {
		wasca_found = 1;
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
	
	int current_item = 0;
	int preparing = 0;
	int go_reboot = 0;
	int go_multiplayer = 0;

	//DrawString("Text", 100, 100, FONT_WHITE);
	
	while(true)
	{
		vdp2_tvmd_vblank_out_wait();
		smpc_peripheral_process();
		get_digital_keypress_anywhere(&controller);
		
		if(controller.pressed.button.up) {
			wait_for_key_unpress();
			current_item--;
			if (current_item < 0)
				current_item = list_size - 1;				
		}
		if(controller.pressed.button.down) {
			wait_for_key_unpress();
			current_item++;
			if (current_item >= list_size)
				current_item = 0;				
		}
		if ((preparing == 0) && (controller.pressed.button.a)) {
			wait_for_key_unpress();
			pWascaRegs[10] = current_item+1;
			preparing = 1;
			go_reboot = 1;
		}
		if ((preparing == 0) && (controller.pressed.button.b)) {
			wait_for_key_unpress();
			preparing = 2;
			go_multiplayer = 1;
		}
		if ((preparing == 0) && (controller.pressed.button.c)) {
			wait_for_key_unpress();
			pWascaRegs[10] = current_item+1;
			preparing = 1;
			go_multiplayer = 1;
		}
		
		if (preparing == 1) {
			counter = pWascaRegs[8];
			ClearText(70+strlen("Loading: ")*_fw,(list_size+8)*_fh,3*_fw,_fh);
			sprintf(string_buf,"Loading: %3d percents     ",counter);
			DrawString(string_buf, 70, (list_size+8)*_fh, FONT_WHITE);
			if (counter == 100)
				preparing = 2;
		}

		if (preparing == 2) {
			ClearText(70+strlen("Loading: ")*_fw,(list_size+8)*_fh,15*_fw,_fh);
			sprintf(string_buf,"Loading: complete");
			DrawString(string_buf, 70, (list_size+8)*_fh, FONT_WHITE);

			preparing = 0;
			if (go_reboot)
				bios_execute();
			else if (go_multiplayer)
				bios_cd_player_execute();
		}

		vdp2_sync();
		vdp2_sync_wait();
	}
}

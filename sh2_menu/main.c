#include <yaul.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "font.h"
#include "input.h"
#include "video.h"
#include "control.h"
#include "video_vdp2.h"

#define MENU_VERSION_MAJOR 1
#define MENU_VERSION_MINOR 2

int global_frame_count = 0;
int current_menu_page = 0;
int recents_count;
int roms_count;

static void suite_vblank_out_handler(void *work __unused)
{
    global_frame_count++;
    
    if (0==video_is_inited())
        return;
    
    smpc_peripheral_intback_issue();
}

uint32_t NextRandom(uint32_t prev) {
	if (((prev & 0x80000000) / 0x80000000) ^ ((prev & 0x40000000) / 0x40000000)
			^ ((prev & 0x10) / 0x10) ^ ((prev & 0x8) / 0x8))
		return (prev & 0x7FFFFFFF) * 2 + 1;
	else
		return (prev & 0x7FFFFFFF) * 2;
}

void get_version_string(char * buf) {
	uint16_t* pWascaRegs = (uint16_t*)0x23FFFFE0;
	sprintf(buf, "v.%d.%d RISC-V %d.%d HW %d.%d",MENU_VERSION_MAJOR,MENU_VERSION_MINOR,
		pWascaRegs[12]/256,pWascaRegs[12]%256,
		pWascaRegs[11]/256,pWascaRegs[11]%256);
}

void redraw_menu (int current_item) {
	char string_buf[128];
	int x = 20;
	int y = 10;
	uint8_t* pRecentList = (uint8_t*)0x22fffff0;
	uint8_t* pAdvertiseList = (uint8_t*)0x23000000;
	int offset;
	int item;

	ClearTextLayer();

	switch (current_menu_page) {
		case 0:
			DrawString("wasca menu", x+40, y, FONT_WHITE);
			get_version_string(string_buf);
			DrawString(string_buf, x+40+12*_fw, y, FONT_CYAN);y+=_fh;
			
			//top level menu
			y+=_fh;
			offset = 1;
			item = 0;
			//drawing recent options
			for (int i=0;i<recents_count;i++) {
				if (pRecentList[i]) {
					offset = 1+64*pRecentList[i]-64;
					sprintf(string_buf,"%i. %s", pAdvertiseList[offset],&(pAdvertiseList[offset+1]));
					DrawString(string_buf, x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;
					item++; 
				}
			}
			DrawString("<Backup options>", x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;item++;
			DrawString("<RAM options>", x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;item++;
			DrawString("<PSKAI options>", x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;item++;
			DrawString("<ROMs>", x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;item++;
			y+=_fh;
			if (current_item < 4) {
				DrawString("A : Select and reboot", x+10, y, FONT_WHITE);y+=_fh;
				DrawString("B : Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
				DrawString("C : Select and Multiplayer)", x+10, y, FONT_WHITE);y+=_fh;
			} else {
				DrawString("A : Enter               ", x+10, y, FONT_WHITE);y+=_fh;
				DrawString("B : Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
				DrawString("C : Enter                  ", x+10, y, FONT_WHITE);y+=_fh;
			}
			break;
		case 1:
			DrawString("Backup", x+40, y, FONT_WHITE);
			get_version_string(string_buf);
			DrawString(string_buf, x+40+12*_fw, y, FONT_CYAN);y+=_fh;
			y+=_fh;
			offset = 1;
			item = 0;
			for (int i=0;i<4;i++) {
				sprintf(string_buf,"%i. %s", pAdvertiseList[offset],&(pAdvertiseList[offset+1]));
				DrawString(string_buf, x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;
				item++; 
				offset+=64;
			}
			y+=_fh;
			DrawString("A : Select and reboot", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("B : Go back", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("C : Select and Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
			break;
		case 2:
			DrawString("RAM", x+40, y, FONT_WHITE);
			get_version_string(string_buf);
			DrawString(string_buf, x+40+12*_fw, y, FONT_WHITE);y+=_fh;
			y+=_fh;
			offset = 1+64*4;
			item = 0;
			for (int i=0;i<4;i++) {
				sprintf(string_buf,"%i. %s", pAdvertiseList[offset],&(pAdvertiseList[offset+1]));
				DrawString(string_buf, x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;
				item++; 
				offset+=64;
			}
			y+=_fh;
			DrawString("A : Select and reboot", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("B : Go back", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("C : Select and Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
			break;
		case 3:
			DrawString("PSKAI", x+40, y, FONT_WHITE);
			get_version_string(string_buf);
			DrawString(string_buf, x+40+12*_fw, y, FONT_WHITE);y+=_fh;
			y+=_fh;
			offset = 1+64*8;
			item = 0;
			for (int i=0;i<8;i++) {
				sprintf(string_buf,"%i. %s", pAdvertiseList[offset],&(pAdvertiseList[offset+1]));
				DrawString(string_buf, x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;
				item++; 
				offset+=64;
			}
			y+=_fh;
			DrawString("A : Select and reboot", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("B : Go back", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("C : Select and Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
			break;
		case 4:
			DrawString("ROMs", x+40, y, FONT_WHITE);
			get_version_string(string_buf);
			DrawString(string_buf, x+40+12*_fw, y, FONT_WHITE);y+=_fh;
			y+=_fh;
			offset = 1+64*16;
			item = 0;
			while ((pAdvertiseList[offset] != 0) &&(item < 15)) {
				sprintf(string_buf,"%i. %s", pAdvertiseList[offset],&(pAdvertiseList[offset+1]));
				DrawString(string_buf, x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;
				item++; 
				offset+=64;
			}
			y+=_fh;
			DrawString("A : Select and reboot", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("B : Go back", x+10, y, FONT_WHITE);y+=_fh;
			DrawString("C : Select and Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
			break;
	}

	



}

int main(void)
{
	char string_buf[128];
	uint16_t counter;

	video_screen_mode_t screenMode =
	{
		.scanmode = VIDEO_SCANMODE_240P,
		.x_res = VIDEO_X_RESOLUTION_320,
		.y_res = VDP2_TVMD_VERT_240,
		.x_res_doubled = false,
		.colorsystem = VDP2_TVMD_TV_STANDARD_NTSC,
	};

	video_init(screenMode,false);
	//video_vdp2_set_cycle_patterns_cpu();
	video_vdp2_set_cycle_patterns_nbg(screenMode);

	video_vdp2_clear_palette(0);
	SetFontPalette();

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
	roms_count = 0;
	while ((pAdvertiseList[offset] != 0) &&(list_size < 32)) {
		list_size++; 
		offset+=64;		
		if (memcmp(&pAdvertiseList[offset+1],"ROM",3)==0)
			roms_count++;
	}
	if (roms_count > 16)
		roms_count = 16;
	
	int current_item = 0;
	int preparing = 0;
	int go_reboot = 0;
	int go_multiplayer = 0;
	int redraw_menu_flag = 1;
	uint16_t* pWascaRegs = (uint16_t*)0x23FFFFE0;

	uint8_t* pRecentList = (uint8_t*)0x22FFFFF0;
	recents_count = 0;
	while ( (pRecentList[recents_count] != 0) && (recents_count<4) )
		recents_count++;

	int menu_page_size;
	int cs0_needs_purge = 0;
	
	while(true)
	{
		vdp2_tvmd_vblank_out_wait();
		smpc_peripheral_process();
		get_digital_keypress_anywhere(&controller);

		switch(current_menu_page) {
			case 0:
				menu_page_size = recents_count+4;
				break;
			case 1:
			case 2:
				menu_page_size = 4;
				break;
			case 3:
				menu_page_size = 8;
				break;
			case 4:
				menu_page_size = roms_count;
				break;
		}
		
		if(controller.pressed.button.up) {
			wait_for_key_unpress();
			current_item--;
			if (current_item < 0)
				current_item = menu_page_size - 1;				
			redraw_menu_flag = 1;
		}
		if(controller.pressed.button.down) {
			wait_for_key_unpress();
			current_item++;
			if (current_item >= menu_page_size)
				current_item = 0;				
			redraw_menu_flag = 1;
		}
		if ((preparing == 0) && (controller.pressed.button.a)) {
			wait_for_key_unpress();
			switch(current_menu_page) {
				case 0:
					if (current_item < recents_count) {
						//recent item
						pWascaRegs[10] = pRecentList[current_item];
						ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
						preparing = 1;
						go_reboot = 1;
						if (pRecentList[current_item]<9)
							cs0_needs_purge = 1;
					} else {
						current_menu_page = current_item-recents_count+1;
						current_item = 0;
						redraw_menu_flag = 1;
					}
					break;
				case 1:
					//backup modes
					pWascaRegs[10] = current_item+1;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_reboot = 1;
					cs0_needs_purge = 1;
					break;
				case 2:
					//RAM modes
					pWascaRegs[10] = current_item+5;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_reboot = 1;
					cs0_needs_purge = 1;
					break;
				case 3:
					//PSKAI modes
					pWascaRegs[10] = current_item+9;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_reboot = 1;
					break;
				case 4:
					//ROM modes
					pWascaRegs[10] = current_item+17;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_reboot = 1;
					break;
			}
		}
		if ((preparing == 0) && (controller.pressed.button.b)) {
			wait_for_key_unpress();
			switch(current_menu_page) {
				case 0:
					preparing = 2;
					go_multiplayer = 1;
					break;
				default:
					current_menu_page = 0;
					redraw_menu_flag = 1;
			}
		}
		if ((preparing == 0) && (controller.pressed.button.c)) {
			wait_for_key_unpress();
			switch(current_menu_page) {
				case 0:
					if (current_item < recents_count) {
						//recent item
						pWascaRegs[10] = pRecentList[current_item];
						ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
						preparing = 1;
						go_multiplayer = 1;
						if (pRecentList[current_item]<9)
							cs0_needs_purge = 1;
					} else {
						current_menu_page = current_item-recents_count+1;
						current_item = 0;
						redraw_menu_flag = 1;
					}
					break;
				case 1:
					//backup modes
					pWascaRegs[10] = current_item+1;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_multiplayer = 1;
					cs0_needs_purge = 1;
					break;
				case 2:
					//RAM modes
					pWascaRegs[10] = current_item+5;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_multiplayer = 1;
					cs0_needs_purge = 1;
					break;
				case 3:
					//PSKAI modes
					pWascaRegs[10] = current_item+9;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_multiplayer = 1;
					break;
				case 4:
					//ROM modes
					pWascaRegs[10] = current_item+17;
					ClearText(10,(menu_page_size+4)*_fh,280,_fh*3);
					preparing = 1;
					go_multiplayer = 1;
					break;
			}

		}

		if (preparing == 1) {
			counter = pWascaRegs[8];
			ClearText(70+strlen("Loading: ")*_fw,(menu_page_size+5)*_fh,3*_fw,_fh);
			sprintf(string_buf,"Loading: %3d percents     ",counter);
			DrawString(string_buf, 70, (menu_page_size+5)*_fh, FONT_WHITE);
			if (counter == 100)
				preparing = 2;
		}

		if (preparing == 2) {
			ClearText(70+strlen("Loading: ")*_fw,(menu_page_size+5)*_fh,15*_fw,_fh);
			sprintf(string_buf,"Loading: complete");
			DrawString(string_buf, 70, (menu_page_size+5)*_fh, FONT_WHITE);

			preparing = 0;

			if (cs0_needs_purge) {
				//purge cache to prevent reading old data
				cpu_cache_purge();
				//write, somehow data is not updated otherwise
				volatile uint8_t* pCS0 = (uint8_t*)0x22000000;
				for (int i=0;i<4096;i++)
					pCS0[i] = 0;
			}

			if (go_reboot) {
				bios_execute();
			}
			else if (go_multiplayer)
				bios_cd_player_execute();
		}

		if (preparing == 0)
			if (redraw_menu_flag) {
				redraw_menu(current_item);
				redraw_menu_flag = 0;
			}

		vdp2_sync();
		vdp2_sync_wait();
	}
}

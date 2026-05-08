/* 
 * 240p Test Suite for Nintendo 64
 * Copyright (C)2018 Artemio Urbina
 *
 * This file is part of the 240p Test Suite
 *
 * The 240p Test Suite is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * The 240p Test Suite is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with 240p Test Suite; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA	02111-1307	USA

 * 240p Test Suite for Sega Saturn
 * Copyright (c) 2018 Artemio Urbina
 * See LICENSE for details.
 * Uses libyaul
 */

#include <yaul.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "font.h"
#include "input.h"
#include "video.h"
#include "control.h"
#include "video_vdp2.h"

int global_frame_count = 0;

static void suite_vblank_out_handler(void *work __unused)
{
    global_frame_count++;
    
    if (0==video_is_inited())
        return;
    
    smpc_peripheral_intback_issue();
}

uint32_t NextRandom(uint32_t prev) {
	//return (prev+0x10001);
	if (((prev & 0x80000000) / 0x80000000) ^ ((prev & 0x40000000) / 0x40000000)
			^ ((prev & 0x10) / 0x10) ^ ((prev & 0x8) / 0x8))
		return (prev & 0x7FFFFFFF) * 2 + 1;
	else
		return (prev & 0x7FFFFFFF) * 2;
}

void redraw_menu (int current_item) {
	char string_buf[128];
	int x = 20;
	int y = 10;
	uint8_t* pAdvertiseList = (uint8_t*)0x23000000;

	DrawString("wasca boot menu", x+40, y, FONT_WHITE);y+=_fh;
	y+=_fh;
	int offset = 1;
	int item = 0;
	while ((pAdvertiseList[offset] != 0) &&(item < 24)) {
		sprintf(string_buf,"%i. %s", pAdvertiseList[offset],&(pAdvertiseList[offset+1]));
		DrawString(string_buf, x, y, (item == current_item) ? FONT_GREEN : FONT_WHITE);y+=_fh;
		item++; 
		offset+=64;
	}
	
	y+=_fh;
	DrawString("A : Select and reboot", x+10, y, FONT_WHITE);y+=_fh;
	DrawString("B : Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
	DrawString("C : Select and Multiplayer", x+10, y, FONT_WHITE);y+=_fh;
}

int main(void)
{
	int sel = 0;
	bool redrawMenu = true, redrawBG = true, key_pressed = false;
	int menu_size=0;
	char string_buf[128];

	video_screen_mode_t screenMode =
	{
		.scanmode = VIDEO_SCANMODE_240P,
		.x_res = VIDEO_X_RESOLUTION_320,
		.y_res = VDP2_TVMD_VERT_240,
		.x_res_doubled = false,
		.colorsystem = VDP2_TVMD_TV_STANDARD_NTSC,
	};

	//show yaul logo in 240p
	video_init(screenMode,false);
	video_vdp2_set_cycle_patterns_cpu();
	//background_set_from_assets(asset_bootlogo_bg,(int)(asset_bootlogo_bg_end-asset_bootlogo_bg),VIDEO_VDP2_NBG0_PNDR_START,VIDEO_VDP2_NBG0_CHPNDR_START);
	video_vdp2_set_cycle_patterns_nbg(screenMode);

	//wait for 60 frames, either 1s or 1.2s
//	for (int i=0;i<60;i++)
//		vdp2_tvmd_vblank_in_next_wait(1);

	//background_fade_to_black();

	//show ponesound logo in 240p
	video_vdp2_set_cycle_patterns_cpu();
//	background_set_from_assets(asset_ponesnd_bg,(int)(asset_ponesnd_bg_end-asset_ponesnd_bg),VIDEO_VDP2_NBG0_PNDR_START,VIDEO_VDP2_NBG0_CHPNDR_START);
	video_vdp2_set_cycle_patterns_nbg(screenMode);

	//wait for 60 frames, either 1s or 1.2s
//	for (int i=0;i<60;i++)
//		vdp2_tvmd_vblank_in_next_wait(1);

	//background_fade_to_black();

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

	redrawMenu = true;
	redrawBG = true;

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
	//redraw_menu(current_item);
	int preparing = 0;
	int go_reboot = 0;
	int go_multiplayer = 0;
	uint16_t* pWascaRegs = (uint16_t*)0x23FFFFE0;
	
	while(true)
	{
		vdp2_tvmd_vblank_out_wait();
		smpc_peripheral_process();
		get_digital_keypress_anywhere(&controller);
		
		if(controller.pressed.button.up) {
			current_item--;
			if (current_item < 0)
				current_item = list_size - 1;				
		}
		if(controller.pressed.button.down) {
			current_item++;
			if (current_item >= list_size)
				current_item = 0;				
		}
		if ((preparing == 0) && (controller.pressed.button.a)) {
			preparing = 1;
			go_reboot = 1;
		}
		if ((preparing == 0) && (controller.pressed.button.b)) {
			preparing = 2;
			go_multiplayer = 1;
		}
		if ((preparing == 0) && (controller.pressed.button.c)) {
			preparing = 1;
			go_multiplayer = 1;
		}
		
		if (preparing == 1) {
			sprintf(string_buf,"Loading, %d%%     ",pWascaRegs[8]);
			DrawString(string_buf, 70, (list_size+8)*_fh, FONT_WHITE);
			if (pWascaRegs[8] == 100)
				preparing = 2;
		}
		
		if (preparing == 2) {
			if (go_reboot)
				bios_execute();
			if (go_multiplayer)
				bios_cd_player_execute();
				//exit();
		}

		redraw_menu(current_item);
		vdp2_sync();
		vdp2_sync_wait();
		wait_for_key_unpress();
	}
}

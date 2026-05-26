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
extern const uint8_t PC_FACE_MODERNDOS_8X16_FONT_LIST[256][16];

static void suite_vblank_out_handler(void *work __unused)
{
    global_frame_count++;
    
    if (0==video_is_inited())
        return;
    
    smpc_peripheral_intback_issue();
}

void draw_char(uint8_t char_code, int  x, int y, int palette) {
	uint32_t * p32 = (uint32_t *)VIDEO_VDP2_NBG0_PNDR_START;
	p32[y*128+x] = 2*(palette*512+char_code*2);
	p32[y*128+64+x] = 2*(palette*512+char_code*2+1);
}

int main(void)
{
	char string_buf[128];
	uint16_t counter;

	video_screen_mode_t screenMode =
	{
		.scanmode = VIDEO_SCANMODE_480I,
		.x_res = VIDEO_X_RESOLUTION_320,
		.y_res = VDP2_TVMD_VERT_240,
		.x_res_doubled = true,
		.colorsystem = VDP2_TVMD_TV_STANDARD_NTSC,
	};

	video_init(screenMode,false);

	video_vdp2_clear_palette(0);

	video_vdp2_set_cycle_patterns_cpu(screenMode);
	//load 8x16 font to VDP2 tiles
    uint8_t * p8 = (uint8_t *)VIDEO_VDP2_NBG0_CHPNDR_START;
	for (int i=0;i<256;i++) {
		for (int j=0;j<128;j++) {
			p8[i*128+j] = (PC_FACE_MODERNDOS_8X16_FONT_LIST[i][j/8]&(1<<(7-j%8))) ? 2:1;
		}
	}

	//draw font
	for (int y=0;y<8;y++)
		for (int x=0;x<32;x++)
			draw_char(y*32+x,x,y,0);

    /*uint32_t * p32 = (uint32_t *)VIDEO_VDP2_NBG0_PNDR_START;
	for (int y=0;y<8;y++) {
		for (int x=0;x<32;x++) {
			p32[y*128+x] = 2*(y*64+x*2);
			p32[y*128+64+x] = 2*(y*64+x*2+1);
		}
	}*/
	
	video_vdp2_set_cycle_patterns_nbg(screenMode);

	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0, 0, 0), 0, 0);//black
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0, 0, 0xAA), 1, 1);//blue
	video_vdp2_set_palette_part(FONT_PALETTE, &RGB888(1, 0, 0xAA, 0xAA), 2, 2);//cyan
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
	uint16_t* pWascaRegs = (uint16_t*)0x23FFFFE0;

	DrawString("Text", 100, 100, FONT_WHITE);
	
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

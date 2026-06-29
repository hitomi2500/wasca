/* 
 * wasca cartridge test
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
int x;
int y;


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

void write_test_data (void * address, int size, int bits) {
	uint32_t seed = 100500;
	uint8_t* p8 = (uint8_t*)address;
	uint16_t* p16 = (uint16_t*)address;
	uint32_t* p32 = (uint32_t*)address;
	if (8 == bits) {
		for (int addr = 0; addr < size; addr++)
		{
			p8[addr] = seed;
			seed = NextRandom(seed);
		}
	} else if (16 == bits) {
		for (int addr = 0; addr < (size/2); addr++)
		{
			p16[addr] = seed;
			seed = NextRandom(seed);
		}
	} else if (32 == bits) {
		for (int addr = 0; addr < (size/4); addr++)
		{
			p32[addr] = seed;
			seed = NextRandom(seed);
		}
	}
}

int verify_test_data (void * address, int size, int bits) {
	uint32_t seed = 100500;
	uint32_t seed32,readen32;
	uint16_t seed16,readen16;
	uint8_t seed8,readen8;
	uint8_t* p8 = (uint8_t*)address;
	uint16_t* p16 = (uint16_t*)address;
	uint32_t* p32 = (uint32_t*)address;
	char string_buf[128];
	int errors = 0;
	if (8 == bits) {
		for (int addr =0; addr < size; addr++)
		{
			seed8 = seed;
			readen8 = p8[addr];
			if (readen8 != seed8){
				errors++;
				if (errors<5) {
					sprintf(string_buf,"8 ERR : addr %x write %x read %x",&(p16[addr]),seed8,readen8);
					DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
				}
			}
			seed = NextRandom(seed);
		}
	} else if (16 == bits) {
		for (int addr =0; addr < size/2; addr++)
		{
			seed16 = seed;
			readen16 = p16[addr];
			if (readen16 != seed16){
				errors++;
				if (errors<5) {
					sprintf(string_buf,"16 ERR : addr %x write %x read %x",&(p16[addr]),seed16,readen16);
					DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
				}
			}
			seed = NextRandom(seed);
		}
	} else if (32 == bits) {
		for (int addr =0; addr < size/4; addr++)
		{
			seed32 = seed;
			readen32 = p32[addr];
			if (readen32 != seed32){
				errors++;
				if (errors<5) {
					sprintf(string_buf,"32 ERR : addr %x write %x read %x",&(p32[addr]),seed32,readen32);
					DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
				}
			}
			seed = NextRandom(seed);
		}
	}
	return errors;
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

	video_init(screenMode,false);
	video_vdp2_set_cycle_patterns_nbg(screenMode);

	video_vdp2_clear_palette(0);
	SetFontPalette();

	//detect color system
	screenMode.colorsystem = vdp2_tvmd_tv_standard_get();

	redrawMenu = true;
	redrawBG = true;
	x = 10;
	y = 10;

	//register vblank handler
	vdp_sync_vblank_out_set(suite_vblank_out_handler, NULL);
	
	//check if wasca cart is present
	unsigned char * pSignature = (unsigned char *)0x23FFFFFA;
	if (memcmp(pSignature,"wasca ",6)) {
		DrawString("wasca cartridge not found, aborting test", x, y, FONT_WHITE);y+=_fh;
		while(true)
		{
			vdp2_tvmd_vblank_out_wait();
			vdp2_sync();
			vdp2_sync_wait();
		}
	}

	//setup CS0+CS1
	uint32_t* pCS = (uint32_t*)0x25fe00b0;
	pCS[0] = 0x02201220;
	//pCS[0] = 0x03301220;
	pCS[2] = 0x0;
	sprintf(string_buf,"CS0+1 setup : %x %x",pCS[0], pCS[2]);
	DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;

	int errors = 0;
	int CS0_Test_Size = 32*1024*1024 - 4096; //excluding wasca system area and filesystem buffers at the end of CS0

	//DrawString("CS0 x8 test ...", x, y, FONT_WHITE);y+=_fh;
	write_test_data(CS0(0),CS0_Test_Size,8);
	vdp2_sync();
	vdp2_sync_wait();
	errors = verify_test_data(CS0(0),CS0_Test_Size,8);
	if (errors) {
		sprintf(string_buf,"CS0 x8 test FAILED, %d errors",errors);
		DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
	} else
		DrawString("CS0 x8 test OK", x, y, FONT_WHITE);y+=_fh;

	//DrawString("CS0 x16 test ...", x, y, FONT_WHITE);y+=_fh;
	write_test_data(CS0(0),CS0_Test_Size,16);
	vdp2_sync();
	vdp2_sync_wait();
	errors = verify_test_data(CS0(0),CS0_Test_Size,16);
	if (errors) {
		sprintf(string_buf,"CS0 x16 test FAILED, %d errors",errors);
		DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
	} else
		DrawString("CS0 x16 test OK", x, y, FONT_WHITE);y+=_fh;
	
	//DrawString("CS0 x32 test ...", x, y, FONT_WHITE);y+=_fh;
	write_test_data(CS0(0),CS0_Test_Size,32);
	vdp2_sync();
	vdp2_sync_wait();
	errors = verify_test_data(CS0(0),CS0_Test_Size,32);
	if (errors) {
		sprintf(string_buf,"CS0 x32 test FAILED, %d errors",errors);
		DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
	} else
		DrawString("CS0 x32 test OK", x, y, FONT_WHITE);y+=_fh;


	int CS1_Test_Size = 16*1024*1024-4; //excluding ID register

	//DrawString("CS1 x8 test ...", x, y, FONT_WHITE);y+=_fh;
	write_test_data(CS1(0),CS1_Test_Size,8);
	vdp2_sync();
	vdp2_sync_wait();
	errors = verify_test_data(CS1(0),CS1_Test_Size,8);
	if (errors) {
		sprintf(string_buf,"CS1 x8 test FAILED, %d errors",errors);
		DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
	} else
		DrawString("CS1 x8 test OK", x, y, FONT_WHITE);y+=_fh;

	//DrawString("CS1 x16 test ...", x, y, FONT_WHITE);y+=_fh;
	write_test_data(CS1(0),CS1_Test_Size,16);
	vdp2_sync();
	vdp2_sync_wait();
	errors = verify_test_data(CS1(0),CS1_Test_Size,16);
	if (errors) {
		sprintf(string_buf,"CS1 x16 test FAILED, %d errors",errors);
		DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
	} else
		DrawString("CS1 x16 test OK", x, y, FONT_WHITE);y+=_fh;
	
	//DrawString("CS1 x32 test ...", x, y, FONT_WHITE);y+=_fh;
	write_test_data(CS1(0),CS1_Test_Size,32);
	vdp2_sync();
	vdp2_sync_wait();
	errors = verify_test_data(CS1(0),CS1_Test_Size,32);
	if (errors) {
		sprintf(string_buf,"CS1 x32 test FAILED, %d errors",errors);
		DrawString(string_buf, x, y, FONT_WHITE);y+=_fh;
	} else
		DrawString("CS1 x32 test OK", x, y, FONT_WHITE);y+=_fh;

	
	while(true)
	{
		vdp2_tvmd_vblank_out_wait();
		smpc_peripheral_process();
		get_digital_keypress_anywhere(&controller);


		vdp2_sync();
		vdp2_sync_wait();
	}
}

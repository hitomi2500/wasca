#include <yaul.h>

#include "control.h"

smpc_peripheral_digital_t controller;

void InitControllers()
{
	smpc_init();
	smpc_peripheral_init();
}

void wait_for_key_press()
{
	//wait for keypress
	while (controller.pressed.raw == 0)
	{
		vdp2_tvmd_vblank_out_wait();
		smpc_peripheral_process();
		get_digital_keypress_anywhere(&controller);
	}
}

void wait_for_key_unpress()
{
	//wait for unpress
	while (controller.pressed.raw != 0)
	{
		vdp2_tvmd_vblank_out_wait();
		smpc_peripheral_process();
		get_digital_keypress_anywhere(&controller);
	}
}

void wait_for_next_key()
{
	wait_for_key_unpress();
	wait_for_key_press();
	wait_for_key_unpress();
}

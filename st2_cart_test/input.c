#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <yaul.h>
#include "font.h"
#include "video_vdp2.h"
#include "control.h"

void get_digital_keypress_anywhere(smpc_peripheral_digital_t *digital)
{
	volatile smpc_peripheral_digital_t tmp_digital;
	volatile smpc_peripheral_analog_t tmp_analog;
	smpc_peripheral_t *peripheral;
	smpc_peripheral_t *tmp_peripheral;
	digital->pressed.raw = 0;
	tmp_digital.pressed.raw = 0;
    int y=100;
    char buf[128];
    char buf2[32];

	//collecting all keypresses, returning the last one
	for (int port = 1; port <3; port++)
	{
		const smpc_peripheral_port_t * const _port = smpc_peripheral_raw_port(port);

		if (ID_DIGITAL == _port->peripheral->type) {
			smpc_peripheral_digital_get(_port->peripheral,&tmp_digital);
			if (tmp_digital.pressed.raw) {
				digital[0] = tmp_digital;
			}
		} else if (ID_ANALOG == _port->peripheral->type) {
			smpc_peripheral_analog_get(_port->peripheral,&tmp_analog);
			tmp_digital.connected = tmp_analog.connected;
			tmp_digital.pressed.raw = (tmp_analog.pressed.raw[0] << 8) | (tmp_analog.pressed.raw[1] & 0xF8);
			if (tmp_digital.pressed.raw) {
				digital[0] = tmp_digital;
			}
		}
		//now the list	
		for (peripheral = TAILQ_FIRST(&_port->peripherals);
			(peripheral != NULL) && (tmp_peripheral = TAILQ_NEXT(peripheral, peripherals), 1);
           	peripheral = tmp_peripheral) {
				if (ID_DIGITAL == peripheral->type) {
					smpc_peripheral_digital_get(peripheral,&tmp_digital);
					if (tmp_digital.pressed.raw) {
						digital[0] = tmp_digital;
					}
				} else if (ID_ANALOG == peripheral->type) {
					smpc_peripheral_analog_get(peripheral,&tmp_analog);
					tmp_digital.connected = tmp_analog.connected;
					tmp_digital.pressed.raw = (tmp_analog.pressed.raw[0] << 8) | (tmp_analog.pressed.raw[1] & 0xF8);
					if (tmp_digital.pressed.raw) {
						digital[0] = tmp_digital;
					}
				}
			}
	}
}
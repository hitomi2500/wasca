#ifndef CONTROL_H
#define CONTROL_H

extern smpc_peripheral_digital_t controller;

void InitControllers();
void wait_for_key_press();
void wait_for_key_unpress();
void wait_for_next_key();

#endif /* !CONTROL_H */

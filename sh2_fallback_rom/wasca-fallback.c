#include <assert.h>
#include <stdlib.h>

char message[] = "Wasca : boot error.";
int message_len = 19;//not using strlen to keep the binary size minimal

int
start(void)
{
        int i;
        unsigned short * pVDP2_index = (unsigned short*)0x25e06208;
        for (i=0;i<message_len; i++) {
                pVDP2_index[i] = message[i]<<1;
                pVDP2_index[i+0x40] = (message[i]<<1) | 0x1;
        }
        while(1);
}

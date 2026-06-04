#include <assert.h>
#include <stdlib.h>

char message[] = "wasca boot error";

int
start(void)
{
        int i=0;
        unsigned short * pVDP2_index = (unsigned short*)0x25e06208;
		while (message[i]!=0){
                pVDP2_index[i] = message[i]<<1;
                pVDP2_index[i+0x40] = (message[i]<<1) | 0x1;
				i++;
        }
        while(1);
}

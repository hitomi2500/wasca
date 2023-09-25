#include <stdint.h>

#define LED (*(volatile uint32_t*)0x02000000)

#define reg_uart_clkdiv (*(volatile uint32_t*)0x02000004)
#define reg_uart_data (*(volatile uint32_t*)0x02000008)

void putchar(char c)
{
    if (c == '\n')
        putchar('\r');
    reg_uart_data = c;
}

void print(const char *p)
{
    while (*p)
        putchar(*(p++));
}

void delay() {
    for (volatile int i = 0; i < 2500000; i++)
        ;
}


uint32_t lsfr_next_random (uint32_t prev)
{
	if ( ((prev&0x80000000)/0x80000000)^((prev&0x40000000)/0x40000000)^((prev&0x10)/0x10)^((prev&0x8)/0x8) )
		return  (prev & 0x7FFFFFFF)* 2 + 1;
	else 
		return  (prev & 0x7FFFFFFF)* 2;
}

int main() {
	uint32_t* p32 = (uint32_t*) 0;
	uint32_t seed = 0x100500;
	uint32_t errors = 0;
	int i;
    // 115200 baud at 133MHz
    reg_uart_clkdiv = 1155;
    while (1) {
        LED = 0xFF;
        print("hello world\n");
        delay();
        LED = 0x00;
        delay();
		print("Verifying ram beyond 0x1000\n");
		//writing
		i = 0x1000/sizeof(uint32_t);
		seed = 0x100500;
		while ( i < (0x10000/sizeof(uint32_t)) )
		{
			p32[i] = seed;
			i++;
			seed = lsfr_next_random(seed);
		}
		//reading
		i = 0x1000/sizeof(uint32_t);
		seed = 0x100500;
		errors = 0;
		while ( i < (0x10000/sizeof(uint32_t)) )
		{
			if (p32[i] != seed)
			{
				errors++;
				if (errors < 10)
				{
					uint32_t addr = i*sizeof(uint32_t);
					print("Error at address ");
					for (int j=0;j<8;j++)
					{
						uint8_t code = (addr&(0xF0000000>>(j*4))) >> ((7-j)*4);
						if (code < 10)
							putchar(code+'0');
						else 
							putchar(code+'A'-10);
					}
					print("\n");
				}
			}
			i++;
			seed = lsfr_next_random(seed);
		}
		print("Verifying complete\n");
    }
}

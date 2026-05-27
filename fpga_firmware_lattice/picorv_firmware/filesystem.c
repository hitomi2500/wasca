#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "fatfs/ff.h"
#include "fatfs/sdiodrv.h"
#include "fatfs/diskio.h"
#include "mini-printf.h"

#define LED_OFF 0x0
#define LED_EXT_RED 0x20
#define LED_EXT_GREEN 0x10
#define LED_EXT_BLUE 0x8
#define LED_EXT_CYAN (LED_EXT_GREEN | LED_EXT_BLUE)
#define LED_EXT_MAGENTA (LED_EXT_RED | LED_EXT_BLUE)
#define LED_EXT_YELLOW (LED_EXT_RED | LED_EXT_GREEN)
#define LED_EXT_WHITE (LED_EXT_RED | LED_EXT_GREEN | LED_EXT_BLUE)
#define LED (*(volatile uint32_t*)0x02000000)

#define WISHBONE_REG_PCNTR 0x0
#define WISHBONE_REG_FSCNTRL 0x1
#define WISHBONE_REG_MODE 0x2
#define WISHBONE_REG_HWVER 0x3
//#define WISHBONE_REG_SWVER 0x4
#define WISHBONE_REG_SNIFFER_DATA 0x5
#define WISHBONE_REG_SNIFFER_CONTROL 0x8
#define WISHBONE_REG_MAPPER_READ_LO 0x9
#define WISHBONE_REG_MAPPER_READ_HI 0xa
#define WISHBONE_REG_MAPPER_WRITE_LO 0xb
#define WISHBONE_REG_MAPPER_WRITE_HI 0xc
#define WISHBONE_REG_COUNTER_RESET 0xd
#define WISHBONE_REG_RAM_1M_ALIASING 0xe
#define WISHBONE_REG_ID 0xf

extern volatile uint32_t * pWishboneRegs;
extern volatile uint32_t * pSDRAM;
extern volatile uint32_t * pSDRAM2;

int filesystem_command_active = 0;
int filesystem_last_list_item = 0;
DIR filesystem_last_dir;

#define MAX_FILES 16

FIL open_files[MAX_FILES];

extern char* mini_strcpy(char* dest, const char* src);
extern char* mini_strcat(char* dest, const char* src);
extern char* mini_strstr(const char *haystack, const char *needle);

extern unsigned char buffer[2048];

static int is_delim(char c, const char *delim)
{
    while (*delim) {
        if (c == *delim)
            return 1;
        delim++;
    }
    return 0;
}

char *mini_strtok(char *s, const char *delim)
{
    static char *p;
    char *start;

    if (s)
        p = s;

    if (!p)
        return NULL;

    while (*p && is_delim(*p, delim))
        p++;

    if (!*p) {
        p = NULL;
        return NULL;
    }

    start = p;

    while (*p && !is_delim(*p, delim))
        p++;

    if (*p) {
        *p = '\0';
        p++;
    } else {
        p = NULL;
    }

    return start;
}

int mini_strcmp(const char *a, const char *b)
{
    while (*a && *a == *b) {
        a++;
        b++;
    }

    return (unsigned char)*a - (unsigned char)*b;
}

int mini_atoi(const char *s)
{
    int sign = 1;
    int n = 0;

    while (*s == ' ' || (*s >= 9 && *s <= 13))
        s++;

    if (*s == '-' || *s == '+')
        if (*s++ == '-')
            sign = -1;

    while (*s >= '0' && *s <= '9')
        n = n * 10 + (*s++ - '0');

    return sign * n;
}

int filesystem_access_init() {
	for (int i=0;i<MAX_FILES;i++)
		open_files[i].obj.fs == 0;
	LED = LED_EXT_YELLOW;
}

int available_file_handle() {
	for (int i=0;i<MAX_FILES;i++)
		if (0 == open_files[i].obj.fs)
			return i;
	return -1;
}

int filesystem_access_scheduler() {
	uint8_t command_buffer[256];
	uint8_t reply_buffer[256];
	uint16_t *reply_buffer16 = (uint16_t*)reply_buffer;
	FRESULT res;
	FILINFO filinf;
	int readen;
	uint16_t * buffer16 = (uint16_t *)buffer;
	//checking if command is available
	if (0 == filesystem_command_active) {
		if (pWishboneRegs[WISHBONE_REG_FSCNTRL]) {
			LED = LED_EXT_RED;
			//new command detected, copying to buffer with transforming BE->LE
			for (int i=0;i<128;i++) {
				command_buffer[i*2+1] = pSDRAM[0xfffc00+i] >> 8;
				command_buffer[i*2] = pSDRAM[0xfffc00+i];
			}			
			command_buffer[256] = 0;//assuring string is terminated
			mini_printf("FSCMD: ");
			mini_printf(command_buffer);
			mini_printf("\r\n");
			//now parsing the buffer
			char * token = mini_strtok(command_buffer, " ");
			mini_printf("FSCMD2\r\n");
			if (0 == mini_strcmp(token,"OPEN")) {
				int handle = available_file_handle();
				if (handle != -1) {
					//open file, args : path and mode
					char * filename = mini_strtok(NULL, " ");
					char * mode = mini_strtok(NULL, " ");
					if (0 == mini_strcmp(mode,"r")) {
						res = f_open(&(open_files[handle]),filename,FA_READ);
					} else if (0 == mini_strcmp(mode,"r+")) {
						res = f_open(&(open_files[handle]),filename,FA_READ | FA_WRITE);
					} else if (0 == mini_strcmp(mode,"w")) {
						res = f_open(&(open_files[handle]),filename,FA_CREATE_ALWAYS | FA_WRITE);
					} else if (0 == mini_strcmp(mode,"w+")) {
						res = f_open(&(open_files[handle]),filename,FA_CREATE_ALWAYS | FA_WRITE | FA_READ);
					} else if (0 == mini_strcmp(mode,"a")) {
						res = f_open(&(open_files[handle]),filename,FA_OPEN_APPEND | FA_WRITE);
					} else if (0 == mini_strcmp(mode,"a+")) {
						res = f_open(&(open_files[handle]),filename,FA_OPEN_APPEND | FA_WRITE | FA_READ);
					} else if (0 == mini_strcmp(mode,"wx")) {
						res = f_open(&(open_files[handle]),filename,FA_CREATE_NEW | FA_WRITE);
					} else if (0 == mini_strcmp(mode,"w+x")) {
						res = f_open(&(open_files[handle]),filename,FA_CREATE_NEW | FA_WRITE | FA_READ);
					} else {
						res = -1;
					}
					if (res!= FR_OK) {
						mini_snprintf(reply_buffer,256,"ERR file open error");
						open_files[handle].obj.fs = 0;
					} else {
						mini_snprintf(reply_buffer,256,"OK handle=%d",handle);
					}
				} else {
						mini_snprintf(reply_buffer,256,"ERR Too many files");
						
				}

			} else if (0 == mini_strcmp(token,"CLOSE")) {
				//close file : handle
				char * handle_str = mini_strtok(NULL, " ");
				int handle = mini_atoi(handle_str);
				if ( (handle >=0) && (handle <32) )
					if (open_files[handle].obj.fs != 0) {
						f_close(&(open_files[handle]));
						open_files[handle].obj.fs = 0;
						mini_snprintf(reply_buffer,256,"OK");
					} else 
						mini_snprintf(reply_buffer,256,"ERR File not open");

			} else if (0 == mini_strcmp(token,"READ")) {
				int handle = mini_atoi(mini_strtok(NULL, " "));
				int offset = mini_atoi(mini_strtok(NULL, " "));
				int length = mini_atoi(mini_strtok(NULL, " "));
				if ( (length <= 0) || (length > 2048) )  {
					mini_snprintf(reply_buffer,256,"ERR Invalid lenght");
				} else if (open_files[handle].obj.fs == 0) {
					mini_snprintf(reply_buffer,256,"ERR File not open");
				} else {
					f_lseek(&open_files[handle],offset);
					f_read(&open_files[handle],buffer,length,&readen);
					mini_snprintf(reply_buffer,256,"OK data_len=%d",readen);
					//copy buffer to SDRAM
					for (int i=0;i<1024;i++)
						pSDRAM[0xfffc00+i] =  buffer16[i];
				}

			} else if (0 == mini_strcmp(token,"WRITE")) {
				int handle = mini_atoi(mini_strtok(NULL, " "));
				int offset = mini_atoi(mini_strtok(NULL, " "));
				int length = mini_atoi(mini_strtok(NULL, " "));
				if ( (length <= 0) || (length > 2048) )  {
					mini_snprintf(reply_buffer,256,"ERR Invalid lenght");
				} else if (open_files[handle].obj.fs == 0) {
					mini_snprintf(reply_buffer,256,"ERR File not open");
				} else {
					//copy SDRAM to buffer
					for (int i=0;i<1024;i++)
						buffer16[i] = pSDRAM[0xfffc00+i];
					if (FR_OK == f_lseek(&open_files[handle],offset)) {
						f_write(&open_files[handle],buffer,length,&readen);
						mini_snprintf(reply_buffer,256,"OK data_len=%d",readen);
					} else {
						mini_snprintf(reply_buffer,256,"ERR Invalid offset");
					}
				}

			} else if (0 == mini_strcmp(token,"TRUNCATE")) {
				int handle = mini_atoi(mini_strtok(NULL, " "));
				int length = mini_atoi(mini_strtok(NULL, " "));
				if (length <= 0)  {
					mini_snprintf(reply_buffer,256,"ERR Invalid lenght");
				} else if (open_files[handle].obj.fs == 0) {
					mini_snprintf(reply_buffer,256,"ERR File not open");
				} else {
					if (FR_OK == f_lseek(&open_files[handle],length)) {
						f_truncate(&open_files[handle]);
						mini_snprintf(reply_buffer,256,"OK data_len=%d",readen);
					} else {
						mini_snprintf(reply_buffer,256,"ERR Invalid offset");
					}
				}

			} else if (0 == mini_strcmp(token,"LIST")) {
				mini_printf("FSCMD3\r\n");
				char * path = mini_strtok(NULL, " ");
				if (path[0] != 0) {
					LED = LED_EXT_GREEN;
					mini_printf("FSCMD4\r\n");
					if (filesystem_last_dir.obj.fs)
						f_closedir(&filesystem_last_dir);
				    res = f_opendir(&filesystem_last_dir, path); 
					if (res != FR_OK) {
						mini_snprintf(reply_buffer,256,"ERR Dir not found");
					} else {
						res = f_readdir(&filesystem_last_dir, &filinf);
						mini_snprintf(reply_buffer,256,"OK name=\"%s\"",filinf.fname);
						LED = LED_EXT_BLUE;
					}
				} else {
								mini_printf("FSCMD5\r\n");
					//continuing last listing
					if (NULL == filesystem_last_dir.obj.fs) {
						mini_snprintf(reply_buffer,256,"ERR Dir not open");
					} else {
						res = f_readdir(&filesystem_last_dir, &filinf);
						mini_snprintf(reply_buffer,256,"OK name=\"%s\"",filinf.fname);
					}
				}
							mini_printf("FSCMD6\r\n");

			} else if (0 == mini_strcmp(token,"STAT")) {
				char * filename = mini_strtok(NULL, " ");
				if (FR_OK == f_stat(filename, &filinf)) {
					mini_snprintf(reply_buffer,256,"OK name=\"%s\" size=%d",filinf.fname,filinf.fsize);
				} else {
					mini_snprintf(reply_buffer,256,"ERR File not found");
				}
				
			} else if (0 == mini_strcmp(token,"MKDIR")) {
				char * path = mini_strtok(NULL, " ");
				if (FR_OK == f_mkdir(path)) {
					mini_snprintf(reply_buffer,256,"OK");
				} else {
					mini_snprintf(reply_buffer,256,"ERR Cannot create dir");
				}
				
			} else if (0 == mini_strcmp(token,"REMOVE")) {
				char * filename = mini_strtok(NULL, " ");
				if (FR_OK == f_unlink(filename)) {
					mini_snprintf(reply_buffer,256,"OK");
				} else {
					mini_snprintf(reply_buffer,256,"ERR Delete error");
				}
				
			} else if (0 == mini_strcmp(token,"RENAME")) {
				char * old_filename = mini_strtok(NULL, " ");
				char * new_filename = mini_strtok(NULL, " ");
				if (FR_OK == f_rename(old_filename,new_filename)) {
					mini_snprintf(reply_buffer,256,"OK");
				} else {
					mini_snprintf(reply_buffer,256,"ERR Rename error");
				}
				
			} else if (0 == mini_strcmp(token,"FLUSH")) {
				int handle = mini_atoi(mini_strtok(NULL, " "));
				if (FR_OK == f_sync(&open_files[handle])) {
					mini_snprintf(reply_buffer,256,"OK");
				} else {
					mini_snprintf(reply_buffer,256,"ERR Flush error");
				}

			} else  {
							mini_printf("FSCMD99\r\n");
				//unknown command
				mini_snprintf(reply_buffer,256,"ERR Unknown command");				
			}

			//report as complete
			mini_printf("FSRPLY: ");
			mini_printf(reply_buffer);
			mini_printf("\r\n");
			for (int i=0;i<128;i++)
				pSDRAM[0xfffc80+i] = reply_buffer16[i];
			filesystem_command_active = 1;
			pSDRAM[0xfffd00] =  0x100; //mark command as detected
			LED = LED_EXT_MAGENTA;
		}
	} else if (1 == filesystem_command_active) {
		if (0 == pWishboneRegs[WISHBONE_REG_FSCNTRL]) {
			mini_printf("FSRPLY2\r\n");
			//SH2 confirmed execution end
			filesystem_command_active = 0; //idle
			pSDRAM[0xfffd00] =  0; //mark command as idle
			LED = LED_EXT_CYAN;
		}
	}
}


typedef enum
{
  WFS_OK       = 0x00,
  WFS_NO_CARTRIDGE   = 0x01,
  WFS_CARTRIDGE_TIMEOUT   = 0x02,
  WFS_PATH_TOO_LONG  = 0x03,
  WFS_NO_FILE = 0x04,
  WFS_WRONG_MODE     = 0x05,
  WFS_TOO_MANY_FILES     = 0x06,
  WFS_WRONG_ACCESS_SIZE = 0x07,
  WFS_UNKNOWN_ERROR  = 0x99
} WFS_StatusType;

typedef struct 
{
unsigned short year;
unsigned char month;
unsigned char date;
unsigned char hour;
unsigned char minute;
unsigned char second;
} WFS_DateTime;

//public api
WFS_StatusType wascafs_chdir(char * directory);
WFS_StatusType wascafs_list(int restart, char* filename);
WFS_StatusType wascafs_stat(char* filename, int * size, WFS_DateTime * datetime, int * dir_flag);
WFS_StatusType wascafs_open(char * name, char * mode, int * handle);
WFS_StatusType wascafs_close(int handle);
WFS_StatusType wascafs_read(int handle, void * buffer, int offset, int count, int* data_len);

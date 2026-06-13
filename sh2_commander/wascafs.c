#include "yaul.h"
#include "wascafs.h"

static char command_buffer[256];
static char reply_buffer[256];
static int wasca_found = 0;
static const int WFS_TIMEOUT = 100000;
static volatile unsigned short * FSSTAT = (unsigned short *)0x23FFFA00;
static volatile unsigned short * FSCNTRL = (unsigned short *)0x23FFFFF2;
static volatile unsigned short * pWascaRegs = (unsigned short *)0x23FFFFE0;
static volatile unsigned char * pFilesysCmdBuf = (unsigned char *)0x23FFF800;
static volatile unsigned char * pFilesysReplyBuf = (unsigned char *)0x23FFF900;
static volatile unsigned char * pFilesysDataBuf = (unsigned char *)0x23FFF000;

static char current_dir_debug[256];

static WFS_StatusType wascafs_check_cartridge() {
	//check wasca signature
	unsigned char * p8 = (unsigned char *)CS0(0x1FFFFFA);
	if (memcmp(p8,"wasca ",6))
        return WFS_NO_CARTRIDGE;
    return WFS_OK;
}

static WFS_StatusType wascafs_execute_command(char * cmd_buf, char * reply_buf, char* data_buf) {
    int timeout;

    if (WFS_OK != wascafs_check_cartridge())
        return WFS_NO_CARTRIDGE;

	//assure idle state
	if (FSSTAT[0] != 0) {
		FSCNTRL[0] = 0;
		//wait for cart to return to idle
		timeout = 0;
		while ((FSSTAT[0] != 0) && (timeout < WFS_TIMEOUT)) {
			FSCNTRL[0] = 0;
			timeout++;
		}
	}
    
    if (timeout >= WFS_TIMEOUT)
        return WFS_CARTRIDGE_TIMEOUT;

    //copy data if available
    if (0 != data_buf)
        memcpy(pFilesysDataBuf,data_buf,2048);

    //copy command
	memcpy(pFilesysCmdBuf,cmd_buf,255);
    //assure command is null-terminated
    pFilesysCmdBuf[255] = 0;
	//send command
	FSCNTRL[0] = 0xFFFF;

	//wait until command is executed
	timeout = 0;
	while ((FSSTAT[0] == 0) && (timeout < WFS_TIMEOUT)) {
		timeout++;
	}

	if (timeout >= WFS_TIMEOUT)
		return WFS_CARTRIDGE_TIMEOUT;

    //return cart to idle
    FSCNTRL[0] = 0;
    //assure reply is null-terminated
	pFilesysReplyBuf[255] = 0;
    //get reply
	memcpy(reply_buf,pFilesysReplyBuf,256);
    //get data if necessary
	if (0 != data_buf)
		memcpy(data_buf,pFilesysDataBuf,2048);

    return WFS_OK;
}

static int fatfs_to_datetime(uint16_t fdate, uint16_t ftime, WFS_DateTime *datetime)
{
    datetime->year = ((fdate >> 9) & 0x7F) + 1980;
    datetime->month  = ((fdate >> 5) & 0x0F);
    datetime->date =  (fdate       & 0x1F);

    datetime->hour = ((ftime >> 11) & 0x1F);
    datetime->minute  = ((ftime >> 5)  & 0x3F);
    datetime->second  = (ftime & 0x1F) * 2;

    return 0;
}

/**
 * wascafs_chdir - change directory 
 * 
 * inputs:
 *  directory - full path to the directory the filesystem driver should change to,
 *              maximum length is 249 bytes
 * 
 * return value:
 *  WFS_OK if successful, error code otherwise
 */

WFS_StatusType wascafs_chdir(char * directory) {
    if (strlen(directory) > 249)
        return WFS_PATH_TOO_LONG;
    
    strcpy(current_dir_debug,directory); //chdir not supported yet
    return WFS_OK;
    //sprintf(command_buffer,"CHDIR %s",path);
    //return wascafs_execute_command(command_buffer,reply_buffer,NULL);
}

/**
 * wascafs_list - get directory entry
 * 
 * inputs:
 *  restart - if this flag is set, first entry of the current directory is returned,
 *            if not - next entry, use multiple calls to get all entries
 *  filename - string that will be updated with filename if call is successful
 * 
 * return value:
 *  WFS_OK if successful, error code otherwise
 */

WFS_StatusType wascafs_list(int restart, char* filename) {
    char * ptr;
    if (restart)
        sprintf(command_buffer,"LIST %s",current_dir_debug);
    else
        sprintf(command_buffer,"LIST");
    WFS_StatusType status = wascafs_execute_command(command_buffer,reply_buffer,0);
    if (status != WFS_OK)
        return status;
 	if (0 == memcmp("OK name=",reply_buffer,7)) {
		ptr = &(reply_buffer[9]);
		ptr[strlen(ptr)-1] = 0; //removing " at the end
		strcpy(filename,ptr);
	} else
		strcpy(filename,"");
    return status;
}

/**
 * wascafs_stat - get directory entry
 * 
 * inputs:
 *  filename - name of the file in current directory
 *  size - int pointer, file size will be returned
 *  datetime - struct pointer, file time will be returned
 *  dir_flag - int pointer, 1 returned for dir, 0 for file
 * 
 * return value:
 *  WFS_OK if successful, error code otherwise
 */

WFS_StatusType wascafs_stat(char* filename, int * size, WFS_DateTime * datetime, int * dir_flag) {
    char * ptr;
    char buf[256];
    sprintf(command_buffer,"STAT %s%s",current_dir_debug,filename);
    WFS_StatusType status = wascafs_execute_command(command_buffer,reply_buffer,0);
    if (status != WFS_OK)
        return status;
    if (0 == memcmp("OK name=",reply_buffer,7)) {
		ptr = strstr(reply_buffer,"dir=");
		if (ptr[5]=='1') {
			//directory
			*dir_flag = 1;
            *size = 0;
		} else {
			//file
            *dir_flag = 0;
			ptr = strstr(reply_buffer,"size=");
            strcpy(buf,&(ptr[6]));
            *size = atoi(strtok(buf," \""));
        }
        ptr = strstr(reply_buffer,"date=");
        strcpy(buf,&(ptr[6]));
        uint16_t fdate = atoi(strtok(buf," \""));
        ptr = strstr(reply_buffer,"time=");
        strcpy(buf,&(ptr[6]));
        uint16_t ftime = atoi(strtok(buf," \""));
        fatfs_to_datetime(fdate,ftime,datetime);
	}
}

/**
 * wascafs_open - open file
 * 
 * inputs:
 *  name - file name without directory
 *  mode - access mode, POSIX fopen() format
 *  handle - pointer to int value that will be set to file handle if successfull
 * 
 * return value:
 *  WFS_OK if successful, error code otherwise
 */

WFS_StatusType wascafs_open(char * name, char * mode, int * handle) {
    WFS_StatusType status;
    char * p;
    sprintf(command_buffer,"OPEN %s%s %s",current_dir_debug,name,mode);
    status = wascafs_execute_command(command_buffer,reply_buffer,0);
    if (WFS_OK != status)
        return status;

    if (0 == memcmp("OK",reply_buffer,2)) {
        p = strstr(reply_buffer,"handle=");
	    p += 7;
	    *handle = atoi(p);
		return WFS_OK;
	} else if (0 == memcmp("ERR WRONG MODE",reply_buffer,strlen("ERR WRONG MODE"))) {
        return WFS_WRONG_MODE;
    } else if (0 == memcmp("ERR NO FILE",reply_buffer,strlen("ERR NO FILE"))) {
        return WFS_NO_FILE;
    } else if (0 == memcmp("ERR TOO MANY FILES",reply_buffer,strlen("ERR TOO MANY FILES"))) {
        return WFS_TOO_MANY_FILES;
    } else {
        return WFS_UNKNOWN_ERROR;
    }
}

/**
 * wascafs_close - close file
 * 
 * inputs:
 *  handle - file handle
 * 
 * return value:
 *  WFS_OK if successful, error code otherwise
 */

WFS_StatusType wascafs_close(int handle) {
    WFS_StatusType status;
    sprintf(command_buffer,"CLOSE %d",handle);
    status = wascafs_execute_command(command_buffer,reply_buffer,0);
    if (WFS_OK != status)
        return status;

    if (0 == memcmp("OK",reply_buffer,2)) {
		return WFS_OK;
	} else {
        return WFS_UNKNOWN_ERROR;
    }
}

/**
 * wascafs_read - read data from file
 * 
 * inputs:
 *  handle - file handle
 *  buffer - buffer to store data
 *  offset - file read offset
 *  count  - number of bytes to read, up to 2048
 *  data_len - pointer to number of bytes written
 * 
 * return value:
 *  WFS_OK if successful, error code otherwise
 */

WFS_StatusType wascafs_read(int handle, void * buffer, int offset, int count, int* data_len) {
    WFS_StatusType status;
    char * ptr;
    if (data_len)
        *data_len = 0;
    if ( (count > 2048) || (count < 0) )
        return WFS_WRONG_ACCESS_SIZE;
    sprintf(command_buffer,"READ %d %d %d",handle,offset,count);
    status = wascafs_execute_command(command_buffer,reply_buffer,buffer);
    if (WFS_OK != status)
        return status;

    if (0 == memcmp("OK",reply_buffer,2)) {
        ptr = strstr(reply_buffer,"data_len=");
        if (data_len)
            *data_len = atoi(strtok(&(ptr[9])," \""));
		return WFS_OK;
	} else {
        return WFS_UNKNOWN_ERROR;
    }
}
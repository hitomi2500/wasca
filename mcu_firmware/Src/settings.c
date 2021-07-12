#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "settings.h"

#ifdef TARGET_STM32
#   include "fatfs.h"
#   include "log.h"
#endif // TARGET_STM32



typedef enum _ini_section_t
{
    SECTION_SETUP = 0,      /* [Setup] */
    SECTION_LOG             /* [Log]   */
} ini_section_t;

wasca_settings_t _wasca_set = { 0 };


#ifdef TARGET_STM32
#   if 0 /* Should be set to zero. */
#      define ini_logout(...) termout(WL_LOG_IMPORTANT, __VA_ARGS__)
#   else
#       define ini_logout(...)
#   endif
# else // Windows Target
#   define ini_logout(...) printf(__VA_ARGS__); printf("\r\n")
#endif


void settings_init(void)
{
    /* Reset settings to default parameters.
     * If ini file is not found, the settings below will be used.
     */
    memset(&_wasca_set, 0, sizeof(wasca_settings_t));
    _wasca_set.log_level    = 3;
    _wasca_set.log_max_size = 10*1024; /* 10KB. */
    _wasca_set.log_to_uart  = 1;
    _wasca_set.log_to_usb   = 0;
    _wasca_set.log_to_sd    = 1;
    _wasca_set.flush_interval = 500; /* 0.5 sec. */

    /* Reset base settings for MAX 10. */
    _wasca_set.max.cart_mode = 0x0342;
    _wasca_set.max.log_level = WL_LOG_IMPORTANT;
}

void settings_read(void)
{
    int i, j;

    /* Open ini file and parse it line per line */
    const char* ini_file_name = "wasca.ini";
    long file_len;

#ifdef TARGET_STM32

    int f_ret;
    FIL IniFile;

    f_ret = f_open(&IniFile, ini_file_name, FA_READ);
    if(f_ret != FR_OK)
    {
        return;
    }

    file_len = f_size(&IniFile);

    /* Avoid weird file length.
     * Not likely to happen, but just in case of.
     */
    if(file_len <= 0)
    {
        f_close(&IniFile);
        return;
    }

#else // Windows Target

    FILE* fp = fopen(ini_file_name, "rb");
    if(!fp)
    {
        return;
    }

    fseek(fp, 0, SEEK_END);
    file_len = ftell(fp);
    fseek(fp, 0, SEEK_SET);

    /* Avoid weird file length.
     * Not likely to happen, but just in case of.
     */
    if(file_len <= 0)
    {
        fclose(fp);
        return;
    }

#endif



    /* Restrict maximum file length.
     * 
     * Main reason is that reading and parsing of setting file too large may
     * delay STM32 startup long enough to cause problem to load cartridge ROM.
     * And also because if settings file is larger than 100KB, there's a problem
     * regarding Wasca setup ...
     */
    if(file_len >= (100*1024))
    {
        file_len = 100*1024;
    }


    ini_section_t section = SECTION_SETUP;

    char line_buff[INI_LINE_MAXLEN + 1] = {'\0'};
    long line_len = 0;

    long read_offset;
    char read_buff[INI_READBUFF_LEN];
    for(read_offset=0; read_offset<file_len; read_offset+=sizeof(read_buff))
    {
        memset(read_buff, 0, sizeof(read_buff));
        long read_len = sizeof(read_buff);
        if((read_offset + read_len) >= file_len)
        {
            read_len = file_len - read_offset;
        }

#ifdef TARGET_STM32
        UINT bytes_read = 0;
        f_read(&IniFile, read_buff, read_len, &bytes_read);
#else // Windows Target
        fread(read_buff, read_len, 1, fp);
#endif

        for(i=0; i<read_len; i++)
        {
            char c = read_buff[i];

            /* Put only "visible" 7 bits ASCII characters in line buffer, 
             * so that it's possible to parse UTF-8/16 files (with BOM
             * and/or 2 bytes per character) at small cost.
             *
             * It won't make this parser to be unicode-compliant, but
             * that's not a problem since the main goals of this module
             * are to be fast, reliable and simple.
             */
            if(((c >= ' ') && (c < 0x80))
            && (line_len < INI_LINE_MAXLEN))
            {
                if((line_len == 0) && (c == ' '))
                {
                    /* Discard space at beginning of line.
                     *  Example : " setting = 123"
                     */
                }
                else
                {
                    line_buff[line_len++] = c;
                }
            }

            if((c == '\r') || (c == '\n')
            || ((read_offset+i) == (file_len-1)))
            {
                /* New line, or EOT : parse line buffer if it contains something. */
                if((line_len > 0) && (line_len <= INI_LINE_MAXLEN))
                {
                    /* Don't forget to close the line about to parse. */
                    line_buff[line_len] = '\0';
                    line_buff[sizeof(line_buff)-1] = '\0';

                    /* Parse line accumulated so far. */
                    char c0 = line_buff[0];
                    if(c0 == '[')
                    {
                        /* Declaration of a section. */
                        for(j=1; j<line_len; j++)
                        {
                            if(line_buff[j] == ']')
                            {
                                line_buff[j] = '\0';
                                break;
                            }
                        }
                        char* s = line_buff + 1;
ini_logout("Section:\"%s\"", s);
                        if(strcasecmp(s, "setup") == 0)
                        {
                            section = SECTION_SETUP;
ini_logout(" -> COMMON");
                        }
                        else if(strcasecmp(s, "log") == 0)
                        {
                            section = SECTION_LOG;
ini_logout(" -> LOG");
                        }
                    }
                    else if(((c0 >= 'A') && (c0 <= 'Z')) || ((c0 >= 'a') && (c0 <= 'z')))
                    {
                        /* Declaration of a field : first, look for the
                         * separation character between name and value.
                         */
                        char* name = line_buff;
                        char* val  = NULL;
                        for(j=0; j<line_len; j++)
                        {
                            if((line_buff[j] == '=')
                            || (line_buff[j] == ':'))
                            {
                                line_buff[j] = '\0';
                                val = line_buff + j + 1;
                                break;
                            }
                        }
ini_logout(" sect:%d", section);
ini_logout(" name:\"%s\"", name);
ini_logout(" val :\"%s\"", (val ? val : "(null)"));

                        if(val != NULL)
                        {
                            /* Some folks like to put space around equal sign :
                             *  Example : "setting = 123"
                             * So let's trim these unwanted space characters.
                             */
                            while(1)
                            {
                                if(val[0] == ' ')
                                {
                                    val++;
                                }
                                else
                                {
                                    break;
                                }
                            }

                            long n = strlen(name);
                            for(j=0; j<n; j++)
                            {
                                if(name[n-1 - j] == ' ')
                                {
                                    name[n-1 - j] = '\0';
                                }
                                else
                                {
                                    break;
                                }
                            }

                            /* Look for known setting name. */
                            long v = 0;
                            if(section == SECTION_SETUP)
                            {
                                if(strcasecmp(name, "mode") == 0)
                                {
                                    v = strtoul(val, NULL, 16) & 0x0000FFFF;
ini_logout(" -> Setup.Mode:0x%04X", v);
                                    _wasca_set.max.cart_mode = (unsigned short)v;
                                }
                            }
                            else if(section == SECTION_LOG)
                            {
                                if(strcasecmp(name, "levelm10") == 0)
                                {
                                    v = atoi(val);
ini_logout(" -> log.M10Level:%d", v);
                                    if(v < 0)
                                    {
                                        v = 0;
                                    }
                                    else if(v > 255)
                                    {
                                        v = 255;
                                    }
                                    _wasca_set.max.log_level = v;
                                }
                                if(strcasecmp(name, "levels32") == 0)
                                {
                                    v = atoi(val);
ini_logout(" -> log.S32Level:%d", v);
                                    if(v < 0)
                                    {
                                        v = 0;
                                    }
                                    else if(v > 255)
                                    {
                                        v = 255;
                                    }
                                    _wasca_set.log_level = v;
                                }
                                else if(strcasecmp(name, "maxsize") == 0)
                                {
                                    v = atoi(val);
ini_logout(" -> log.maxsize:%d", v);
                                    if(v < 0)
                                    {
                                        v = 0;
                                    }
                                    else if(v > (10*1024))
                                    {
                                        /* Restrict log file size to maximum 10MB. */
                                        v = 10*1024;
                                    }
                                    _wasca_set.log_max_size = v * 1024;
                                }
                                else if(strcasecmp(name, "touart") == 0)
                                {
                                    v = atoi(val);
                                    _wasca_set.log_to_uart = (v == 0 ? 0 : 1);
                                }
                                else if(strcasecmp(name, "tousb") == 0)
                                {
                                    v = atoi(val);
                                    _wasca_set.log_to_usb = (v == 0 ? 0 : 1);
                                }
                                else if(strcasecmp(name, "tosd") == 0)
                                {
                                    v = atoi(val);
                                    _wasca_set.log_to_sd = (v == 0 ? 0 : 1);
                                }
                                else if(strcasecmp(name, "flushinterval") == 0)
                                {
                                    v = atoi(val);

                                    if(v < 0)
                                    {
                                        v = 0;
                                    }
                                    else if(v > 3000)
                                    {
                                        /* Avoid too long interval that would discard important logs
                                         * if user turns off Saturn too fast after a problem happens.
                                         */
                                        v = 3000;
                                    }

                                    _wasca_set.flush_interval = v;
                                }
                            }
                            else
                            {
                                /* Ignore unknown section. */
                            }

                        }
                    }
                    else // if((c0 == '#') || (c0 == ';') || (c0 == whatever))
                    {
                        /* Don't care about comment line. */
                    }

                    /* Reset line buffer. */
                    line_len = 0;
                }
            }
        }
    }

    /* Don't forget to close the file. */
#ifdef TARGET_STM32
    f_close(&IniFile);
#else // Windows Target
    fclose(fp);
#endif
}


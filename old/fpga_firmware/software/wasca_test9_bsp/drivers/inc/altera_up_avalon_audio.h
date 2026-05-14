#ifndef __ALTERA_UP_AVALON_AUDIO_H__
#define __ALTERA_UP_AVALON_AUDIO_H__

#include <stddef.h>
#include <alt_types.h>
#include <sys/alt_dev.h>

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

#define ALT_UP_AUDIO_LEFT 0
#define ALT_UP_AUDIO_RIGHT 1

#define BUF_THRESHOLD 96	// 75% of the 128 word FIFOs in the audio core

/*
 * Device structure definition. Each instance of the driver uses one
 * of these structures to hold its associated state.
 */
typedef struct alt_up_audio_dev {
	/// @brief character mode device structure 
	/// @sa Developing Device Drivers for the HAL in Nios II Software Developer's Handbook
	alt_dev dev;
	/// @brief the base address of the device
	unsigned int base;
	/// @brief choose the right or left channel
	int channel;
} alt_up_audio_dev;


//////////////////////////////////////////////////////////////////////////
// HAL system functions

//////////////////////////////////////////////////////////////////////////
// file-like operation functions

//////////////////////////////////////////////////////////////////////////
// direct operation functions

/**
 * @brief Opens the audio device specified by <em> name </em> (default "/dev/audio/")
 * @param name -- the audio component name in SOPC Builder. 
 * @return The corresponding device structure, or NULL if the device is not found
 **/
alt_up_audio_dev* alt_up_audio_open_dev(const char* name);

/**
 * @brief Enable read interrupts for the Audio Core
 * @param audio -- the audio device structure 
 * @return nothing
 **/
void alt_up_audio_enable_read_interrupt(alt_up_audio_dev *audio);

/**
 * @brief Disable read interrupts for the Audio Core
 * @param audio -- the audio device structure 
 * @return nothing
 **/
void alt_up_audio_disable_read_interrupt(alt_up_audio_dev *audio);

/**
 * @brief Enable write interrupts for the Audio Core
 * @param audio -- the audio device structure 
 * @return nothing
 **/
void alt_up_audio_enable_write_interrupt(alt_up_audio_dev *audio);

/**
 * @brief Disable the read interrupts for the Audio Core
 * @param audio -- the audio device structure 
 * @return nothing
 **/
void alt_up_audio_disable_write_interrupt(alt_up_audio_dev *audio);

/**
 * @brief Check if read interrupt pending for the Audio Core
 * @param audio -- the audio device structure 
 * @return 1 if read interrupt is pending, else 0
 **/
int alt_up_audio_read_interrupt_pending(alt_up_audio_dev *audio);

/**
 * @brief Check if write interrupt pending for the Audio Core
 * @param audio -- the audio device structure 
 * @return 1 if write interrupt is pending, else 0
 **/
int alt_up_audio_write_interrupt_pending(alt_up_audio_dev *audio);

/**
 * @brief Reset the Audio Core by clearing read and write FIFOs for left and right channels
 * @param audio -- the audio device structure 
 * @return nothing
 **/
void alt_up_audio_reset_audio_core(alt_up_audio_dev *audio);

/**
 * @brief provides number of words of data available in the incoming FIFO for \em channel
 * @param audio -- the audio device structure 
 * @param channel	-- left or right channel selection
 *
 * @return number of words available
 **/
unsigned int alt_up_audio_read_fifo_avail(alt_up_audio_dev *audio, int channel);

/**
 * @brief Read len words of data from right input FIFO, if the FIFO is above a threshold,
 *  and store data to where buf points
 * @param audio -- the audio device structure 
 * @param buf	-- the pointer to the allocated memory for storing audio data.
 * Size of buf should be no smaller than len words.
 * @param len	-- the number of data in words to read from the input FIFO
 * @return The total number of words read.
 **/
unsigned int alt_up_audio_record_r(alt_up_audio_dev *audio, unsigned int *buf, int len);

/**
 * @brief Read len words of data from left input FIFO, if the FIFO is above a threshold,
 *  and store data to where buf points
 * @param audio -- the audio device structure 
 * @param buf	-- the pointer to the allocated memory for storing audio data.
 * Size of buf should be no smaller than len words.
 * @param len	-- the number of data in words to read from the input FIFO
 * @return The total number of words read.
 **/
unsigned int alt_up_audio_record_l(alt_up_audio_dev *audio, unsigned int *buf, int len);

/**
 * @brief provides the amount of empty space in the outgoing FIFO for \em channel
 * @param audio -- the audio device structure 
 * @param channel	-- left or right channel enum
 * @return number of words available
 **/
unsigned int alt_up_audio_write_fifo_space(alt_up_audio_dev *audio, int channel);

/**
 * @brief Write len words of data into right output FIFO, if space available in FIFO is 
 * above a threshold
 * @param audio -- the audio device structure 
 * @param buf	-- the pointer to the data to be written.
 * Size of buf should be no smaller than len words.
 * @param len	-- the number of data in words to be written into the output FIFO
 * @return The total number of data written.
 **/
unsigned int alt_up_audio_play_r(alt_up_audio_dev *audio, unsigned int *buf, int len);

/**
 * @brief Write len words of data into left output FIFO, if space available in FIFO is 
 * above a threshold
 * @param audio -- the audio device structure 
 * @param buf	-- the pointer to the data to be written.
 * Size of buf should be no smaller than len words.
 * @param len	-- the number of data in words to be written into the output FIFO
 * @return The total number of data written.
 **/
unsigned int alt_up_audio_play_l(alt_up_audio_dev *audio, unsigned int *buf, int len);

/**
 * @brief Read len words of data from left input FIFO, if the FIFO is above a threshold
 *  and store data to where buf points
 * @param audio -- the audio device structure 
 * @param buf	-- the pointer to the allocated memory for storing audio data.
 * Size of buf should be no smaller than len words.
 * @param len	-- the number of data in words to read from the input FIFO
 * @return The total number of words read.
 **/
unsigned int alt_up_audio_record_l(alt_up_audio_dev *audio, unsigned int *buf, int len);

/**
 * @brief Read \em len words of data from left input FIFO or right input FIFO,
 *  and store data to where \em buf points
 * @param audio -- the audio device structure 
 * @param buf	-- the pointer to the allocated memory for storing audio data.
 * Size of \em buf should be no smaller than \em len words.
 * @param len	-- the number of data in words to read from each input FIFO
 * @param channel	-- left or right channel selection
 * @return The total number of words read.
 **/
int alt_up_audio_read_fifo(alt_up_audio_dev *audio, unsigned int *buf, int len, int channel);

/**
 * @brief Write \em len words of data from \em buf to the left or right output FIFOs
 * @param audio -- the audio device structure 
 * @param buf	-- the pointer to the data to be written.
 * Size of \em buf should be no smaller than \em len words.
 * @param len	-- the number of data in words to be written into each output FIFO
 * @param channel	-- left or right channel selector
 * @return The total number of data written.
 **/
int alt_up_audio_write_fifo(alt_up_audio_dev *audio, unsigned int *buf, int len, int channel);

/**
 * @brief Read one data word from left input FIFO or right input FIFO
 * @param audio -- the audio device structure 
 * @param channel	-- left or right channel selection
 * @return the word read
 **/
unsigned int alt_up_audio_read_fifo_head(alt_up_audio_dev *audio, int channel);

/**
 * @brief Write one data word to the left or right output FIFOs
 * @param audio -- the audio device structure 
 * @param data	-- the data word to be written
 * @param channel	-- left or right channel selector
 * @return nothing
 **/
void alt_up_audio_write_fifo_head(alt_up_audio_dev *audio, unsigned int data, int channel);
/*
 * Macros used by alt_sys_init 
 */
#define ALTERA_UP_AVALON_AUDIO_INSTANCE(name, device)	\
	static alt_up_audio_dev device =					\
	{												 	\
	{													\
		ALT_LLIST_ENTRY,								\
		name##_NAME,									\
		NULL, /* open  */								\
		NULL, /* close */								\
		NULL, /* read  */								\
		NULL, /* write */								\
		NULL, /* lseek */								\
		NULL, /* fstat */								\
		NULL, /* ioctl */								\
	},													\
	name##_BASE,										\
	0	/* 0 for ALT_UP_AUDIO_LEFT */			\
}

#define ALTERA_UP_AVALON_AUDIO_INIT(name, device)		\
{														\
	alt_dev_reg(&device.dev);							\
}



#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __ALTERA_UP_AVALON_AUDIO_H__ */



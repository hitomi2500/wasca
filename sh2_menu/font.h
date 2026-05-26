#ifndef FONT_H
#define FONT_H

#define FONT_WHITE	1
#define FONT_RED	2
#define FONT_GREEN	3
#define FONT_BLUE	4
#define FONT_CYAN	5
#define FONT_MAGENTA 6
#define FONT_YELLOW	7
#define FONT_BLACK	8

#define FONT_QUAD_WIDTH	320
#define FONT_QUAD_HEIGHT 224

#define FONT_PALETTE (0)

extern int _fh;
extern int _fw;

extern unsigned char SuiteFont[];
extern int SuiteFont_len;

void SetFontPalette();
void DrawString(char *str, unsigned int x, unsigned int y, unsigned int palette);
void DrawStringOnBuffer(char *str, unsigned int x, unsigned int y, unsigned int palette, uint8_t * buffer);
void ClearText(int left, int top, int width, int height);
void ClearTextOnBuffer(int left, int top, int width, int height, uint8_t * buffer);
void ClearTextLayer();
void ClearTextLayerOnBuffer(uint8_t * buffer);

void DrawChar(unsigned int x, unsigned int y, char c, unsigned int palette, bool transparent);
void DrawCharOnBuffer(unsigned int x, unsigned int y, char c, unsigned int palette, bool transparent, uint8_t * buffer);
void DrawStringWithBackground(char *str, unsigned int x, unsigned int y, unsigned int palette, unsigned int bg_palette);
void DrawStringWithBackgroundOnBuffer(char *str, unsigned int x, unsigned int y, unsigned int palette, unsigned int bg_palette, uint8_t * buffer);

#endif /* !FONT_H */
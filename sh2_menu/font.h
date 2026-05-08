/* 
 * 240p Test Suite for Nintendo 64
 * Copyright (C)2018 Artemio Urbina
 *
 * This file is part of the 240p Test Suite
 *
 * The 240p Test Suite is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * The 240p Test Suite is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with 240p Test Suite; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA	02111-1307	USA
 */


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
@echo off

REM Set your board informations here.
REM Archive name is set in order to comply with Seeed Studio naming rules.
set board_name=wasca
set board_rev=r12
set board_dim=10x10


REM Rename each gerber/drill files
REM ( http://support.seeedstudio.com/knowledgebase/articles/447362-fusion-pcb-specification )
rmdir /S /Q tmp
mkdir tmp

copy /Y %board_name%-Back.gbl    tmp\%board_name%.gbl
copy /Y %board_name%-B.Mask.gbs  tmp\%board_name%.gbs
copy /Y %board_name%-B.SilkS.gbo tmp\%board_name%.gbo

copy /Y %board_name%-Front.gtl   tmp\%board_name%.gtl
copy /Y %board_name%-F.Mask.gts  tmp\%board_name%.gts
copy /Y %board_name%-F.SilkS.gto tmp\%board_name%.gto

copy /Y %board_name%.drl         tmp\%board_name%.txt

copy /Y %board_name%-Margin.gbr  tmp\%board_name%.gml

REM Archive everything in a zip file.
REM Please modify path to 7z.exe according to your 7-zip installation directory.
set arc_name="%date:~0,4%%date:~5,2%%date:~8,2%_%board_name%_%board_rev%-mfg_%board_dim%.zip"
del %arc_name%
cd tmp
C:\"Program Files"\7-Zip\7z.exe a -tzip -mx=9 ..\%arc_name% *
cd ..

pause
rmdir /S /Q tmp


@echo off & setlocal EnableDelayedExpansion

REM Path to Quartus folder. Adapt this to your Quartus setup.
set quartus_path=D:\altera\18.1

REM Note to hitomi2500 : please set below the path to your Quartus setup :
if not exist %quartus_path%\nios2eds\version.txt set quartus_path=D:\altera\15.1
set path=%path%;%quartus_path%\quartus\bin64

REM Verify that compiler environment is available.
if exist %quartus_path%\nios2eds\version.txt goto compiler_available
echo Error : NIOS compilation environment not found !
pause
exit
:compiler_available

REM REM Path to NIOS2 tools. Adapt this to your Quartus setup.
REM set path=%path%;%quartus_path%\nios2eds\bin
REM set path=%path%;%quartus_path%\nios2eds\sdk2\bin

REM Guess path to BSP folder
for %%a in ("%cd%") do set current_dir=%%~na
set bsp_dir="%cd%"\..\%current_dir%_bsp


@REM Dummy initialize command
set cm=dmy

@REM Set the project name (= the name of the folder where this batch file is)
set pj_workdir="%cd%"
cd ..\..
set pj_basedir="%cd%"
for %%a in ("%cd%") do set pj_design_name=%%~na
cd %pj_workdir%
for %%a in ("%cd%") do set pj_software_name=%%~na

REM Avoid project name set to "fpga_firmware", because it is always set to that when compiling from github repo.
if not "%pj_design_name%" == "fpga_firmware" goto skip_name_correct
for /f "delims=" %%x in (pj_design_name.txt) do set pj_design_name=%%x
:skip_name_correct
echo %pj_design_name%> pj_design_name.txt


@REM Silent build by default
set verbse=@

@REM No command line parameter
If "%1%" == "" goto start

@REM [Before processing]Command line parameter : parse it and exit.
set cm=%1%
goto parsecommand


set cm=dummy
:start
@REM [After processing]If command line parameter, exit
If NOT "%1%" == "" goto end

echo --------------------- pj=%pj_design_name%:%pj_software_name%
echo  Type `end' to end.
echo  Type `b' to run bash.
echo  Type `rb' to rebuild everything.
echo  Type `c' to clean project, excluding BSP.
echo  Type `m' to make project, excluding BSP.
echo  Type `s' to upload sof to SRAM.
echo  Type `e' to upload elf to OCRAM.
echo  Type `u' to upload both sof and elf.
echo  Type `flash' to flash CPLD.
if exist ..\..\readme.txt echo  Type `rdm' to open readme file.
if exist ..\..\readme.txt echo  Type `arc' to archive everything.
echo  Other: exec dos command.
set /P cm="Command: "

:parsecommand

@REM Retrieve informations about PL build time and device type.
set "crt_date_raw="
for /f "tokens=1-3* delims= " %%a in (
  'dir  /a:-d /o:d /t:W "..\..\output_files\wasca.done" ^| findstr /i "wasca.done" '
) do set "crt_date_raw=%%~a %%~b"
set pl_dt=%crt_date_raw:~0,4%%crt_date_raw:~5,2%%crt_date_raw:~8,2%%crt_date_raw:~11,2%%crt_date_raw:~14,2%

set "dev_line="
for /F "skip=5 delims=" %%i in (..\..\output_files\wasca.fit.summary) do if not defined dev_line set "dev_line=%%i"

@REM Parse command.
If "%cm%" == "end" goto end
If "%cm%" == "b" goto run_bash
If "%cm%" == "rb" goto do_rebuild
If "%cm%" == "c" goto do_clean
If "%cm%" == "m" goto do_make
If "%cm%" == "s" goto do_sof_upload
If "%cm%" == "e" goto do_elf_upload
If "%cm%" == "u" goto do_both_upload
If "%cm%" == "flash" goto do_flash
If "%cm%" == "rdm" goto do_readme
If "%cm%" == "arc" goto do_archive
%cm%
goto start


:run_bash
call %quartus_path%\nios2eds\"Nios II Command Shell.bat"
goto start


:do_rebuild

@REM Update informations about PL build time, device type and project name in header file
echo // Generated: %date:~0,4%/%date:~5,2%/%date:~8,2%, %time:~0,2%:%time:~3,2%> m10_ver_infos.h
echo #ifndef M10_VER_INFOS_H>> m10_ver_infos.h
echo #define M10_VER_INFOS_H>> m10_ver_infos.h
echo #define MAX10_FWDT_STR  "%pl_dt%">> m10_ver_infos.h
echo #define MAX10_FWDT_VAL  %pl_dt:~0,8%>> m10_ver_infos.h
echo #define MAX10_FWTM_VAL  1%pl_dt:~8,4%>> m10_ver_infos.h
echo #define MAX10_DEV_TYPE  "%dev_line:~9,14%">> m10_ver_infos.h
echo #define MAX10_PROJ_NAME "%pj_design_name%">> m10_ver_infos.h
echo #endif // M10_VER_INFOS_H>> m10_ver_infos.h

cat m10_ver_infos.h

call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./rebuild_all.sh
goto start


:do_clean
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./make_clean.sh
goto start


:do_make
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" make
goto start


:do_sof_upload
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./upload_sof.sh
goto start

:do_elf_upload
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./upload_elf.sh
goto start

:do_both_upload
REM $ make && nios2-configure-sof --cable USB-Blaster ../../output_files/wasca.sof && make download-elf
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./upload_sof.sh
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./upload_elf.sh
goto start


:do_flash
REM REM First, verify that project can compile correctly
REM del /Q %pj_software_name%.elf
REM call %quartus_path%\nios2eds\"Nios II Command Shell.bat" make
if exist %pj_software_name%.elf goto flash_compilation_ok
echo *** Compilation error ***
goto start

:flash_compilation_ok
REM Update CPLD flash log : write on this folder's log file and on the file common for all projects too.
set flash_log=Flash_Time: %date:~0,4%/%date:~5,2%/%date:~8,2%, %time:~0,2%:%time:~3,2%, Device: %dev_line:~9,14%, PL_Date: %pl_dt%, PJ_Name:%pj_design_name%
echo %flash_log% >> m10_flash_log.txt
echo %flash_log% >> ..\..\..\m10_flash_log.txt

REM Then, rebuild the programming file since this is not done by the makefile
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./rebuild_flash.sh

REM Finally, program the generated pof file to CPLD
quartus_pgm -z --mode=JTAG --operation="p;%pj_basedir%\output_files\nios2_ufm_boot_test9.pof"
goto start


:do_readme
cd ..\..
start /WAIT notepad2.exe readme.txt
cd %pj_workdir%
goto start


:do_archive

@REM Go to project root folder
cd ..\..

@REM Prompt for archive strength
set arc_mx=5
@echo (mx=3 takes around  50MB of RAM for 150MB resulting archive)
@echo (mx=7 takes around 700MB of RAM for 50MB resulting archive)
SET /P arc_mx="Set archive strength (0-9, default:%arc_mx%): "

@REM Automatically open readme for updating
echo Let's no forget to update the readme
start /WAIT notepad2.exe readme.txt

@REM Set archive base name
set date_tmp=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%
SET date_zero=%date_tmp: =0%
set archive_base_name="%pj_design_name%_%date_zero%_mx%arc_mx%"
set archive_full_base=..\..\[ARC]\%archive_base_name%

@REM Archive everything
set archive_type=-t7z -mx=%arc_mx%
set archive_ext=7z
del %archive_full_base%.%archive_ext%
..\..\7za a %archive_type% %archive_full_base%.%archive_ext% .

@REM Return back to work folder
cd %pj_workdir%

goto start


:end

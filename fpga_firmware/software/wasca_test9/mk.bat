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

REM Set path to BSP folder
for %%a in ("%cd%") do set current_dir=%%~na
set bsp_dir="%cd%"\..\%current_dir%_bsp

REM Include stuff for STM32 firmware compilation
set PATH=C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2020-q4-major\bin;%PATH%


@REM Dummy initialize command
set cm=dmy

set pj_workdir="%cd%"
cd ..\..
set pj_basedir="%cd%"
cd %pj_workdir%

@REM Retrieve the branch name of this project from git informations
set pj_branch_name=master
cd ..\..\..\.git\refs\heads
for %%a in ("%cd%\*") do set pj_branch_name=%%~na
cd %pj_workdir%
for %%a in ("%cd%") do set pj_software_name=%%~na


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

echo --------------------- pj=%pj_branch_name%:%pj_software_name%
echo  Type `end' to end.
echo  Type `b' to run bash.
echo  Type `rb' to rebuild everything.
echo  Type `c' to clean project, excluding BSP.
echo  Type `m' or `m32' or `m10' to make project, excluding BSP.
echo  Type `s' to upload sof to SRAM.
echo  Type `e' to upload elf to OCRAM.
echo  Type `u' to upload both sof and elf.
echo  Type `flash' or `f32' or `f10' to flash CPLD and/or MCU.
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
If "%cm%" == "m10" goto do_make10
If "%cm%" == "m32" goto do_make32
If "%cm%" == "m" goto do_make10
If "%cm%" == "s" goto do_sof_upload
If "%cm%" == "e" goto do_elf_upload
If "%cm%" == "u" goto do_both_upload
If "%cm%" == "f10" goto do_flash10
If "%cm%" == "f32" goto do_flash32
If "%cm%" == "flash" goto do_flash32
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
echo #define MAX10_PROJ_NAME "%pj_branch_name%">> m10_ver_infos.h
echo #endif // M10_VER_INFOS_H>> m10_ver_infos.h

cat m10_ver_infos.h

@REM Update common headers and rebuild MAX 10 firmware
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./rebuild_all.sh

@REM Rebuild STM32 firmware
cd ..\..\..\mcu_firmware
make clean
make
cd %pj_workdir%

goto start


:do_clean
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./make_clean.sh

cd ..\..\..\mcu_firmware
make clean
cd %pj_workdir%

goto start


:do_make32
cd ..\..\..\mcu_firmware
make
cd %pj_workdir%
If "%cm%" == "m32" goto start

:do_make10
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



:do_flash32
cd ..\..\..\mcu_firmware

@REM If necessary, update the build file. And then upload it to board.
make && make upload

cd %pj_workdir%

If "%cm%" == "f32" goto start



:do_flash10
REM REM First, verify that project can compile correctly
REM del /Q %pj_software_name%.elf
REM call %quartus_path%\nios2eds\"Nios II Command Shell.bat" make
if exist %pj_software_name%.elf goto flash_compilation_ok
echo *** Compilation error ***
goto start

:flash_compilation_ok
REM Update CPLD flash log : write on this folder's log file and on the file common for all projects too.
set flash_log=Flash_Time: %date:~0,4%/%date:~5,2%/%date:~8,2%, %time:~0,2%:%time:~3,2%, Device: %dev_line:~9,14%, PL_Date: %pl_dt%, PJ_Name:%pj_branch_name%
echo %flash_log% >> m10_flash_log.txt

REM Then, rebuild the programming file since this is not done by the makefile
call %quartus_path%\nios2eds\"Nios II Command Shell.bat" ./rebuild_flash.sh

REM Finally, program the generated pof file to CPLD
quartus_pgm -z --mode=JTAG --operation="p;%pj_basedir%\output_files\nios2_ufm_boot_test9.pof"
goto start


:end

rem =====================================
rem WinBatchX Desktop 2023 Beta (Rev1)
rem Flag: BetaBuild
rem Not released to the Alpha Channel yet
rem Quantum Kernel 0.9 - Build 10000
rem =====================================


rem =====================================
rem The unlicense below is used for this 
rem "batch" software. Also in LICENSE.txt.

rem Unlicense License
rem - 
rem This is free and unencumbered software
rem released into the public domain.
rem 
rem Anyone is free to copy, modify, 
rem publish, use, compile, sell, or
rem distribute this software, either in 
rem source code form or as a compiled
rem binary, for any purpose, commercial
rem or non-commercial, and by any means.
rem 
rem In jurisdictions that recognize 
rem copyright laws, the author or authors 
rem of this software dedicate any and all 
rem copyright interest in the software to 
rem the public domain. We make this 
rem dedication for the benefit of the 
rem public at large and to the detriment 
rem of our heirs and successors. We intend
rem this dedication to be an overt act of 
rem relinquishment in perpetuity of all 
rem present and future rights to this 
rem software under copyright law.
rem
rem THE SOFTWARE IS PROVIDED "AS IS", 
rem WITHOUT WARRANTY OF ANY KIND, EXPRESS 
rem OR IMPLIED, INCLUDING BUT NOT LIMITED 
rem TO THE WARRANTIES OF MERCHANTABILITY,
rem FITNESS FOR A PARTICULAR PURPOSE AND 
rem NONINFRINGEMENT. IN NO EVENT SHALL THE 
rem AUTHORS BE LIABLE FOR ANY CLAIM, 
rem DAMAGES OR OTHER LIABILITY, WHETHER 
rem IN AN ACTION OF CONTRACT, TORT OR 
rem OTHERWISE, ARISING FROM, OUT OF OR IN
rem CONNECTION WITH THE SOFTWARE OR THE 
rem USE OR OTHER DEALINGS IN THE SOFTWARE.
rem 
rem For more information, please refer 
rem to <https://unlicense.org>
rem =====================================


@Echo off
If /i "%~1" == "" (goto :bootWBX.exe)
If /i "%~1" == "start" (goto :WBX-STARTUP.EXE)
If /i "%~1" == "startre" (call WINBATCHX/RECOVERY.BAT)

:bootWBX.exe
start WinBatchX start
endlocal
exit /b


:WBX-STARTUP.EXE

cd WINBATCHX
tar -xf SystemFiles.zip



rem  Bug Fixes that affect the user experience
rem  of WinBatchX's performance are set here.
setlocal EnableExtensions EnableDelayedExpansion
mode 213,60

rem Debug Mode Only
mode 1000,1000

chcp 437 > nul

cls
PIXELDRAW /refresh 00

rem ==================================
rem Boot Load WinBatchX Desktop 2023:
rem More simpler now, as most are in
rem services, yay!
rem ==================================
rem 1. Set General Variables
rem 2. Set Boot Time (Do we need it?)
rem 3. Start WBXFS - filesystem
rem 4. Start up 'OS Critical' Services
rem 5. Arrange memory for apps/services
rem 6. Start all other apps/services
rem ==================================


echo Starting WinBatchX..
echo Starting WinBatchX Boot Sector.

for /l %%a in (0,1,1024) do (echo %%a)

timeout /T 0 /NOBREAK > nul


rem (!) The terminology is quite confusing right now, so see a new build for
rem     better terminology(words) on WinBatchX Memory.
rem.
rem     Or check the wiki in github!



rem We load WinBatchX now im supposedly 'memory', so we write 64 lines for it.
rem If we run out of memory, we might add a page file (actually working) for it.

rem SO this is WinBatchX Memory:

rem We use WBX Memory to load apps/services that need to be put in memory.
rem Everything is NOW put in memory! You can actually try to still bypass it.

rem Memory: 64 bytes of memory.
rem This build has 64 'sets' of memory. Think of 'sets' as a file on a computer.
rem There are 'lines' in each 'set'. An example is the stuff in a file.
rem There are a maxinium set of lines (which is 2048).





rem Organized as:
rem System Reserved > Using > Standby (Overwriten) > Free







rem Start preloading memory sets:

for /l %%a in (0,1,64) do (cls &&set "_WBX-MEMORY-S%%a=0"
	call insertphoto 0 0 85 bootimage.bmp
	rem Start preloading memory lines:
	for /l %%b in (0,1,64) do (set "_WBX-MEMORY-S%%aL%%b=0" &&cls &&echo Preloading Set: %%a/64 &&echo Preloading Lines: %%b/64)
)





rem as of right now (in execution) it's BOOT.EXE:
set "_WBX-MEMORY-2=echo hi"





set "_WBX-MEMORY-1=1"
set "_WBX-MEMORY-1A=echo This is a system process."


set "_WBX-MEMORY-S2L2=timeout /T 0 /NOBREAK > nul"
set "_WBX-MEMORY-S2L3=cls"
set "_WBX-MEMORY-S2L4=PIXELDRAW /refresh 00"
set "_WBX-MEMORY-S2L5=timeout /T 2 /NOBREAK > nul"
set "_WBX-MEMORY-S2L6=call insertphoto 0 0 85 bootimage.bmp"
set "_WBX-MEMORY-S2L7=echo ??"
set "_WBX-MEMORY-S2L8="
set "_WBX-MEMORY-S2L9=rem 1"
set "_WBX-MEMORY-S2L10=rem Set General Variables "
set "_WBX-MEMORY-S2L11=SET "_WBX-OS=WinBatchX Desktop""
set "_WBX-MEMORY-S2L12=SET "_quantum-ver=0.9""
set "_WBX-MEMORY-S2L13=SET "_version=2023 Beta 1""
set "_WBX-MEMORY-S2L14=SET "_build=10000.100""
set "_WBX-MEMORY-S2L15="
set "_WBX-MEMORY-S2L16=rem Includes all techinal build info"
set "_WBX-MEMORY-S2L17=SET "_sysbuild=23.0.10000.100""
set "_WBX-MEMORY-S2L18="
set "_WBX-MEMORY-S2L19="
set "_WBX-MEMORY-S2L20="
set "_WBX-MEMORY-S2L21=rem 2"
set "_WBX-MEMORY-S2L22=SET _WBX-DATE=%DATE%"
set "_WBX-MEMORY-S2L23=SET _WBX-TIME=%TIME%"
set "_WBX-MEMORY-S2L24=SET "_STARTUPTIME=%_WBX-DATE% at %_WBX-TIME%""
set "_WBX-MEMORY-S2L25="
set "_WBX-MEMORY-S2L26="
set "_WBX-MEMORY-S2L27=rem WARNING!!"
set "_WBX-MEMORY-S2L28=rem Techinally WBX should be loading this into memory, then execute it!"
set "_WBX-MEMORY-S2L29=rem This can cause errors (possibly) as it was introduced without regonitation."
set "_WBX-MEMORY-S2L30="
set "_WBX-MEMORY-S2L31=rem TO be fixed in build 10002."
set "_WBX-MEMORY-S2L32="
set "_WBX-MEMORY-S2L33=CALL Services/TIMEDATE.bat"
set "_WBX-MEMORY-S2L34=CALL Services/PERSONALIZATION.bat"
set "_WBX-MEMORY-S2L35=CALL Services/SECURITY.bat"
set "_WBX-MEMORY-S2L36=CALL Services/WBXUPDATE.bat"
set "_WBX-MEMORY-S2L37="
set "_WBX-MEMORY-S2L38="
set "_WBX-MEMORY-S2L39=rem Some fun UI animations to make it look like the logo was popping up"
set "_WBX-MEMORY-S2L40=rem for /l %%a in (0,2,146) do (PIXELDRAW /dr 750 230 /rd 130 %%a /c 0)"
set "_WBX-MEMORY-S2L41=rem for /l %%a in (0,2,130) do (PIXELDRAW /dr 750 230 /rd %%a 146 /c 0)"
set "_WBX-MEMORY-S2L42="
set "_WBX-MEMORY-S2L43=rem STOP the boot screen"
set "_WBX-MEMORY-S2L44=for /l %%a in (0,1,146) do (PIXELDRAW /dr 750 230 /rd 130 %%a /c 0)"
set "_WBX-MEMORY-S2L45="
set "_WBX-MEMORY-S2L46=call insertphoto 0 0 85 blankSystemImage.bmp"
set "_WBX-MEMORY-S2L47=timeout /T 2 /NOBREAK > nul"
set "_WBX-MEMORY-S2L48=call Text 100 25 0f "Please Wait" X _Button_Boxes _Button_Hover"
set "_WBX-MEMORY-S2L49=timeout /T 1 /NOBREAK > nul"
set "_WBX-MEMORY-S2L50=EOF"







rem MEMORY LOADER:

:LOAD.EXE
for /l %%a in (0,1,64) do (cls &&set "_WBX-MEMORY-S%%a=0"
	call insertphoto 0 0 85 bootimage.bmp
	rem Start preloading memory lines:
	for /l %%b in (0,1,64) do (set "_WBX-MEMORY-S%%aL%%b=0" &&cls &&echo Preloading Set: %%a/64 &&echo Preloading Lines: %%b/64)
)












rem testing:
rem call insertphoto 770 600 100 loading-dot.bmp
rem call insertphoto 770 600 100 loading-blank.bmp











%_WBX-MEMORY-1%
%_WBX-MEMORY-2%


set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0
set _WBX-MEMORY-2=0














:LOGIN.EXE
call insertphoto 0 0 85 blankSystemImage.bmp

call Text 100 25 0f "Please Wait" X _Button_Boxes _Button_Hover

timeout /T 1 /NOBREAK > nul
call Text 96 26 0f "Loading LOGIN.EXE" X _Button_Boxes _Button_Hover

cls
PIXELDRAW /refresh 00
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp
call insertphoto 0 25 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 20 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 15 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 10 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 5 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp




Call Text 102 11 %THEMEcolor% %_WBX-TASKBAR-TIME% X _Button_Boxes _Button_Hover
Call Text 102 12 %THEMEcolor% %_WBX-TASKBAR-DATE% X _Button_Boxes _Button_Hover















:LOGIN.LOOP
call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 5 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 10 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 15 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 20 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 25 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp












rem 'WELCOME.EXE'
			rem Default Variables Set for Desktop:
			set _START.EXE=0
			set _START-POWERMENU.EXE=0
			set _SEARCH.EXE=0
			set _SEARCH.DATE=0
			set _TASKVIEW.EXE=0
			set _WIDGETS.EXE=0
			set _APP.EXE=0
			set _TASKBAROVERFLOW.EXE=0
			set _ACTION.EXE=0
			set _NOTIFICATION.EXE=0


		rem 7
			rem  Default Variables Set for WinBatchX
			SET _ACTIVEAPPLABEL=explorer.exe
			SET _ACTIVEAPPIMAGE=explorer
			SET _ACTIVEAPPTITLE=WinBatchX

			rem  Expermential Variables for windowed mode
			SET _ACTIVEAPPDRAG=
			SET _ACTIVEAPP.X=
			SET _ACTIVEAPP.Y=

rem 15
			rem code:
			rem 0 = off
			rem 1 = on!
			rem 2 = windowed
			rem 3 = minimized

			rem all the apps, in a alphabetical order-
			SET _BATCHINSTALLER.EXE=0

			SET _CALCULATOR.EXE=0
			SET "_CALCULATOR.FINAL=0"

			SET "_CALCULATOR.DIGIT1=0"
			SET "_CALCULATOR.DIGIT2=0"
			SET "_CALCULATOR.OPERAT=+"

			SET _CALENDAR.EXE=0

			SET _CLOCK.EXE=0

			SET _EDGE.EXE=0

			SET _EXPLORER.EXE=0

			SET _FEEDBACKHUB.EXE=0

			SET _NOTEPAD.EXE=0

			SET _PAINT.EXE=0
			SET _PAINT.COLOR=0

			SET _PHOTOS.EXE=0

			SET _RUN.EXE=0

			SET _SETTINGS.EXE=0
			SET _SETTINGS.SECTION=SYSTEM

			SET _SECURITY.EXE=0

			SET _TERMINAL.EXE=0

			SET _SNIPTOOL.EXE=0

			SET _TASKMGR.EXE=0

			SET _TIPS.EXE=0











:DISKWRITE.EXE

:: WBXFS 2000
:: This software is based on the Unlicense License.

:: Unlicense License (also in ../LICENSE.txt)
:: - 
:: This is free and unencumbered software released into the public domain.
::
:: Anyone is free to copy, modify, publish, use, compile, sell, or
:: distribute this software, either in source code form or as a compiled
:: binary, for any purpose, commercial or non-commercial, and by any
:: means.
::
:: In jurisdictions that recognize copyright laws, the author or authors
:: of this software dedicate any and all copyright interest in the
:: software to the public domain. We make this dedication for the benefit
:: of the public at large and to the detriment of our heirs and
:: successors. We intend this dedication to be an overt act of
:: relinquishment in perpetuity of all present and future rights to this
:: software under copyright law.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
:: EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
:: MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
:: IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
:: OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
:: ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
:: OTHER DEALINGS IN THE SOFTWARE.
:: 
:: For more information, please refer to <https://unlicense.org>

:: WBXFS: WinBatchX's New Interface File System
:: Note: This file system may contain bugs.

@ECHO OFF


:: setlocal

:: Set WBXFS Version

:: WBXFS Version
set WBXFS_VERSION=v1

:: Set WBXFS Build
set WBXFS_BUILDVERSION=2000


:: Check: parameters of WBXFS
If /i "%~1" == "/?" (goto :WBXFShelp)
If /i "%~1" == "help" (goto :WBXFShelp)

If /i "%~1" == "ver" (echo. &&echo WBXFS &&echo Version %WBXFS_VERSION%, Build %WBXFS_BUILDVERSION%. WBXFS is under the Unlicense License. &&echo.)
If /i "%~1" == "write" (goto :WBXFSwrite)
If /i "%~1" == "remove" (goto :WBXFSremove)
If /i "%~1" == "load" (goto :WBXFSload)

echo.
echo For help using the WBXFS file system, type 'wbxfs.bat help'.


exit /b



REM cordinates
:WBXFShelp


Set "_WBXFSChoice1=%~1"
echo "%_WBXFSChoice1%"
exit /b

rem how WBXFS Works:
rem WBXFS is a journaling-type file system that runs the entire batch file. it inputs files and exports them straight into the batch file.


:WBXFScreate
(
  echo SET C=Disk1
  echo SET VER=0
) > filesystem.bat
exit /b


:WBXFSlog
echo error
exit /b


:WBXFSread

rem make sure you set in this variable:

rem Wfilename = what the file you're trying to find

call filesystem.bat
exit /b


:WBXFSupdate
(
  echo SET W=test
  echo SET X=1
  echo SET Y=0
  echo SET "Z=Hello world!"
  echo CALL WBXFS readfile
  echo SET W=test
  echo SET X=2
  echo SET Y=0
  echo SET Z=0
  echo CALL WBXFS readfile
) >> filesystem.bat
exit /b



:WBXFSreadfile

:: W = name
:: NOTE: if you rename it the file gets deleted and logged 
::       and a new file with all the same stuff is added
::       in again



:: X = exists or no----

::   X = 1 = yes it exists

::   X = 2 = no it doesnt exist (anymore)
::           NOTE: The reader will ignore the file!



:: renames are too hard for WBXFS, its needs to be simple!

:: Y = filename

:: Z = stuff inside it
:: NOTE: Z can be left blank if X = 2 (erase)!

IF %C%==Disk1 IF %W%==%Wfilename% IF %X%==1 echo test
IF %C%==Disk1 IF %W%==%Wfilename% IF %X%==2 echo the file no longer exists
exit /b



:: stil in the works. WBXFS arch:


:: To call WBXFS:
:: All general variables will be set with this command:
:: =========================================================
:: call WBXFS -variables

:: To call a file in the WBXFS:
:: =========================================================
:: call WBXFS -file "file.extension"

:: coming soon!





rem  END OF WINBATCHX CODE
rem  WinBatchX.

:: Build 1640 OF WINBATCHX - WinBatchX 17.0!
:: This "batch" software is based on the Unlicense License, an open-source license.
:: - 
:: Unlicense License (also in LICENSE.txt)
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
::
:: - 

:: Batch Code
:: Please make sure what you are doing before editing WBX!





@ECHO OFF
CLS
setlocal
Window GSize Max
If /i "%~1" == "" (goto :bootWBX.exe)
If /i "%~1" == "start" (goto :bootWBX17)
If /i "%~1" == "startre" (goto :bootWBXre)

:: (!) Do not edit this, editing the 'start' flag may cause problems

:bootWBX.exe
cls
echo WinBatchX has started in another window.
start WinBatchX start
echo Please look for a window title named "WinBatchX".
endlocal
exit /b



:bootWBXre
:: (!) If you're wondering how to get to recovery, open a command prompt and type 'WinBatchX startre'
:: It does nothing right now.
setlocal
chcp 437 > nul
cd NI
echo hi
cls 
PIXELDRAW /refresh 00
cmdwiz showcursor 0
Window GSize Max
color f0
call insertphoto 0 0 95 bootimage.bmp

:: start the boot screen
CALL BOX 66 17 10 55 - - f3  f
call ButtonHeight0 67 17 f0 "WinBatchX Recovery" X _Button_Boxes _Button_Hover
call ButtonHeight0 67 19 f8 "Loading Recovery." X _Button_Boxes _Button_Hover

:: Create the progress bar
CALL BOX 70 18 5 0 - - 33  3


:: Terminal cursor reset
call ButtonHeight0 0 0 f3 "WinBatchX Recovery" X _Button_Boxes _Button_Hover


:: =========================================================================================
:: Boot WinBatchX Recovery steps:
:: =========================================================================================
:: 1. Set General Variables
:: 2. Set reason of recovery
:: 3. Start what needs to be started
:: =========================================================================================

:: IF anything goes wrong from here it will enter a crash state with a description where it crashed.

:: 1.

SET "_version=0"
SET "_build=1640"
SET "_OS-WBX=WinBatchX Recovery"
Title WinBatchX Recovery Enviroment - %_version%

:: Update the progress bar
timeout /T 3 /NOBREAK > nul
CALL BOX 71 18 5 0 - - 33  3
CALL BOX 72 18 5 0 - - 33  3
CALL BOX 73 18 5 0 - - 33  3
CALL BOX 74 18 5 0 - - 33  3



:: 2.
SET "_RECOVERY-REASON=WinBatchX Recovery."
:: this variable above can be changed later on.

:: tell the system to go down; no goto
SET "_RECOVERY-GOTO=NONEXECUTABLE"


:: Update the progress bar
timeout /T 2 /NOBREAK > nul
CALL BOX 75 18 5 0 - - 33  3
CALL BOX 76 18 5 0 - - 33  3

:: Update what's happening to the screen
call ButtonHeight0 67 19 f8 "Loading %_RECOVERY-REASON%." X _Button_Boxes _Button_Hover

:: Terminal cursor update
call ButtonHeight0 0 0 ff "             " X _Button_Boxes _Button_Hover


:: 3.



:: load the ascii database for letters (well, into memory I guess)
Call Load "Pixcel.fo" "ASCII.DB"

:: Update the progress bar
timeout /T 2 /NOBREAK > nul
CALL BOX 77 18 5 0 - - 33  3
CALL BOX 78 18 5 0 - - 33  3
CALL BOX 79 18 5 0 - - 33  3
CALL BOX 80 18 5 0 - - 33  3

:: Update what's happening to the screen
call ButtonHeight0 67 19 f8 "Loading into memory" X _Button_Boxes _Button_Hover
call ButtonHeight0 67 20 f8 "System may take a while." X _Button_Boxes _Button_Hover




:: Update the progress bar
timeout /T 4 /NOBREAK > nul
CALL BOX 81 18 5 0 - - 33  3
CALL BOX 82 18 5 0 - - 33  3
CALL BOX 83 18 5 0 - - 33  3
CALL BOX 84 18 5 0 - - 33  3
CALL BOX 85 18 5 0 - - 33  3
CALL BOX 86 18 5 0 - - 33  3
CALL BOX 87 18 5 0 - - 33  3
CALL BOX 88 18 5 0 - - 33  3
CALL BOX 89 18 5 0 - - 33  3
CALL BOX 90 18 5 0 - - 33  3
CALL BOX 91 18 5 0 - - 33  3
CALL BOX 92 18 5 0 - - 33  3
CALL BOX 93 18 5 0 - - 33  3
CALL BOX 94 18 5 0 - - 33  3
CALL BOX 95 18 5 0 - - 33  3
CALL BOX 96 18 5 0 - - 33  3
CALL BOX 97 18 5 0 - - 33  3
CALL BOX 98 18 5 0 - - 33  3
CALL BOX 99 18 5 0 - - 33  3
CALL BOX 100 18 5 0 - - 33  3
CALL BOX 101 18 5 0 - - 33  3
CALL BOX 102 18 5 0 - - 33  3
CALL BOX 103 18 5 0 - - 33  3
CALL BOX 104 18 5 0 - - 33  3
CALL BOX 105 18 5 0 - - 33  3
CALL BOX 106 18 5 0 - - 33  3
CALL BOX 107 18 5 0 - - 33  3
CALL BOX 108 18 5 0 - - 33  3
CALL BOX 109 18 5 0 - - 33  3
CALL BOX 110 18 5 0 - - 33  3
CALL BOX 111 18 5 0 - - 33  3
CALL BOX 112 18 5 0 - - 33  3
CALL BOX 113 18 5 0 - - 33  3
CALL BOX 114 18 5 0 - - 33  3
CALL BOX 115 18 5 0 - - 33  3

:: Update what's happening to the screen
call ButtonHeight0 67 19 f8 "Please Wait..                " X _Button_Boxes _Button_Hover
:: note- erase earlier
call ButtonHeight0 67 20 ff "                             " X _Button_Boxes _Button_Hover

timeout /T 1 /NOBREAK > nul
cls

call ButtonHeight0 67 19 0f "There are are no options to" X _Button_Boxes _Button_Hover
call ButtonHeight0 67 20 0f " recovery right now." X _Button_Boxes _Button_Hover
call ButtonHeight0 67 25 04 "Press a key to exit" X _Button_Boxes _Button_Hover

pause > nul
exit /b
























:bootWBX17
setlocal
Window GSize Max
chcp 437 > nul
cd NI

cls 
PIXELDRAW /refresh 00
cmdwiz showcursor 0


call insertphoto 0 0 95 bootimage.bmp

:: Terminal cursor reset
call ButtonHeight0 0 0 03 "WinBatchX" X _Button_Boxes _Button_Hover


:: start the boot screen
::CALL BOX 96 27 10 55 - - f3  f
::call ButtonHeight0 97 27 f0 "WinBatchX Beta" X _Button_Boxes _Button_Hover
::call ButtonHeight0 97 29 f8 "Starting." X _Button_Boxes _Button_Hover


:: Boot WBX-17:
:: =========================================================================================
:: General Stage
	:: 01. Set General Variables
	:: 02. Set Time Variables
	:: 03. Import settings from systemdata.bat
:: Variable Stage
	:: 04. Set NI Kernel variables
	:: 05. Set app variables
	:: 06. Set personalization variables
:: Services Stage
	:: 07. Start WBXU Service (WinBatchX-Update: WGET.EXE)
	:: 08. Start WBXS Service (WinBatchX-Security)
	:: 09. Start System Service(s) (All security for batch apps)
	:: 10. Start S-BAG Service (Secure Batch App Guard)
	:: 11. Start SAS Service (Secure App Signing)
:: Login Stage
	:: 12. Load ASCII Library for the big clock on login
:: Login (13)
:: =========================================================================================



:: 01 General Variables
SET "_OS-WBX=WinBatchX Beta"
SET "_NI-KERNEL=11.0beta2"
SET "_version=17.0 Beta"
SET "_build=1640"

Title WinBatchX %_version% - %_build%





:: 02 Time Variables
SET TIMETEMP1=0
SET TIMETEMP2=0
SET TIMETEMP3=0
::
SET _DATESTART=%DATE%
SET _TIMESTART=%TIME%
SET "_STARTTIME=%_DATESTART% %_TIMESTART%"
::
set "DATE-FIXED-TASKBAR=%DATE:~-4%-%DATE:~-10,2%-%DATE:~-7,2%"
SET DATETEMP1=%DATE:~-4%
IF %DATETEMP1%==01 set "DATETEMP1= 1"
IF %DATETEMP1%==02 set "DATETEMP1= 2"
IF %DATETEMP1%==03 set "DATETEMP1= 3"
IF %DATETEMP1%==04 set "DATETEMP1= 4"
IF %DATETEMP1%==05 set "DATETEMP1= 5"
IF %DATETEMP1%==06 set "DATETEMP1= 6"
IF %DATETEMP1%==07 set "DATETEMP1= 7"
IF %DATETEMP1%==08 set "DATETEMP1= 8"
IF %DATETEMP1%==09 set "DATETEMP1= 9"
set "DATE-FIXED-TASKBAR=%DATETEMP1%/%DATE:~-10,2%/%DATE:~-7,2%"



::
set TIMETEMP1=%Time:~0,-9%
set TIMETEMP2=%Time:~3,-6%
IF %TIMETEMP1%==13 set TIMETEMP1= 1&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==14 set TIMETEMP1= 2&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==15 set TIMETEMP1= 3&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==16 set TIMETEMP1= 4&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==17 set TIMETEMP1= 5&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==18 set TIMETEMP1= 6&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==19 set TIMETEMP1= 7&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==20 set TIMETEMP1= 8&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==21 set TIMETEMP1= 9&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==22 set TIMETEMP1=10&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==23 set TIMETEMP1=11&set TIMETEMP3=PM &GOTO :TIMECOMPOSE-BOOT
IF %TIMETEMP1%==24 set TIMETEMP1=12&set TIMETEMP3=AM &GOTO :TIMECOMPOSE-BOOT
set TIMETEMP3=AM
::
:TIMECOMPOSE-BOOT
set "TIME-FIXED-TASKBAR=%TIMETEMP1%:%TIMETEMP2% %TIMETEMP3%"
::
set TIMETEMP1=0
set TIMETEMP2=0
set TIMETEMP3=0
::
set "DATE-FIXED-TASKBAR=%DATE:~-10,2%/%DATE:~-7,2%/%DATE:~-4%"




:: 03 Import systemdata.bat

set START-STATUS=0
set FLAG-RECOVERYRESTART=0
set HIBERNATE-STATUS=0
set RESTART-STATUS=0

:: data-system.bat does not contain flags
call data-system.bat

IF %RECOVERYRESTART%==1 cd .. &start WinBatchX startre &exit
IF %START-STATUS%==1 call ButtonHeight0 97 29 f4 "Make sure you shut down your computer correctly." X _Button_Boxes _Button_Hover &call ButtonHeight0 97 30 f4 "You did not shut down properly last time." X _Button_Boxes _Button_Hover





:: 04 NI Kernel Variables
SET _NI_THEME=
SET _NI_WINDOWCOLOR=
SET _NI_ACCENTCOLOR=blue

SET _LAST-ACTIVEAPP=DESKTOP.EXE
SET _LAST-ACTIVEAPP-BMP=DESKTOP
SET _LAST-ACTIVEAPP-NAME=DESKTOP



:: 05 App Variables

SET _APPINSTALLER.EXE=off

SET _CALC.EXE=off
SET _CALC.EXE-NUMBER-1=0
SET _CALC.EXE-NUMBER-2=0
SET _CALC.EXE-NUMBER-3=0
SET _CALC.EXE-NUMBER-4=0
SET _CALC.EXE-NUMBER-5=0
SET _CALC.EXE-NUMBER-6=0
SET _CALC.EXE-NUMBER-7=0
SET _CALC.EXE-NUMBER-8=0
SET _CALC.EXE-NUMBER-9=0
SET _CALC.EXE-NUMBER-10=0
SET _CALC.EXE-OPERATION-SIGN=+
SET _CALC.EXE-SAVED-CALC-NUMBER=NO
SET _CALC.EXE-CALCANSWER=

SET _CALENDAR.EXE=off

SET _CLOCK.EXE=off

SET _EDGE.EXE=off

SET _EXPLORER.EXE=off

SET _NOTEPAD.EXE=off
SET _NOTEPAD.EXE-WRITE=
SET _NOTEPAD.EXE-FORMAT=
SET _NOTEPAD.EXE-NAME=

SET _PHOTOS.EXE=off

SET _PAINT.EXE=off
SET _PAINT.COLOR=0

SET _SETTINGS.EXE=off
SET _SETTINGS.SECTION=SYSTEM

SET _SECURITY.EXE=off

SET _TERMINAL.EXE=off

SET _WORDPAD.EXE=off

SET _REGEDIT.EXE=off
SET _REQUEST-OPEN-REGEDIT.EXE=off
SET _REQUEST-MAX-REGEDIT.EXE=off
SET _REQUEST-MIN-REGEDIT.EXE=off
SET _REGEDIT.EXE-LAST-LOCATION-XCOORDINATE=
SET _REGEDIT.EXE-LAST-LOCATION-YCOORDINATE=

SET _SNIPTOOL.EXE=off

SET _STICKYNOTES.EXE=off

SET _TASKMGR.EXE=off

SET _TIPS.EXE=off

:: 06 Personalization Variables
call data-settings.bat
timeout /T 1 /NOBREAK > nul


:: 07-11 Start Services
:WBX-SERVICESTART.EXE
cls
CALL BOX 91 25 10 62 - - 03  f
PIXELDRAW /refresh 00
timeout /T 0 /NOBREAK > nul

call ButtonHeight0 97 27 0f "Starting WBXU (WBX-Update via WGET) Service" X _Button_Boxes _Button_Hover
call :WBXU.SVC
timeout /T 0 /NOBREAK > nul

CALL BOX 91 25 10 62 - - 03  f
PIXELDRAW /refresh 00
timeout /T 0 /NOBREAK > nul

call ButtonHeight0 98 27 0f "Starting WBXS (Windows Security) Service" X _Button_Boxes _Button_Hover
call :WBXS.SVC
timeout /T 0 /NOBREAK > nul


:: 10 Start S-BAG
CALL BOX 91 25 10 62 - - 03  f
PIXELDRAW /refresh 00
timeout /T 0 /NOBREAK > nul

call ButtonHeight0 95 27 0f "Starting the S-BAG (Secure Batch App Guard) Service" X _Button_Boxes _Button_Hover
call :SBAG.SVC
timeout /T 0 /NOBREAK > nul

:: 11 Start SAS
CALL BOX 91 25 10 62 - - 03  f
PIXELDRAW /refresh 00
timeout /T 0 /NOBREAK > nul

call ButtonHeight0 96 27 0f "Starting the SAS (Secure App Control) Service" X _Button_Boxes _Button_Hover
call :SAS.SVC
timeout /T 0 /NOBREAK > nul


:: 12 Start UserProfiles
CALL BOX 91 25 10 62 - - 03  f
PIXELDRAW /refresh 00
timeout /T 0 /NOBREAK > nul

call ButtonHeight0 100 27 0f "Starting the UserProfiles Service" X _Button_Boxes _Button_Hover
call :UserProfiles.SVC
timeout /T 0 /NOBREAK > nul



:: 13 Finish loading
CALL BOX 91 25 10 62 - - 03  f
PIXELDRAW /refresh 00
timeout /T 0 /NOBREAK > nul

:: Load the ASCII database for numbers on the desktop
Call Load "Pixcel.fo" "ASCII.DB"

call ButtonHeight0 105 27 0f "Preparing WinBatchX." X _Button_Boxes _Button_Hover
timeout /T 1 /NOBREAK > nul

goto :WBX-USERLOGIN.EXE



:: Services at Line 500
:: (!) Make sure you are using 'call' when using the service!


:WBXU.SVC
:: 07 WBX UpdateCheck - wget
:: Retrieves data for WinBatchX Update.
rem We don't use %_LINK% anymore as it can be easily changed.
:: download it quietly using -q. It won't spam the command line.
wget -q "https://github.com/bes-ptah/WinBatchX/archive/refs/heads/main.zip" > nul
:: Unpack it (This is why Windows 1809 and higher is recommended, or use tar yourself)
tar -xf main.zip
:: Enter the directory (always this name)
cd winbatchx-main
:: Enter the update directory
cd update
:: CALL the program
:: (!) the variables are new for 17.0
call update.bat
:: Then remove the old files.
del update.bat
cd ..
:: delete it without a request from user.
rmdir update > nul
del LICENSE
del README.md
del _config.yml
:: go back into the system directory.
cd ..
:: remove the folder itself.
rmdir winbatchx-main > nul
:: delete the zip file downloaded so the next download update wont crash the cmd line.
del main.zip
IF %_WBXCore-update%==1 set "UPDATE-USERFIND=System is up to date."
IF %_WBXCore-update%==2 set "UPDATE-USERFIND=There is a new update."
IF %_WBXCore-update%==3 set "UPDATE-USERFIND=System Update Failed."
exit /b



:WBXS.SVC
:: 08 Security Check
set "CD_winbatchx=%CD%"
cd C:\Program Files\Windows Defender
MpCmdRun -Scan -ScanType 3 -File %CD_winbatchx% > nul
:: The 3rd flag tells it as a custom scan.
:: Change directory back to WBX-17.
cd "%CD_winbatchx%"
exit /b








:SBAG.SVC
exit /b



:SAS.SVC
exit /b






:UserProfiles.SVC
call data-user.bat
exit /b







:SYSTEMDATA.SVC
ECHO SET RECOVERYRESTART=%RECOVERYRESTART%> data-system.bat
ECHO SET START-STATUS=%START-STATUS%>> data-system.bat
ECHO SET HIBERNATE-STATUS=%HIBERNATE-STATUS%>> data-system.bat
ECHO SET RESTART-STATUS=%RESTART-STATUS%>> data-system.bat
exit /b






:USERDATA.SVC
ECHO SET _WBX_USERNAME=%_WBX_USERNAME%>> data-user.bat
ECHO SET _WBX_PASSWORD=%_WBX_PASSWORD%>> data-user.bat
exit /b






















































:WBX-USERLOGIN.EXE
cls 
PIXELDRAW /refresh 00
call insertphoto 0 0 %lock-wallpapersize% %lock-screen%.bmp
Call Typo - 95 3 ff %TIME-FIXED-TASKBAR%
Call ButtonHeight0 102 12 f0 %DATE-FIXED-TASKBAR% X _Button_Boxes _Button_Hover


call insertphoto 1380 770 40 UI.buttonmica.bmp
call insertphoto 1379 771 41 UI.buttonmica.bmp
call insertphoto 1381 774 40 UI.buttonmica.bmp
call insertphoto 1420 780 125 ui.power.bmp






:WBX-USERLOGIN.INPUT
set _I=k
set _M=0
set _X=0
set _Y=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('Input.exe F') Do (
	Set I=%%A
	Set M=%%B
	Set X=%%C
	Set Y=%%D
	title WinBatchX [%%A] [%%B] [%%C] [%%D]
	)
IF %I%==m IF %M%==1 IF %X% GTR 197 IF %Y% GTR 54 IF %X% LSS 211 IF %Y% LSS 57 goto :WBX-USERLOGIN.POWER
IF %I%==m IF %M%==1 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 211 IF %Y% LSS 58 goto :WBX-USERLOGIN.LOOP

goto :WBX-USERLOGIN.INPUT
















:WBX-USERLOGIN.POWER
call insertphoto 1380 680 40 UI.buttonmica.bmp
call insertphoto 1379 681 41 UI.buttonmica.bmp
call insertphoto 1381 684 40 UI.buttonmica.bmp
call insertphoto 1380 720 40 UI.buttonmica.bmp
call insertphoto 1379 721 41 UI.buttonmica.bmp
call insertphoto 1381 724 40 UI.buttonmica.bmp

Call ButtonHeight0 200 49 f0 "Restart" X _Button_Boxes _Button_Hover
Call ButtonHeight0 200 51 f0 "Shut Down" X _Button_Boxes _Button_Hover

:WBX-USERLOGIN.POWER.LOOP
set _I=k
set _M=0
set _X=0
set _Y=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('Input.exe F') Do (
	Set I=%%A
	Set M=%%B
	Set X=%%C
	Set Y=%%D
	title WinBatchX [%%A] [%%B] [%%C] [%%D]
	)

IF %I%==m IF %M%==1 IF %X% GTR 197 IF %Y% GTR 48 IF %X% LSS 211 IF %Y% LSS 51 kernelreboot reboot
IF %I%==m IF %M%==1 IF %X% GTR 197 IF %Y% GTR 51 IF %X% LSS 211 IF %Y% LSS 53 exit
::timeout /T 0 /NOBREAK > nul
IF %I%==m IF %M%==1 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 211 IF %Y% LSS 60 goto :WBX-USERLOGIN.EXE

goto :WBX-USERLOGIN.POWER.LOOP










:WBX-USERLOGIN.LOOP
call insertphoto 0 0 %lock-wallpapersize% %lock-screen%.bmp

:: GUI behind the profile photo
call insertphoto 789 279 125 blank.bmp
call insertphoto 790 278 135 blank.bmp
call insertphoto 815 278 125 blank.bmp
call insertphoto 816 279 125 blank.bmp

call insertphoto 789 295 125 blank.bmp
call insertphoto 816 295 125 blank.bmp

call insertphoto 790 296 125 blank.bmp
call insertphoto 815 296 125 blank.bmp


:: profile photo
call insertphoto 790 280 60 profile-icon.bmp


:: Main password GUI
call insertphoto 750 450 40 blank.bmp
call insertphoto 780 449 40 blank.bmp
call insertphoto 810 449 40 blank.bmp
call insertphoto 840 449 40 blank.bmp
call insertphoto 870 449 40 blank.bmp
call insertphoto 900 449 40 blank.bmp
call insertphoto 937 449 40 blank.bmp

:: Round the Main Pasword GUI
call insertphoto 751 449 40 blank.bmp
call insertphoto 751 451 40 blank.bmp
call insertphoto 780 451 40 blank.bmp
call insertphoto 810 451 40 blank.bmp
call insertphoto 840 451 40 blank.bmp
call insertphoto 870 451 40 blank.bmp
call insertphoto 900 451 40 blank.bmp
call insertphoto 937 451 40 blank.bmp
call insertphoto 939 450 39 blank.bmp
call insertphoto 939 451 39 blank.bmp
:WBX-USERLOGIN.LOGIN
PIXELDRAW /dr 760 455 /rd 210 35 /c 0
call ButtonHeight0 105 36 f0 "                                     " X _Button_Boxes _Button_Hover
PIXELDRAW /dr 930 458 /rd 30 30 /c 0
call ButtonHeight0 109 32 f0 "                " X _Button_Boxes _Button_Hover
BatBOX /g 112 33 /d ""
SET _PASS=
SET /p _PASS=
IF %_WBX_PASSWORD%==%_PASS% GOTO :WBXStartDesktop.EXE

:: (!) Soon it will be possible to click and type at the same time on WinBatchX, like on login. I have not added the shutdown or restart buttons.


:WBX-USERLOGIN.ERROR
call ButtonHeight0 105 36 f0 "The password is incorrect. Try again." X _Button_Boxes _Button_Hover
timeout /T 1 /NOBREAK > NUL
goto :WBX-USERLOGIN.LOGIN








:: WBX-STARTMENU.EXE
:: WBX-STARTMENU-ALL-APPS.EXE
:: WBX-SEARCH.EXE
:: WBX-SEARCHCOMPLETE.EXE
:: WBX-TASKVIEW.EXE
:: WBX-WIDGETS.EXE
:: WBX-APP.EXE (excluded from this list)
:: WBX-ACTIONCENTER.EXE
:: WBX-NOTIFICATIONCENTER.EXE



















:: NI Kernel 11.0 INTERFACE RELEASE
:: The NI "interface" is the current system and app kernel. As an app kernel, it's really bad.
:: THE Quantum Kernel (expermential GUI) is a techinal 'addon' to the NI kernel. It manages the GUI materials.

:: WBX.EXE
:WBXStartDesktop.EXE


call insertphoto 0 0 %lock-wallpapersize% %lock-screen%.bmp

:: GUI behind the profile photo
call insertphoto 799 279 125 blank.bmp
call insertphoto 800 278 135 blank.bmp
call insertphoto 825 278 125 blank.bmp
call insertphoto 826 279 125 blank.bmp

call insertphoto 799 295 125 blank.bmp
call insertphoto 826 295 125 blank.bmp

call insertphoto 800 296 125 blank.bmp
call insertphoto 825 296 125 blank.bmp


:: profile photo
call insertphoto 800 280 60 profile-icon.bmp

call ButtonHeight0 120 33 f3 "Welcome" X _Button_Boxes _Button_Hover
call ButtonHeight0 118 34 f3 "Please Wait" X _Button_Boxes _Button_Hover


:: This is here for loading the calendar in the notification center.
:: Most author's comments are untouched.

:: Xp batch for generating calendars
:: Chances look good for win 2000 and above(untested)
:: By Judago, August 2009



:: The current codepage is stored in variable %CodePage%,
:: then changed to 850 to facilitate box drawing characters.....

SETLOCAL ENABLEDELAYEDEXPANSION

:loop-cal
FOR %%Z IN (jan feb mar apr may jun jul aug sep oct nov dec year day leap noleap length test) DO SET %%Z=

set "year=%DATE:~-4%"

IF NOT DEFINED year (

	CHCP %CodePage% >NUL 2>&1
	EXIT /B
)


SET test=!year!
FOR /l %%Z IN (0 1 9) DO IF DEFINED test SET "test=!test:%%Z=!"
IF DEFINED test CLS&GOTO loop-cal
:zero
IF NOT DEFINED year (
	:error-cal
	cls
	echo The year entered can not be accepted.
	echo.
	pause
	CLS
	GOTO loop-cal
)

IF "%year:~0,1%"=="0" SET year=%year:~1%&&GOTO zero


IF /I "!processor_architecture!"=="x86" (
	IF !year! gtr 1717986917 GOTO :error-cal
) else (
	IF NOT "!processor_architecture:64=!"=="!processor_architecture!" (
		IF !year! gtr 7378697629483820645 GOTO :error-cal
	)
)


SET /A day=(year + year / 4) - (year / 100 - year / 400)
SET /A leap=year %% 400
SET /A noleap=year %% 100
IF !leap! GTR 0 (
	IF !noleap! NEQ 0 SET /A leap=year %% 4
)
IF %leap%==0 SET /A day-=1
SET /A day%%=7


FOR %%U IN (jan feb mar apr may jun jul aug sep oct nov dec) DO (
	FOR %%V IN (jan mar may jul aug oct dec) DO IF /I %%U==%%V SET length=31
	FOR %%W IN (apr jun sep nov) DO IF /I %%U==%%W SET length=30
	IF /I %%U==feb (
		IF !leap!==0 (
			SET length=29
		) else (
			SET length=28
		)
	)
	FOR /l %%X IN (1 1 !day!) DO SET "%%U=!%%U!   "
	FOR /l %%Y IN (1 1 !length!) DO (
		IF %%Y lss 10 (
			SET "%%U=!%%U!%%Y  "
		) else (
			SET "%%U=!%%U!%%Y "
		)
	)
	FOR /l %%Z IN (!length! 1 54) DO IF "!%%U:~110!"=="" SET "%%U=!%%U! "
	SET /A day=^(day + length^) %% 7
)




:: WBX DESKTOP
set WBX.EXE=off
set WBX-STARTMENU=off
set WBX-STARTMENU-POWERMENU.EXE=off
set WBX-SEARCHBAR=off
set WBX-TASKVIEW=off
set WBX-WIDGETS=off
set WBX-APP=off
set WBX-ACTIONCENTER=off
set WBX-NOTIFICATIONCENTER=off


set WBX-START=inactive
set WBX-SEARCH=inactive
set WBX-TASKVIEW=inactive
set WBX-WIDGETS=inactive
set WBX-APP=inactive
set WBX-ACTIONCENTER=inactive
set WBX-NOTIFICATIONCENTER=inactive


set _WBX-STARTMENU=off
set _WBX-SEARCHBAR=off
set _WBX-TASKVIEW=off
set _WBX-WIDGETS=off
set _WBX-APP=off
set _WBX-ACTIONCENTER=off
set _WBX-NOTIFICATIONCENTER=off

set TEMP-SEARCHBAR-NUM=1
set TEMP-SEARCHBAR-CHAR-1=
set TEMP-SEARCHBAR-CHAR-2=
set TEMP-SEARCHBAR-CHAR-3=
set TEMP-SEARCHBAR-CHAR-4=
set TEMP-SEARCHBAR-CHAR-5=
set TEMP-SEARCHBAR-CHAR-6=
set TEMP-SEARCHBAR-CHAR-7=
set TEMP-SEARCHBAR-CHAR-8=
set TEMP-SEARCHBAR-CHAR-9=
set TEMP-SEARCHBAR-CHAR-10=

:: expermential flag
set _NOTEPAD.EXE=off
set notepadkey=0

:: I will shorten this amount of time to wait
:: For now its 2seconds until desktop
:: This waits for all variables to be proved
timeout /NOBREAK /T 2 > nul

cls
goto :WBX.EXE







:WBX.EXE
call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp
::List of last active apps. Part of the window manager. Do not remove the line(s) below.
IF %_LAST-ACTIVEAPP%==notepad.exe goto :NOTEPAD.EXE
IF %_LAST-ACTIVEAPP%==calendar.exe goto :CALENDAR.EXE
IF %_LAST-ACTIVEAPP%==paint.exe goto :PAINT.EXE
IF %_LAST-ACTIVEAPP%==settings.exe goto :SETTINGS.EXE
IF %_LAST-ACTIVEAPP%==explorer.exe goto :EXPLORER.EXE
IF %_LAST-ACTIVEAPP%==taskmgr.exe goto :TASKMGR.EXE
set _LAST-ACTIVEAPP=WBX.EXE
set _LAST-ACTIVEAPP-BMP==desktop
SET _LAST-ACTIVEAPP-NAME=Desktop


:: Background + UI = :WBXCompose.exe
call :WBXCOMPOSE.EXE
:: call insertphoto 0 820 1021 taskbar-black.bmp

:: Having watermarks on the desktop is a nice way to find out your version.
:: Not included in general releases! Check Settings > About for info
 :: CALL Button 178 53 f0 "WinBatchX 17.0 Beta Build %_build%" X _Button_Boxes _Button_Hover
 :: CALL ButtonHeight0 178 54 f0 "NI Kernel %_NI-KERNEL%" X _Button_Boxes _Button_Hover



::Some UI testing on the desktop for b1634

::call insertphoto 100 100 40 UI.buttonblue.bmp
::call insertphoto 99 101 41 UI.buttonblue.bmp
::call insertphoto 101 104 40 UI.buttonblue.bmp



::call insertphoto 100 100 40 UI.buttonwhite.bmp
::call insertphoto 99 101 41 UI.buttonwhite.bmp
::call insertphoto 101 104 40 UI.buttonwhite.bmp


call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
goto :WBXCore.EXE

goto :WBX.EXE



:WBXCOMPOSE.EXE

:: Resized these numbers to fit on the taskbar.
call insertphoto 0 0 77 1.bmp
call insertphoto 744 0 77 2.bmp
call insertphoto 0 402 77 3.bmp
call insertphoto 744 402 77 4.bmp

exit /b




::
:: APP
:: APP 
:: APP
:: APP

:: MOVEFILEARNOUNDDESKTOP (Comming soon!)

:: RIGHTCLICKDESKTOP
:: RIGHTCLICKAPPSONTASKBAR
:: RIGHTCLICKTASKBAR
:: RIGHTCLICKNOTIFICATIONCENTER
:: RIGHTCLICKACTIONCENTER
:: RIGHTCLICKSTARTMENU
:: STARTMENU
:: SEARCH
:: TASKVIEW
:: WIDGETS
:: NOTIFICATIONCENTER
:: ACTIONCENTER








:: Know that WBXCore.EXE is very long! You should know what you are doing!!!
:: DO NOT RELY ON LINE NUMBERS. It can cause damage to this file (makes it unstable when using it in some way).

:WBXCore.EXE

set _I=k
set _M=0
set _X=0
set _Y=0


For /f "Tokens=1,2,3,4* delims=:" %%A in ('Input.exe F') Do (
	Set I=%%A
	Set M=%%B
	Set X=%%C
	Set Y=%%D
	title WinBatchX [%%A] [%%B] [%%C] [%%D]
	)

    :: expermential flag: notepad keys.
    :: IF %I%==k IF %_LAST-ACTIVEAPP%==notepad.exe set notepadkey%notepadkey%=%M% &set /A "notepadkeynew=%notepadkey% + 1" &set notepadkey=%notepadkeynew% &goto :Notepad.loop

    IF %I%==k goto :WBXCore.EXE

	set TIMETEMP1=%Time:~0,-9%
	set TIMETEMP2=%Time:~3,-6%

	:: Time calculations.
	set TIMETEMP1=%Time:~0,-9%
	set TIMETEMP2=%Time:~3,-6%
	IF %TIMETEMP1%==13 set TIMETEMP1= 1&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==14 set TIMETEMP1= 2&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==15 set TIMETEMP1= 3&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==16 set TIMETEMP1= 4&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==17 set TIMETEMP1= 5&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==18 set TIMETEMP1= 6&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==19 set TIMETEMP1= 7&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==20 set TIMETEMP1= 8&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==21 set TIMETEMP1= 9&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==22 set TIMETEMP1=10&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==23 set TIMETEMP1=11&set TIMETEMP3=PM&GOTO :WBX-TIMECOMPILE.EXE
	IF %TIMETEMP1%==24 set TIMETEMP1=12&set TIMETEMP3=AM&GOTO :WBX-TIMECOMPILE.EXE
	set TIMETEMP3=AM

	:WBX-TIMECOMPILE.EXE

	set "TIME-FIXED-TASKBAR=%TIMETEMP1%:%TIMETEMP2% %TIMETEMP3%"

	:: Reset Variables
	set TIMETEMP1=0
	set TIMETEMP2=0
	set TIMETEMP3=0

	SET "DATETEMP1=%DATE:~-10,2%"
	IF %DATETEMP1%==01 set "DATETEMP1= 1"
	IF %DATETEMP1%==02 set "DATETEMP1= 2"
	IF %DATETEMP1%==03 set "DATETEMP1= 3"
	IF %DATETEMP1%==04 set "DATETEMP1= 4"
	IF %DATETEMP1%==05 set "DATETEMP1= 5"
	IF %DATETEMP1%==06 set "DATETEMP1= 6"
	IF %DATETEMP1%==07 set "DATETEMP1= 7"
	IF %DATETEMP1%==08 set "DATETEMP1= 8"
	IF %DATETEMP1%==09 set "DATETEMP1= 9"
	set "DATE-FIXED-TASKBAR=%DATETEMP1%/%DATE:~-7,2%/%DATE:~-4%"
	SET DATETEMP1=0
	CALL ButtonHeight0 201 56 f0 "%TIME-FIXED-TASKBAR%" 199 57 f0 "%DATE-FIXED-TASKBAR%" X _Button_Boxes _Button_Hover






:: GUI SYSTEM!
:: READ FIRST

:: There are 2 types of ways WinBatchX uses with NI's GUI to make and use an interface:
::
:: X X Y Y TYPE GUI ARRAY. Example: IF %X% GTR # IF %X% LSS # IF %Y% GTR # IF %Y% LSS # COMMAND HERE
::
:: X Y X Y TYPE GUI ARRAY. Example: IF %X% GTR # IF %Y% GTR # IF %X% LSS # IF %Y% LSS # COMMAND HERE
::
:: None of the if's are shorter than that, but X Y X Y does better in some situations, because pair 'x y' is plot 1 and the other 'x y' is plot 2. Much easier to humans reading this, right??

:: Part of the window manager for minimizing/closing apps

	:: Closing Apps
	IF %_LAST-ACTIVEAPP%==notepad.exe IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %X% LSS 211 IF %Y% GTR 0 IF %Y% LSS 2 SET _LAST-ACTIVEAPP=DESKTOP.EXE &SET _NOTEPAD.EXE=off &goto :WBX.EXE
	IF %_LAST-ACTIVEAPP%==calendar.exe IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %X% LSS 211 IF %Y% GTR 0 IF %Y% LSS 2 SET _LAST-ACTIVEAPP=DESKTOP.EXE &SET _CALENDAR.EXE=off &goto :WBX.EXE
	IF %_LAST-ACTIVEAPP%==paint.exe IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %X% LSS 211 IF %Y% GTR 0 IF %Y% LSS 2 SET _LAST-ACTIVEAPP=DESKTOP.EXE &SET _PAINT.EXE=off &goto :WBX.EXE
	IF %_LAST-ACTIVEAPP%==settings.exe IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %X% LSS 211 IF %Y% GTR 0 IF %Y% LSS 2 SET _LAST-ACTIVEAPP=DESKTOP.EXE &SET _SETTINGS.EXE=off &goto :WBX.EXE
	IF %_LAST-ACTIVEAPP%==explorer.exe IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %X% LSS 211 IF %Y% GTR 0 IF %Y% LSS 2 SET _LAST-ACTIVEAPP=DESKTOP.EXE &SET _EXPLORER.EXE=off &goto :WBX.EXE
	IF %_LAST-ACTIVEAPP%==taskmgr.exe IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %X% LSS 211 IF %Y% GTR 0 IF %Y% LSS 2 SET _LAST-ACTIVEAPP=DESKTOP.EXE &SET _TASKMGR.EXE=off &goto :WBX.EXE

::This is in the pattern, left-to-right, in the taskbar.

:: WIDGET BUTTON
:: X Y X Y GUI ARRAY


IF %_WBX-WIDGETS%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 0 IF %Y% GTR 56 IF %X% LSS 8 IF %Y% LSS 59 set M=0 &set _WBX-WIDGETS=off &set WBX-WIDGETS=inactive &goto :WBX.EXE
IF %_WBX-WIDGETS%==off IF %I%==m IF %M% EQU 1 IF %X% GTR 0 IF %Y% GTR 56 IF %X% LSS 8 IF %Y% LSS 59 set M=0 &goto :WBX-WIDGETS.EXE



:: START MENU CLICK BUTTON
:: Using X X Y Y TYPE GUI ARRAY.
IF %I%==m IF %M% EQU 1 IF %WBX-STARTMENU%==off IF %X% GTR 89 IF %X% LSS 98 IF %Y% GTR 56 IF %Y% LSS 60 set M=0 &timeout /T 0 /NOBREAK > nul & goto :WBX-STARTMENU.EXE
IF %I%==m IF %M% EQU 1 IF %WBX-STARTMENU%==on IF %X% GTR 89 IF %X% LSS 98 IF %Y% GTR 56 IF %Y% LSS 60 set M=0 &timeout /T 0 /NOBREAK > nul &set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX.EXE



:: START MENU TASKS
:: Using X Y X Y TYPE GUI ARRAY.
::
IF %WBX-STARTMENU%==on (
	IF %I%==m IF %M% EQU 1 IF %X% GTR 135 IF %Y% GTR 13 IF %X% LSS 146 IF %Y% LSS 15 set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX-STARTMENU-ALLAPPS.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 74 IF %Y% GTR 16 IF %X% LSS 89 IF %Y% LSS 22 set WBX-STARTMENU=off &set WBX-START=inactive &goto :EDGE.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 91 IF %Y% GTR 16 IF %X% LSS 101 IF %Y% LSS 22 set WBX-STARTMENU=off &set WBX-START=inactive &goto :NOTEPAD.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 103 IF %Y% GTR 16 IF %X% LSS 117 IF %Y% LSS 22 set WBX-STARTMENU=off &set WBX-START=inactive &goto :EXPLORER.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 121 IF %Y% GTR 16 IF %X% LSS 131 IF %Y% LSS 22 set WBX-STARTMENU=off &set WBX-START=inactive &goto :SETTINGS.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 16 IF %X% LSS 149 IF %Y% LSS 22 set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 74 IF %Y% GTR 23 IF %X% LSS 89 IF %Y% LSS 27 set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 91 IF %Y% GTR 23 IF %X% LSS 101 IF %Y% LSS 27 set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 103 IF %Y% GTR 23 IF %X% LSS 117 IF %Y% LSS 27 set WBX-STARTMENU=off &set WBX-START=inactive &goto :PAINT.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 121 IF %Y% GTR 23 IF %X% LSS 131 IF %Y% LSS 27 set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 23 IF %X% LSS 149 IF %Y% LSS 27 set WBX-STARTMENU=off &set WBX-START=inactive &goto :CALENDAR.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 74 IF %Y% GTR 30 IF %X% LSS 89 IF %Y% LSS 35 set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX.EXE
    IF %I%==m IF %M% EQU 1 IF %X% GTR 90 IF %Y% GTR 29 IF %X% LSS 102 IF %Y% LSS 34 set WBX-STARTMENU=off &set WBX-START=inactive &goto :TASKMGR.EXE


    IF %I%==m IF %M% EQU 1 IF %X% GTR 139 IF %Y% GTR 14 IF %X% LSS 150 IF %Y% LSS 14 set WBX-STARTMENU=off &set WBX-START=inactive &goto :WBX.EXE
)

:: START MENU POWER TASKS
:: Using X Y X Y TYPE GUI ARRAY.

:: Sign Out
IF %WBX-STARTMENU%==on IF %WBX-STARTMENU-POWERMENU.EXE%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 45 IF %X% LSS 149 IF %Y% LSS 47 goto :WBX-USERLOGIN.EXE

:: Shut Down
IF %WBX-STARTMENU%==on IF %WBX-STARTMENU-POWERMENU.EXE%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 47 IF %X% LSS 149 IF %Y% LSS 49 exit

:: Restart
IF %WBX-STARTMENU%==on IF %WBX-STARTMENU-POWERMENU.EXE%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 49 IF %X% LSS 149 IF %Y% LSS 51 kernelreboot reboot

:: Open
IF %WBX-STARTMENU%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 140 IF %Y% GTR 51 IF %X% LSS 145 IF %Y% LSS 53 set WBX-STARTMENU-POWERMENU.EXE=on &goto :WBX-STARTMENU-POWERMENU.EXE

:: Close
IF %WBX-STARTMENU%==on IF %WBX-STARTMENU-POWERMENU.EXE%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 71 IF %Y% GTR 9 IF %X% LSS 152 IF %Y% LSS 54 set WBX-STARTMENU-POWERMENU.EXE=off &goto :WBX-STARTMENU.EXE


:: SEARCH CLICK BUTTON
:: USING X X Y Y TYPE GUI ARRAY.
IF %I%==m IF %M% EQU 1 IF %WBX-SEARCHBAR%==on IF %X% GTR 99 IF %X% LSS 104 IF %Y% GTR 56 IF %Y% LSS 59 set M=0 &timeout /T 0 /NOBREAK > nul &set WBX-SEARCHBAR=off &set WBX-SEARCH=inactive &goto :WBX.EXE
IF %I%==m IF %M% EQU 1 IF %WBX-SEARCHBAR%==off IF %X% GTR 99 IF %X% LSS 104 IF %Y% GTR 56 IF %Y% LSS 59 set M=0 &timeout /T 0 /NOBREAK > nul &set WBX-SEARCHBAR=on &set WBX-SEARCH=active &goto :WBX-SEARCH.EXE

:: SEARCH TASKS
:: USING X X Y Y TYPE GUI ARRAY.
IF %WBX-SEARCHBAR%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 70 IF %X% LSS 154 IF %Y% GTR 26 IF %Y% LSS 28 set M=0 &timeout /T 0 /NOBREAK > nul &goto :WBX-SEARCH.FIND



:: TASK VIEW BUTTON
:: X X Y Y GUI ARRAY
IF %I%==m IF %M% EQU 1 IF %_WBX-TASKVIEW%==off IF %X% GTR 105 IF %X% LSS 111 IF %Y% GTR 56 IF %Y% LSS 59 set M=0 &timeout /T 0 /NOBREAK > nul &goto :WBX-TASKVIEW.EXE
IF %I%==m IF %M% EQU 1 IF %_WBX-TASKVIEW%==on IF %X% GTR 105 IF %X% LSS 111 IF %Y% GTR 56 IF %Y% LSS 59 set M=0 &timeout /T 0 /NOBREAK > nul &set _WBX-TASKVIEW=off &set WBX-TASKVIEW=inactive &goto :WBX.EXE

:: App Button
:: X Y X Y GUI ARRAY
IF %I%==m IF %M% EQU 1 IF %X% GTR 112 IF %Y% GTR 56 IF %X% LSS 118 IF %Y% LSS 59 goto :WBX.EXE
IF %I%==m IF %M% EQU 2 IF %X% GTR 112 IF %Y% GTR 56 IF %X% LSS 118 IF %Y% LSS 59 goto :WBX-RIGHTCLICKAPP.EXE


:: ACTION CENTER BUTTON
:: X Y X Y GUI ARRAY
IF %_WBX-ACTIONCENTER%==on IF %M% EQU 1 IF %X% GTR 195 IF %Y% GTR 56 IF %X% LSS 199 IF %Y% LSS 59 set M=0 &set _WBX-ACTIONCENTER=off &timeout /T 0 /NOBREAK > nul &set WBX-ACTIONCENTER=inactive &goto WBX.EXE
IF %_WBX-ACTIONCENTER%==off IF %I%==m IF %M% EQU 1 IF %X% GTR 195 IF %Y% GTR 56 IF %X% LSS 199 IF %Y% LSS 59 set M=0 &timeout /T 0 /NOBREAK > nul &goto :WBX-ACTIONCENTER.EXE

:: NOTIFICATION CENTER BUTTON
:: X Y X Y GUI ARRAY
IF %_WBX-NOTIFICATIONCENTER%==on IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %Y% GTR 56 IF %X% LSS 212 IF %Y% LSS 58 set M=0 &timeout /T 0 /NOBREAK > nul &set _WBX-NOTIFICATIONCENTER=off  &set WBX-NOTIFICATIONCENTER=inactive &goto WBX.EXE
IF %_WBX-NOTIFICATIONCENTER%==off IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %Y% GTR 56 IF %X% LSS 212 IF %Y% LSS 58 set M=0 &timeout /T 0 /NOBREAK > nul &GOTO :WBX-NOTIFICATIONCENTER.EXE


:: RIGHTCLICKDESKTOP
IF %_LAST-ACTIVEAPP%==WBX.EXE IF %I%==m IF %M% EQU 2 IF %X% GTR 0 IF %X% LSS 200 IF %Y% GTR 0 IF %Y% LSS 55 goto :WBX-RIGHTCLICKDESKTOP.EXE


:: RIGHTCLICKTASKBAR
IF %I%==m IF %M% EQU 2 IF %X% GTR 0 IF %X% LSS 212 IF %Y% GTR 56 IF %Y% LSS 59 goto :WBX-RIGHTCLICKTASKBAR.EXE




:: Specific apps will be applied here for app stuff



IF %_LAST-ACTIVEAPP%==settings.exe (
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 12 IF %X% LSS 33 IF %Y% LSS 14 goto :SETTINGS.SYSTEM
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 15 IF %X% LSS 33 IF %Y% LSS 17 goto :SETTINGS.PERSONALIZATION
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 18 IF %X% LSS 33 IF %Y% LSS 20 goto :SETTINGS.APPS
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 21 IF %X% LSS 33 IF %Y% LSS 23 goto :SETTINGS.ACCOUNTS
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 24 IF %X% LSS 33 IF %Y% LSS 26 goto :SETTINGS.TIMELANGUAGE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 27 IF %X% LSS 33 IF %Y% LSS 29 goto :SETTINGS.ACCESSIBILITY
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 30 IF %X% LSS 33 IF %Y% LSS 32 goto :SETTINGS.PRIVACYSECURITY
	IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 33 IF %X% LSS 33 IF %Y% LSS 35 goto :SETTINGS.UPDATE
)

IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 52 IF %X% LSS 202 IF %Y% LSS 55 goto :SETTINGS.SYSTEM.ABOUT
IF %_SETTINGS.SECTION%==SYSTEM.ABOUT IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM

IF %_SETTINGS.SECTION%==ACCOUNTS IF %I%==m IF %M% EQU 1 IF %X% GTR 65 IF %Y% GTR 17 IF %X% LSS 193 IF %Y% LSS 19 goto :SETTINGS.ACCOUNTS.PROFILE
IF %_SETTINGS.SECTION%==ACCOUNTS IF %I%==m IF %M% EQU 1 IF %X% GTR 65 IF %Y% GTR 20 IF %X% LSS 193 IF %Y% LSS 23 goto :SETTINGS.ACCOUNTS.SIGNIN

IF %_SETTINGS.SECTION%==ACCOUNTS.PROFILE IF %I%==m IF %M% EQU 1 IF %X% GTR 55 IF %Y% GTR 4 IF %X% LSS 65 IF %Y% LSS 6 goto :SETTINGS.ACCOUNTS
IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 151 IF %Y% GTR 21 IF %X% LSS 157 IF %Y% LSS 24 goto :SETTINGS.ACCOUNTS


IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 92 IF %Y% GTR 31 IF %X% LSS 108 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD
IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 130 IF %Y% GTR 31 IF %X% LSS 146 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS


IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE IF %I%==m IF %M% EQU 1 IF %X% GTR 130 IF %Y% GTR 31 IF %X% LSS 146 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS

IF %_SETTINGS.SECTION%==UPDATE IF %I%==m IF %M% EQU 1 IF %X% GTR 180 IF %Y% GTR 8 IF %X% LSS 201 IF %Y% LSS 12 goto :SETTINGS.UPDATE.WGET


::PAINT
IF %_PAINT.EXE%==on (
	IF %I%==m IF %M% EQU 1 IF %X% GTR 0 IF %X% LSS 212 IF %Y% GTR 10 IF %Y% LSS 55 CALL ButtonHeight0 %X% %Y% %_PAINT.COLOR%0 " " X _Button_Boxes _Button_Hover &goto :WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 21 IF %X% LSS 25 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=0" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 25 IF %X% LSS 30 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=4" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 31 IF %X% LSS 35 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=c" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 36 IF %X% LSS 40 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=6" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 41 IF %X% LSS 45 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=e" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 46 IF %X% LSS 50 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=a" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 51 IF %X% LSS 55 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=2" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %X% LSS 60 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=b" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 61 IF %X% LSS 65 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=3" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 66 IF %X% LSS 70 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=9" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 71 IF %X% LSS 75 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=1" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 76 IF %X% LSS 80 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=5" &goto WBXCore.EXE
	IF %I%==m IF %M% EQU 1 IF %X% GTR 81 IF %X% LSS 85 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=d" &goto WBXCore.EXE
)






goto :WBXCore.EXE





























:WBX-STARTMENU.EXE
set WBX-STARTMENU=on
set WBX-START=active
call :WBX-ICONTASKBAR.EXE
:: The least to make are sharp corners rounded (3px):

call insertphoto 500 130 544 blank.bmp
call insertphoto 494 132 530 blank.bmp
call insertphoto 492 137 530 blank.bmp



call insertphoto 492 730 30 blank.bmp
call insertphoto 494 734 30 blank.bmp
call insertphoto 500 736 30 blank.bmp
call insertphoto 500 150 550 blank.bmp
call insertphoto 510 174 532 blank.bmp
call insertphoto 1038 735 30 blank.bmp


call insertphoto 1041 137 30 blank.bmp
call insertphoto 1039 132 30 blank.bmp

:: Start Outlined:
:: Rounded to support 3px corners (3px corners are a test)

:: Top
PIXELDRAW /dl /p 501 130 1060 130 /c 7
PIXELDRAW /dl /p 501 130 490 136 /c 7

:: Left Side
PIXELDRAW /dl /p 490 136 490 764 /c 7
PIXELDRAW /dl /p 490 764 501 770 /c 7

:: Right Side
PIXELDRAW /dl /p 1072 136 1072 764 /c 7
PIXELDRAW /dl /p 1060 770 1072 764 /c 7

:: Bottom
PIXELDRAW /dl /p 501 770 1060 770 /c 7
PIXELDRAW /dl /p 1060 130 1072 136 /c 7




:: Search Bar Outline Rounded:
:: Top
PIXELDRAW /dl /p 521 143 1049 143 /c 7
:: Left Side
PIXELDRAW /dl /p 519 145 519 175 /c 7
:: Right Side
PIXELDRAW /dl /p 1050 145 1050 175 /c 7
:: Bottom
PIXELDRAW /dl /p 521 177 1049 177 /c 9



:: All Apps Outline Rounded:
:: Top
PIXELDRAW /dl /p 950 196 955 196 /c c

:: PIXELDRAW /dl /p 800 205 800 235 /c 0

call insertphoto 535 150 120 searchbar-top.bmp

call insertphoto 550 250 15 MSEdge.bmp
call insertphoto 655 250 15 Notepad.bmp
call insertphoto 752 250 15 Explorer.bmp
call insertphoto 868 250 15 Settings.bmp
call insertphoto 985 250 15 WinDefender.bmp

call insertphoto 550 330 15 WinTerm.bmp
call insertphoto 655 330 15 MSPhotos.bmp
call insertphoto 752 330 15 MSPaint.bmp
call insertphoto 868 330 15 Calculator.bmp
call insertphoto 985 330 15 Calendar.bmp

call insertphoto 550 420 15 alarms-clock.bmp
call insertphoto 655 420 15 taskmgr.bmp

call insertphoto 510 700 20 profile-icon.bmp

call insertphoto 990 725 125 ui.power.bmp

CALL ButtonHeight0 80 10 f0 "Type here to search" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 75 13 f0 "Pinned" 133 13 f0 " All Apps > " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 80 51 f0 "WinBatchX %_version% %_build%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 77 20 f0 "Edge" 91 20 f0 "Notepad" 102 20 f0 "File Explorer" 121 20 f0 "Settings" 138 20 f0 "Security" 75 26 f0 "Terminal" 91 26 f0 "Photos" 106 26 f0 "Paint" 120 26 f0 "Calculator" 138 26 f0 "Calendar" 77 32 f0 "Clock" 88 32 f0 "Task Manager" 80 51 f0 "%_USERNAME-WINBATCHX%" X _Button_Boxes _Button_Hover
::CALL ButtonHeight0 75 35 f0 "Recommended" 75 38 f0 "Get Started" 75 39 f0 "Welcome to WinBatchX" 75 41 f0 "Coming soon." X _Button_Boxes _Button_Hover
goto :WBXCore.EXE




:WBX-STARTMENU-ALLAPPS.EXE
call insertphoto 500 130 544 blank.bmp
call insertphoto 494 132 530 blank.bmp
call insertphoto 492 137 530 blank.bmp
call insertphoto 492 730 30 blank.bmp
call insertphoto 494 734 30 blank.bmp
call insertphoto 500 736 30 blank.bmp
call insertphoto 500 150 550 blank.bmp
call insertphoto 510 174 532 blank.bmp
call insertphoto 1038 735 30 blank.bmp
call insertphoto 1041 137 30 blank.bmp
call insertphoto 1039 132 30 blank.bmp


:: Search Bar Outline Rounded:
:: Top
PIXELDRAW /dl /p 521 145 1049 145 /c 7
:: Left Side
PIXELDRAW /dl /p 519 147 519 173 /c 7
:: Right Side
PIXELDRAW /dl /p 1050 147 1050 173 /c 7
:: Bottom
PIXELDRAW /dl /p 521 175 1049 175 /c 9

CALL ButtonHeight0 75 10 f0 "Type here to search" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 74 13 f0 "All Apps" 137 13 f0 " < Go Back " X _Button_Boxes _Button_Hover

call insertphoto 540 250 12 alarms-clock.bmp
call insertphoto 540 290 12 Calculator.bmp
call insertphoto 540 330 12 Calendar.bmp
call insertphoto 540 370 12 MSEdge.bmp
call insertphoto 540 410 12 Explorer.bmp
call insertphoto 540 450 12 MSPaint.bmp
call insertphoto 540 490 12 MSPhotos.bmp
call insertphoto 540 530 12 Notepad.bmp
call insertphoto 540 570 12 Settings.bmp
call insertphoto 540 610 12 WinTerm.bmp
call insertphoto 540 650 12 WinDefender.bmp

Set _Result=0
GetInput /m 86 56 91 58 93 56 97 58 99 56 105 58 107 56 111 58 195 56 199 58 201 56 212 58 139 14 150 14

Set _Result=%Errorlevel%
IF %_Result%==1 goto :WBXCore.EXE
IF %_Result%==7 goto :WBX-STARTMENU.EXE
goto :WBX.EXE




:WBX-STARTMENU-POWERMENU.EXE
set WBX-STARTMENU-POWERMENU.EXE=on
call insertphoto 950 630 40 UI.buttonwhite.bmp
call insertphoto 949 631 41 UI.buttonwhite.bmp
call insertphoto 951 634 40 UI.buttonwhite.bmp

call insertphoto 950 640 40 UI.buttonwhite.bmp
call insertphoto 949 641 41 UI.buttonwhite.bmp
call insertphoto 951 644 40 UI.buttonwhite.bmp

call insertphoto 950 680 40 UI.buttonwhite.bmp
call insertphoto 949 681 41 UI.buttonwhite.bmp
call insertphoto 951 684 40 UI.buttonwhite.bmp

:: Top
PIXELDRAW /dl /p 951 630 1049 630 /c 0
:: Left Side
PIXELDRAW /dl /p 949 632 949 718 /c 0
:: Right Side
PIXELDRAW /dl /p 1051 632 1051 718 /c 0
:: Bottom
PIXELDRAW /dl /p 951 720 1049 720 /c 0


CALL ButtonHeight0 138 45 f0 "Sign Out" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 138 47 f0 "Shutdown" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 138 49 f0 "Restart" X _Button_Boxes _Button_Hover

goto :WBXCore.EXE


:WBX-STARTMENU-ACCOUNTMENU.EXE
goto :WBXCore.EXE













:WBX-SEARCH.EXE
set WBX-SEARCHBAR=on
set WBX-SEARCH=active
call :WBX-ICONTASKBAR.EXE
call insertphoto 470 355 313 blank.bmp
call insertphoto 468 356 313 blank.bmp
call insertphoto 776 356 313 blank.bmp

call insertphoto 775 355 313 blank.bmp

call insertphoto 470 420 313 blank.bmp
call insertphoto 468 420 313 blank.bmp
call insertphoto 776 420 313 blank.bmp

call insertphoto 469 421 313 blank.bmp
call insertphoto 775 421 313 blank.bmp
::PIXELDRAW /dr 470 355 /rd 631 415 /c 7


:: Search Bar Outline Rounded:
:: Top
PIXELDRAW /dl /p 491 370 1079 370 /c 7
:: Left Side
PIXELDRAW /dl /p 489 372 489 398 /c 7
:: Right Side
PIXELDRAW /dl /p 1080 372 1080 398 /c 7
:: Bottom
PIXELDRAW /dl /p 491 400 1079 400 /c 9

call insertphoto 500 374 120 searchbar-top.bmp

Call ButtonHeight0 74 26 f0 "Click here to search" X _Button_Boxes _Button_Hover







CALL ButtonHeight0 68 29 f0 "Recent" X _Button_Boxes _Button_Hover

call insertphoto 500 445 8 MSEdge.bmp
CALL ButtonHeight0 75 31 f0 "Edge" X _Button_Boxes _Button_Hover

call insertphoto 500 475 8 Explorer.bmp
CALL ButtonHeight0 75 33 f0 "File Explorer" X _Button_Boxes _Button_Hover

call insertphoto 500 500 8 Notepad.bmp
CALL ButtonHeight0 75 35 f0 "Notepad" X _Button_Boxes _Button_Hover

call insertphoto 500 530 8 MSPaint.bmp
CALL ButtonHeight0 75 37 f0 "Paint" X _Button_Boxes _Button_Hover

call insertphoto 500 560 8 Settings.bmp
CALL ButtonHeight0 75 39 f0 "Settings" X _Button_Boxes _Button_Hover

call insertphoto 500 585 8 Calendar.bmp
CALL ButtonHeight0 75 41 f0 "Calendar" X _Button_Boxes _Button_Hover







Call ButtonHeight0 100 29 f0 "Today - %DATE% " X _Button_Boxes _Button_Hover


goto :WBXCore.EXE


:WBX-SEARCH.FIND

BatBOX /g 76 27 /d ""
SET _SEARCHTERM=stop0x00
SET /p _SEARCHTERM=

IF %_SEARCHTERM%==stop0x00 GOTO :WBX-SEARCH.EXE

::IF %_SEARCHTERM%==Edge set "_SEARCH-ITEM=Microsoft Edge" &set "_SEARCH-ICON=MSEdge" &goto :WBX-SEARCHCOMPLETE.EXE
IF %_SEARCHTERM%==Paint set "_SEARCH-ITEM=Paint" &set "_SEARCH-ICON=MSPaint" &goto :WBX-SEARCHCOMPLETE.EXE
IF %_SEARCHTERM%==Calendar set "_SEARCH-ITEM=Calendar" &set "_SEARCH-ICON=calendar" &goto :WBX-SEARCHCOMPLETE.EXE
::IF %_SEARCHTERM%==Calculator set "_SEARCH-ITEM=Calculator" &set "_SEARCH-ICON=calculator" &goto :WBX-SEARCHCOMPLETE.EXE
::IF %_SEARCHTERM%==Security set "_SEARCH-ITEM=Security" &set "_SEARCH-ICON=WinDefender" &goto :WBX-SEARCHCOMPLETE.EXE
IF %_SEARCHTERM%==Settings set "_SEARCH-ITEM=Settings" &set "_SEARCH-ICON=Settings" &goto :WBX-SEARCHCOMPLETE.EXE
IF %_SEARCHTERM%==Notepad set "_SEARCH-ITEM=Notepad" &set "_SEARCH-ICON=Notepad" &goto :WBX-SEARCHCOMPLETE.EXE
::IF %_SEARCHTERM%==Explorer set "_SEARCH-ITEM=Explorer" &set "_SEARCH-ICON=Explorer" &goto :WBX-SEARCHCOMPLETE.EXE
::IF %_SEARCHTERM%==Terminal set "_SEARCH-ITEM=Terminal" &set "_SEARCH-ICON=WinTerm" &goto :WBX-SEARCHCOMPLETE.EXE
::IF %_SEARCHTERM%==Photos set "_SEARCH-ITEM=Photos" &set "_SEARCH-ICON=MSPhotos" &goto :WBX-SEARCHCOMPLETE.EXE

:: CMD will make a bug by stopping WBX without these 2 lines below on an empty/wrong search:
set _SEARCH-ITEM=Error
set _SEARCH-ICON=none

:WBX-SEARCHCOMPLETE.EXE

call insertphoto 470 355 313 blank.bmp
call insertphoto 775 355 313 blank.bmp
call insertphoto 470 420 313 blank.bmp
call insertphoto 775 420 313 blank.bmp
PIXELDRAW /dr 470 355 /rd 631 415 /c 7


:: Search Bar Outline Rounded:
:: Top
PIXELDRAW /dl /p 491 370 1079 370 /c 7
:: Left Side
PIXELDRAW /dl /p 489 372 489 398 /c 7
:: Right Side
PIXELDRAW /dl /p 1080 372 1080 398 /c 7
:: Bottom
PIXELDRAW /dl /p 491 400 1079 400 /c 9

call insertphoto 500 374 120 searchbar-top.bmp

Call ButtonHeight0 74 26 f0 "%_SEARCHTERM%" X _Button_Boxes _Button_Hover

call insertphoto 880 480 26 %_SEARCH-ICON%.bmp
Call ButtonHeight0 126 40 f0 "%_SEARCH-ITEM%" X _Button_Boxes _Button_Hover


goto :WBXCore.EXE










:WBX-TASKVIEW.EXE
	set _WBX-TASKVIEW=on
	set WBX-TASKVIEW%=active 
	call :WBX-DRAWTASKBAR.EXE
	call :WBX-ICONTASKBAR.EXE
:: We are using taskbar.bmp with blank.bmp for a rounded corner


	call insertphoto 19 606 42 blank.bmp
	call insertphoto 1437 606 42 blank.bmp
	call insertphoto 20 605 1000 taskbar.bmp

	call insertphoto 19 646 42 blank.bmp
	call insertphoto 1437 646 42 blank.bmp
	call insertphoto 20 645 1000 taskbar.bmp

	call insertphoto 19 669 42 blank.bmp
	call insertphoto 1437 669 42 blank.bmp
	call insertphoto 20 668 1000 taskbar.bmp

	call insertphoto 19 716 42 blank.bmp
	call insertphoto 1437 716 42 blank.bmp
	call insertphoto 20 715 1000 taskbar.bmp

	call BUTTONHEIGHT0 99 23 f0 "No apps open." X _Button_Boxes _Button_Hover
	call BUTTONHEIGHT0 100 43 f0 "Desktop 1" X _Button_Boxes _Button_Hover
	call BUTTONHEIGHT0 190 50 f0 "Task View Beta" X _Button_Boxes _Button_Hover
	PIXELDRAW /dr 650 630 /rd 210 120 /c 0
	:: call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp
	call :WBXCore.EXE
	goto :WBX-TASKVIEW.EXE 
























:WBX-WIDGETS.EXE
set WBX-WIDGETS=active
set _WBX-WIDGETS=on
call :WBX-ICONTASKBAR.EXE
call insertphoto 30 30 650 blank.bmp

:: Left Side of GUI
call insertphoto 29 31 50 blank.bmp
call insertphoto 29 33 646 blank.bmp


:: Right Side of GUI
call insertphoto 655 31 50 blank.bmp
call insertphoto 35 33 646 blank.bmp

::Top
PIXELDRAW /dl /p 31 30 703 30 /c 7
::Left
PIXELDRAW /dl /p 29 32 29 755 /c 7
::Right
PIXELDRAW /dl /p 705 32 705 755 /c 7
::Bottom
PIXELDRAW /dl /p 31 757 703 757 /c 7

call ButtonHeight0 45 2 f0 "%TIME-FIXED-TASKBAR% " X _Button_Boxes _Button_Hover


call ButtonHeight0 10 5 f0 "____________________________________________________________________" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 6 f0 "Latest WinBatchX Release:" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 7 f0 "%Newest-Version-Release%" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 9 f0 "%Newest-Version-Release-Link%" X _Button_Boxes _Button_Hover

call ButtonHeight0 10 12 f0 "____________________________________________________________________" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 13 f0 "Latest WinBatchX Beta Build Release:" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 15 f0 "%Newest-Build-Release%" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 17 f0 "%Newest-Build-Release-Link%" X _Button_Boxes _Button_Hover

call ButtonHeight0 10 21 f0 "____________________________________________________________________" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 23 f0 "Special News about WinBatchX:" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 25 f0 "%Special-News%" X _Button_Boxes _Button_Hover

call ButtonHeight0 10 34 f0 "____________________________________________________________________" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 35 f0 "Widgets is not able to take in news from Microsoft Bing, but ideas " X _Button_Boxes _Button_Hover
call ButtonHeight0 10 36 f0 "about widgets may appear on the next WinBatchX release." X _Button_Boxes _Button_Hover

goto :WBXCore.EXE









:WBX-ACTIONCENTER.EXE
set WBX-ACTIONCENTER=active
set _WBX-ACTIONCENTER=on
call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE

::draw backgrounds

call insertphoto 1165 430 302 blank.bmp
call insertphoto 1163 432 298 blank.bmp
call insertphoto 1170 432 298 blank.bmp
call insertphoto 1400 735 115 UI.pencil.bmp
call insertphoto 1450 735 115 UI.setting.bmp
:: Outline corners
::Top
PIXELDRAW /dl /p 1166 430 1478 430 /c 0
::Topleft
PIXELDRAW /dl /p 1166 430 1163 433 /c 0
::Left
PIXELDRAW /dl /p 1163 433 1163 762 /c 0
::Leftbottom
PIXELDRAW /dl /p 1163 762 1166 768 /c 0
::Bottom
PIXELDRAW /dl /p 1166 768 1476 768 /c 0
::Rightbottom
PIXELDRAW /dl /p 1476 768 1480 762 /c 0
::Right
PIXELDRAW /dl /p 1480 433 1480 762 /c 0
::Topright
PIXELDRAW /dl /p 1478 430 1480 433 /c 0

goto :WBXCore.EXE




:WBX-NOTIFICATIONCENTER.EXE
timeout /T 1 /NOBREAK > nul
set WBX-NOTIFICATIONCENTER=active
set _WBX-NOTIFICATIONCENTER=on
call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
::draw backgrounds

call insertphoto 1220 480 252 blank.bmp
call insertphoto 1218 481 252 blank.bmp
call insertphoto 1217 483 252 blank.bmp
:: Outline corners

::Top
PIXELDRAW /dl /p 1221 480 1480 480 /c 7
::Left
PIXELDRAW /dl /p 1219 482 1219 762 /c 7
::Right
PIXELDRAW /dl /p 1482 482 1482 762 /c 7
::Bottom
PIXELDRAW /dl /p 1221 764 1480 764 /c 7



Call Button 176 35 f0 "                              " X _Button_Boxes _Button_Hover
Call Button 176 38 f0 "                              " X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "                              " X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "                              " X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "                              " X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "                              " X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "                              " X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "                              " X _Button_Boxes _Button_Hover


:: Decided to let the system do the "math" on the spot
:: (Its not fast but it works)
set "NOTIF-DATE1=%DATE:~-10,2%"
IF %NOTIF-DATE1%==01 set "NOTIF-DATE2=JAN" &set "NOTIF-DATE3=January" &goto :WBX-NOTIFICATIONCENTER.JAN
IF %NOTIF-DATE1%==02 set "NOTIF-DATE2=FEB" &set "NOTIF-DATE3=Febuary" &goto :WBX-NOTIFICATIONCENTER.FEB
IF %NOTIF-DATE1%==03 set "NOTIF-DATE2=MAR" &set "NOTIF-DATE3=March" &goto :WBX-NOTIFICATIONCENTER.MAR
IF %NOTIF-DATE1%==04 set "NOTIF-DATE2=APR" &set "NOTIF-DATE3=April" &goto :WBX-NOTIFICATIONCENTER.APR
IF %NOTIF-DATE1%==05 set "NOTIF-DATE2=MAY" &set "NOTIF-DATE3=May" &goto :WBX-NOTIFICATIONCENTER.MAY
IF %NOTIF-DATE1%==06 set "NOTIF-DATE2=JUN" &set "NOTIF-DATE3=June" &goto :WBX-NOTIFICATIONCENTER.JUN
IF %NOTIF-DATE1%==07 set "NOTIF-DATE2=JUL" &set "NOTIF-DATE3=July" &goto :WBX-NOTIFICATIONCENTER.JUL
IF %NOTIF-DATE1%==08 set "NOTIF-DATE2=AUG" &set "NOTIF-DATE3=August" &goto :WBX-NOTIFICATIONCENTER.AUG
IF %NOTIF-DATE1%==09 set "NOTIF-DATE2=SEP" &set "NOTIF-DATE3=September" &goto :WBX-NOTIFICATIONCENTER.SEP
IF %NOTIF-DATE1%==10 set "NOTIF-DATE2=OCT" &set "NOTIF-DATE3=October" &goto :WBX-NOTIFICATIONCENTER.OCT
IF %NOTIF-DATE1%==11 set "NOTIF-DATE2=NOV" &set "NOTIF-DATE3=November" &goto :WBX-NOTIFICATIONCENTER.NOV
IF %NOTIF-DATE1%==12 set "NOTIF-DATE2=DEC" &set "NOTIF-DATE3=December" &goto :WBX-NOTIFICATIONCENTER.DEC

:WBX-NOTIFICATIONCENTER.JAN
Call Button 176 35 f0 " January %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%JAN:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%JAN:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%JAN:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%JAN:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%JAN:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%JAN:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.FEB
Call Button 176 35 f0 " Febuary %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%FEB:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%FEB:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%FEB:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%FEB:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%FEB:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%FEB:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.MAR
Call Button 176 35 f0 " March %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%MAR:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%MAR:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%MAR:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%MAR:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%MAR:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%MAR:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.APR
Call Button 176 35 f0 " April %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%APR:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%APR:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%APR:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%APR:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%APR:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%APR:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.MAY
Call Button 176 35 f0 " May %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%MAY:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%MAY:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%MAY:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%MAY:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%MAY:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%MAY:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.JUN
Call Button 176 35 f0 " June %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%JUN:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%JUN:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%JUN:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%JUN:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%JUN:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%JUN:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE


:WBX-NOTIFICATIONCENTER.JUL
Call Button 176 35 f0 " July %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%JUL:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%JUL:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%JUL:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%JUL:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%JUL:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%JUL:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.AUG
Call Button 176 35 f0 " August %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%AUG:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%AUG:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%AUG:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%AUG:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%AUG:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%AUG:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.SEP
Call Button 176 35 f0 " September %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%SEP:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%SEP:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%SEP:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%SEP:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%SEP:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%SEP:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.OCT
Call Button 176 35 f0 " October %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%OCT:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%OCT:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%OCT:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%OCT:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%OCT:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%OCT:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.NOV
Call Button 176 35 f0 " November %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%NOV:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%NOV:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%NOV:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%NOV:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%NOV:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%NOV:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:WBX-NOTIFICATIONCENTER.DEC
Call Button 176 35 f0 " December %DATE:~-7,2%, %DATE:~-4%" X _Button_Boxes _Button_Hover
Call Button 176 41 f0 "%DEC:~0,20%" X _Button_Boxes _Button_Hover
Call Button 176 43 f0 "%DEC:~21,20%" X _Button_Boxes _Button_Hover
Call Button 176 45 f0 "%DEC:~42,20%" X _Button_Boxes _Button_Hover
Call Button 176 47 f0 "%DEC:~63,20%" X _Button_Boxes _Button_Hover
Call Button 176 49 f0 "%DEC:~84,20%" X _Button_Boxes _Button_Hover
Call Button 176 51 f0 "%DEC:~105%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE











:WBX-RIGHTCLICKDESKTOP.EXE
set /A "Xright=%X%-1"
set /A "Yright1=%Y%+1"
set /A "Yright2=%Y%+3"
set /A "Yright3=%Y%+5"
Call Button %Xright% %Yright1% f0 "                  " X _Button_Boxes _Button_Hover
Call Button %Xright% %Yright2% f0 "     Loading      " X _Button_Boxes _Button_Hover
Call Button %Xright% %Yright3% f0 "                  " X _Button_Boxes _Button_Hover
timeout /T 0 /NOBREAK > nul
call list %X% %Y% f0 "View" "Sort by" "Refresh" "New" "Display Settings" "Personalize" "Shutdown"
IF %ERRORLEVEL%==0 goto :WBX.EXE
IF %ERRORLEVEL%==1 goto :WBX.EXE
IF %ERRORLEVEL%==2 goto :WBX.EXE
IF %ERRORLEVEL%==3 goto :WBX.EXE
IF %ERRORLEVEL%==4 goto :WBX.EXE
IF %ERRORLEVEL%==5 goto :WBX.EXE
IF %ERRORLEVEL%==6 goto :WBX.EXE
IF %ERRORLEVEL%==7 exit
goto :WBX-RIGHTCLICKDESKTOP.EXE













:: To be worked on when settings app is ready for this
:WBX-RIGHTCLICKTASKBAR.EXE
set Y-taskbar=53

:: Rightclicktaskbar can't be seen from past the desktop
IF %X% GTR 192 set X=192

call list %X% %Y-taskbar% f0 "Taskbar Settings"
IF %ERRORLEVEL%==0 goto :WBX.EXE
IF %ERRORLEVEL%==1 goto :WBX.EXE
goto :WBX-RIGHTCLICKTASKBAR.EXE













:WBX-RIGHTCLICKAPP.EXE
call insertphoto 715 680 50 UI.buttonmica.bmp
call insertphoto 715 710 50 UI.buttonmica.bmp
call insertphoto 715 730 50 UI.buttonmica.bmp
call insertphoto 714 681 51 UI.buttonmica.bmp
call insertphoto 714 728 51 UI.buttonmica.bmp
call insertphoto 815 680 50 UI.buttonmica.bmp
call insertphoto 815 710 50 UI.buttonmica.bmp
call insertphoto 815 730 50 UI.buttonmica.bmp
call insertphoto 814 681 51 UI.buttonmica.bmp
call insertphoto 814 728 51 UI.buttonmica.bmp

call insertphoto 728 690 8 %_LAST-ACTIVEAPP-BMP%.bmp
call insertphoto 728 755 110 UI.context.close.bmp

call ButtonHeight0 106 49 f3 "%_LAST-ACTIVEAPP-NAME%" 106 51 f7 "Pin to Start" 106 53 f3 "Close all windows" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE


:: older rightclickapp method
:: no rounding/function neither
set X-taskbar1=116
set Y-taskbar1=50
call list %X-taskbar1% %Y-taskbar1% f0 "%_LAST-ACTIVEAPP-NAME%" "Pin to Start" "Close"
IF %ERRORLEVEL%==0 goto :WBX.EXE
IF %ERRORLEVEL%==1 goto :WBX.EXE
IF %ERRORLEVEL%==2 goto :WBX.EXE
IF %ERRORLEVEL%==3 exit
goto :WBX-RIGHTCLICKAPP.EXE






:WBX-TASKBAR.EXE
	:WBX-DRAWTASKBAR.EXE
	call insertphoto 30 785 1000 taskbar.bmp
	call insertphoto 0 785 1000 taskbar.bmp
	PIXELDRAW /dr 0 0 /rd 1490 836 /c 0
	PIXELDRAW /dr 0 784 /rd 1490 52 /c 0
	exit /b 

	:WBX-ICONTASKBAR.EXE


	:: For 0 apps
	IF %WBX-START%==inactive call insertphoto 650 790 105 taskbar-start-off.bmp
	IF %WBX-SEARCH%==inactive call insertphoto 700 792 140 taskbar-search-off.bmp
	IF %WBX-TASKVIEW%==inactive call insertphoto 745 786 105 taskbar-taskview-off.bmp
	IF %WBX-WIDGETS%==inactive call insertphoto 15 790 105 taskbar-dashboard-off.bmp
	IF %WBX-APP%==inactive call insertphoto 800 795 12 %_LAST-ACTIVEAPP-BMP%.bmp
	IF %WBX-ACTIONCENTER%==inactive call insertphoto 1368 788 95 taskbaricons-off.bmp
	IF %WBX-NOTIFICATIONCENTER%==inactive call insertphoto 1405 791 95 timecenter-off.bmp

	IF %WBX-START%==active call insertphoto 650 786 105 taskbar-start-on.bmp
	IF %WBX-SEARCH%==active call insertphoto 697 789 95 taskbar-search-on.bmp
	IF %WBX-TASKVIEW%==active call insertphoto 740 790 95 taskbar-taskview-on.bmp
	IF %WBX-WIDGETS%==active call insertphoto 15 790 105 taskbar-dashboard-on.bmp
	IF %WBX-ACTIONCENTER%==active call insertphoto 1368 788 95 taskbaricons-on.bmp
	IF %WBX-NOTIFICATIONCENTER%==active call insertphoto 1405 791 95 timecenter-on.bmp


	:: As of the Windows 11 Insider Build 22000, the dashboard does not have a "on" button. It is an animation.
	:: IF %WBX-WIDGETS%==active call insertphoto %WBX-WIDGETS-X% 785 105 taskbar-dashboard-on.bmp

    ::Routinely making sure the time is accurate realtime
	CALL ButtonHeight0 201 56 f0 "%TIME-FIXED-TASKBAR%" 199 57 f0 "%DATE-FIXED-TASKBAR%" X _Button_Boxes _Button_Hover

	exit /b 















































:: Line 2160 = WBX-apps!

:: WinBatchX Applications 
:: These applications created are under the Unlicense license.


:: These are in order-- pulled from the 1700 canary builds.
:: 1. Notepad
:: 2. Paint
:: 3. Settings
:: 4. Edge
:: 5. File Explorer
:: 6. Security
:: 7. Calculator
:: 8. Calendar
:: 9. Clock
:: 10. Task Manager

:: Coming soon! Was still in development when these were revisied for release.
:: 11. Get help
:: 12. Store
:: 13. Snipping Tool
:: 14. Sticky Notes
:: 15. Photos (New)














:: Notepad App

:NOTEPAD.EXE


IF %_NOTEPAD.EXE%==on goto :NOTEPAD.LOOP
set _LAST-ACTIVEAPP=notepad.exe
set _LAST-ACTIVEAPP-BMP=notepad
SET _LAST-ACTIVEAPP-NAME=Notepad


set _NOTEPAD.EXE=on
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 notepad.bmp
 
call insertphoto 1410 9 100 NIbuttons.bmp

timeout /NOBREAK /T 2 > nul

:: call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


:NOTEPAD.LOOP

call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 25 12 8 Notepad.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

call insertphoto 1452 38 115 UI.setting.bmp


CALL ButtonHeight0 8 0 f0 "Notepad Beta" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 65 1490 65 /c 0


CALL ButtonHeight0 1 2 f0 "File    Edit    View" X _Button_Boxes _Button_Hover
:: For saving paint (later, in the works)-- test: nircmd savescreenshot "shot.png" 50 50 300 200

call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
:: PIXELDRAW /refresh 00

set _LAST-ACTIVEAPP=notepad.exe

call ButtonHeight0 20 20 f0 "%notepadkey1%" X _Button_Boxes _Button_Hover
call ButtonHeight0 20 21 f0 "%notepadkey2%" X _Button_Boxes _Button_Hover
call ButtonHeight0 20 22 f0 "%notepadkey3%" X _Button_Boxes _Button_Hover
call ButtonHeight0 20 23 f0 "%notepadkey4%" X _Button_Boxes _Button_Hover
call ButtonHeight0 20 24 f0 "%notepadkey5%" X _Button_Boxes _Button_Hover

goto :WBXCore.EXE


































:: Paint App

:PAINT.EXE


IF %_PAINT.EXE%==on goto :PAINT.LOOP
set _LAST-ACTIVEAPP=paint.exe
set _LAST-ACTIVEAPP-BMP=mspaint
SET _LAST-ACTIVEAPP-NAME=Paint


set _PAINT.EXE=on
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 mspaint.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

timeout /NOBREAK /T 2 > nul

:: call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


:: PIXELDRAW /refresh 00

:PAINT.LOOP
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 25 12 8 MSPaint.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

call insertphoto 145 38 115 ui.save.bmp

call insertphoto 205 38 115 ui.undo.bmp
call insertphoto 245 38 115 ui.redo.bmp

call insertphoto 1452 38 115 UI.setting.bmp


CALL ButtonHeight0 8 0 f0 "Paint - Untitled" 25 0 f7 "BETA" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 65 1490 65 /c 0


CALL ButtonHeight0 1 2 f0 "File" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 2 f0 "View" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 135 1490 135 /c 0


CALL ButtonHeight0 20 5 00 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 20 6 00 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 25 5 44 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 25 6 44 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 30 5 cc "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 30 6 cc "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 35 5 66 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 35 6 66 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 40 5 ee "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 40 6 ee "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 45 5 aa "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 45 6 aa "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 50 5 22 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 50 6 22 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 55 5 bb "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 55 6 bb "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 60 5 33 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 60 6 33 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 5 99 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 6 99 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 70 5 11 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 70 6 11 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 75 5 55 "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 75 6 55 "    " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 80 5 dd "    " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 80 6 dd "    " X _Button_Boxes _Button_Hover








CALL ButtonHeight0 50 7 f0 "Color" X _Button_Boxes _Button_Hover


call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
set _LAST-ACTIVEAPP=paint.exe

goto :WBXCore.EXE






















































:: Settings App

:SETTINGS.EXE
set _LAST-ACTIVEAPP=settings.exe
set _LAST-ACTIVEAPP-BMP=settings
SET "_LAST-ACTIVEAPP-NAME=Settings Beta"
IF %_SETTINGS.EXE%==on goto :SETTINGS.LOOP



set _SETTINGS.EXE=on
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 settings.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

timeout /NOBREAK /T 2 > nul

:: call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


:: PIXELDRAW /refresh 00

:SETTINGS.LOOP
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0
PIXELDRAW /dl /p 0 35 1490 35 /c 0

:: Theres no icon in the settings app
:: call insertphoto 25 12 8 settings.bmp
call insertphoto 25 12 110 ui.left.bmp
call insertphoto 1410 9 100 NIbuttons.bmp
CALL ButtonHeight0 8 0 f0 "Settings Beta" X _Button_Boxes _Button_Hover

:: Load left app stuff here
call insertphoto 20 60 30 profile-icon.bmp
CALL ButtonHeight0 15 4 f3 "%_USERNAME-WINBATCHX%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 15 6 f0 "Local Account" X _Button_Boxes _Button_Hover

::Load icons first!
call insertphoto 20 180 150 settings-system-icon.bmp
call insertphoto 20 220 150 settings-personalization-icon.bmp
call insertphoto 20 260 150 settings-apps-icon.bmp
call insertphoto 20 300 150 settings-account-icon.bmp
call insertphoto 20 340 150 settings-timelanguage-icon.bmp
call insertphoto 20 385 150 settings-accessibility-icon.bmp
call insertphoto 20 425 150 settings-security-icon.bmp
call insertphoto 20 470 150 settings-update-icon.bmp

::Then, load names
CALL ButtonHeight0 9 12 f3 "System" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 15 f3 "Personalization" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 18 f3 "Apps" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 21 f3 "Accounts" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 24 f3 "Time & Lauguage" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 27 f3 "Accessibility" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 30 f3 "Privacy & Security" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 33 f3 "WinBatchX Update" X _Button_Boxes _Button_Hover

call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
set _LAST-ACTIVEAPP=settings.exe

IF %_SETTINGS.SECTION%==SYSTEM goto :SETTINGS.SYSTEM
IF %_SETTINGS.SECTION%==SYSTEM.ABOUT goto :SETTINGS.SYSTEM.ABOUT

IF %_SETTINGS.SECTION%==PERSONALIZATION goto :SETTINGS.PERSONALIZATION

IF %_SETTINGS.SECTION%==APPS goto :SETTINGS.APPS

IF %_SETTINGS.SECTION%==ACCOUNTS goto :SETTINGS.ACCOUNTS

IF %_SETTINGS.SECTION%==TIMELANGUAGE goto :SETTINGS.TIMELANGUAGE

IF %_SETTINGS.SECTION%==ACCESSIBILITY goto :SETTINGS.ACCESSIBILITY

IF %_SETTINGS.SECTION%==PRIVACYSECURITY goto :SETTINGS.SYSTEM.PRIVACYSECURITY

IF %_SETTINGS.SECTION%==UPDATE goto :SETTINGS.UPDATE

goto :WBXCore.EXE





:SETTINGS.SYSTEM
set _SETTINGS.SECTION=SYSTEM

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp 

CALL ButtonHeight0 55 4 f0 "System" X _Button_Boxes _Button_Hover
PIXELDRAW /dr 399 99 /rd 196 104 /c 0
call insertphoto 400 100 10 "%BACKGROUND%.bmp"
CALL ButtonHeight0 85 6 f0 "%_HOSTNAME-winbatchx%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 85 8 f7 "Reset PC (Soon)" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 85 10 f7 "Rename" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 15 f7 "Display" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 16 f7 "Zoom Size, image display, system responsiveness " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 19 f7 "Sound" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 20 f7 "Volume, troubleshooting" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 22 f7 "Notifications" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 23 f7 "Alerts from your apps and pc" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 25 f7 "Focus Assist" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 26 f7 "Notifications, user rules" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 28 f7 "Power" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 29 f7 "Startup, shutdown, restart, sleep" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 31 f7 "Storage" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 32 f7 "Manage NIFS, clear space up" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 34 f7 "Nearby Sharing" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 35 f7 "File sharing" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 37 f7 "Multitasking" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 38 f7 "Desktops, Windowed Mode, Allow tilted windows (beta)" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 40 f7 "Activation" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 41 f7 "Does not exist on WBX" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 43 f7 "Troubleshoot" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 44 f7 "Fix problems" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 46 f7 "Recovery" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 47 f7 "Reset (soon)" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 49 f7 "Clipboard" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 50 f7 "Copy, Cut, Paste, Clear, History" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 52 f3 "About" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 53 f3 "Device infomation, windows version" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE














:SETTINGS.SYSTEM.ABOUT
set _SETTINGS.SECTION=SYSTEM.ABOUT

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   About" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 6 f0 "%_HOSTNAME-winbatchx%" 180 6 f3 "Rename PC" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 10 f3 "WinBatchX Infomation" 180 10 f7 "Copy" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 12 f0 "WinBatchX" 80 12 f7 "17.0 Beta" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 13 f0 "Build " 80 13 f7 "%_build%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 14 f0 "NI Release" 80 14 f7 "%_NI-KERNEL%" X _Button_Boxes _Button_Hover

goto :WBXCore.EXE















:SETTINGS.PERSONALIZATION
set _SETTINGS.SECTION=PERSONALIZATION

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp

CALL ButtonHeight0 55 4 f0 "Personalization" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 399 99 /rd 392 208 /c 0
call insertphoto 400 100 20 "%BACKGROUND%.bmp"
CALL ButtonHeight0 65 22 f0 "Select a theme to apply" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 24 f7 "Not set up." X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 27 f7 "Background" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 28 f7 "Default Image, Solid color" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 30 f7 "Color" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 31 f7 "Accent color, transparency effects, light/dark theme" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 33 f7 "Themes" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 34 f7 "Create, manage" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 36 f7 "Lock screen" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 37 f7 "Default image, app Notifications" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 39 f7 "Touch Keyboard" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 40 f7 "Themes, size, " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 42 f7 "Start" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 43 f7 "Pinned, Recomended, Folders" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 45 f7 "Taskbar" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 46 f7 "Taskbar alignment, hide/show taskbar" X _Button_Boxes _Button_Hover

goto :WBXCore.EXE








:SETTINGS.APPS
set _SETTINGS.SECTION=APPS

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp

CALL ButtonHeight0 55 4 f0 "Apps" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 6 f3 "Installed Apps" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 7 f3 "Manage apps on WinBatchX" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 9 f7 "Advanced App Settings" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 10 f7 "Choose where apps are coming fom, uninstall updates" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 12 f7 "Default apps" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 13 f7 "Default app opening for files" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 15 f7 "Startup" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 16 f7 "Apps auto-start when you start WinBatchX" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE











:SETTINGS.ACCOUNTS
set _SETTINGS.SECTION=ACCOUNTS

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp

CALL ButtonHeight0 55 4 f0 "Accounts" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 8 f0 "%_USERNAME-WINBATCHX%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 9 f0 "Local Account" X _Button_Boxes _Button_Hover


CALL ButtonHeight0 65 15 f0 "Account Settings" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 17 f3 "Your info" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 18 f3 "Change username, profile photo" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 20 f3 "Sign-in Options" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 21 f3 "Change password" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 23 f7 "Other users" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 24 f7 "Currently disabled" X _Button_Boxes _Button_Hover

goto :WBXCore.EXE


:SETTINGS.ACCOUNTS.PROFILE
set _SETTINGS.SECTION=ACCOUNTS.PROFILE

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp

CALL ButtonHeight0 55 4 f3 "Accounts" 63 4 f0 "   >   Profile photo" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 8 f0 "%_USERNAME-WINBATCHX%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 9 f0 "Local Account" X _Button_Boxes _Button_Hover


CALL ButtonHeight0 65 15 f0 "Edit your profile photo" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 17 f0 "Edit using paint" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 18 f7 "Use paint to edit your profile photo" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 20 f0 "Manually edit your photo" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 21 f0 "Use your favorite paint app and edit 'profile-icon.bmp' inside /NI/BMP/. " X _Button_Boxes _Button_Hover
goto :WBXCore.EXE

:SETTINGS.ACCOUNTS.SIGNIN
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN

:: THIS IS A POP-UP
:: Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 0
call insertphoto 580 305 240 blank.bmp
call insertphoto 581 306 240 blank.bmp
call insertphoto 579 309 240 blank.bmp
call insertphoto 650 305 240 blank.bmp
call insertphoto 651 306 240 blank.bmp
call insertphoto 649 309 240 blank.bmp
call insertphoto 750 305 240 blank.bmp
call insertphoto 751 306 240 blank.bmp
call insertphoto 749 309 240 blank.bmp
call insertphoto 850 305 240 blank.bmp
call insertphoto 851 306 240 blank.bmp
call insertphoto 849 309 240 blank.bmp
call insertphoto 1075 315 130 UI.context.close.bmp

CALL ButtonHeight0 83 22 f0 "Change password" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 83 25 f0 "Are you sure you want to change your password?" X _Button_Boxes _Button_Hover

call insertphoto 650 450 40 UI.buttonblue.bmp
call insertphoto 649 451 40 UI.buttonblue.bmp
call insertphoto 651 454 40 UI.buttonblue.bmp

call insertphoto 920 450 40 UI.buttongray.bmp
call insertphoto 919 451 40 UI.buttongray.bmp
call insertphoto 921 454 40 UI.buttongray.bmp
CALL ButtonHeight0 93 32 3f "Yes" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 133 32 f0 "No" X _Button_Boxes _Button_Hover

goto :WBXCore.EXE

:SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN.CHANGEPASSWORD
:: THIS IS A POP-UP
:: Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 0

::shouldnt be this long
call insertphoto 580 305 240 blank.bmp
call insertphoto 581 306 240 blank.bmp
call insertphoto 579 309 240 blank.bmp
call insertphoto 650 305 240 blank.bmp
call insertphoto 651 306 240 blank.bmp
call insertphoto 649 309 240 blank.bmp
call insertphoto 750 305 240 blank.bmp
call insertphoto 751 306 240 blank.bmp
call insertphoto 749 309 240 blank.bmp
call insertphoto 850 305 240 blank.bmp
call insertphoto 851 306 240 blank.bmp
call insertphoto 849 309 240 blank.bmp


CALL ButtonHeight0 83 22 f0 "Change password" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 90 25 f0 "Type your password here. Press ENTER to continue." X _Button_Boxes _Button_Hover


call insertphoto 650 400 45 UI.buttonbrightwhite.bmp
call insertphoto 649 401 45 UI.buttonbrightwhite.bmp
call insertphoto 651 404 45 UI.buttonbrightwhite.bmp

call insertphoto 690 400 45 UI.buttonbrightwhite.bmp
call insertphoto 689 401 45 UI.buttonbrightwhite.bmp
call insertphoto 691 404 45 UI.buttonbrightwhite.bmp

call insertphoto 730 400 45 UI.buttonbrightwhite.bmp
call insertphoto 729 401 45 UI.buttonbrightwhite.bmp
call insertphoto 731 404 45 UI.buttonbrightwhite.bmp

call insertphoto 870 400 45 UI.buttonbrightwhite.bmp
call insertphoto 869 401 45 UI.buttonbrightwhite.bmp
call insertphoto 871 404 45 UI.buttonbrightwhite.bmp

call insertphoto 810 400 45 UI.buttonbrightwhite.bmp
call insertphoto 809 401 45 UI.buttonbrightwhite.bmp
call insertphoto 811 404 45 UI.buttonbrightwhite.bmp

call insertphoto 850 400 45 UI.buttonbrightwhite.bmp
call insertphoto 849 401 45 UI.buttonbrightwhite.bmp
call insertphoto 851 404 45 UI.buttonbrightwhite.bmp

call insertphoto 890 400 45 UI.buttonbrightwhite.bmp
call insertphoto 889 401 45 UI.buttonbrightwhite.bmp
call insertphoto 891 404 45 UI.buttonbrightwhite.bmp

PIXELDRAW /dl /p 651 399 1007 399 /c 7

PIXELDRAW /dl /p 650 400 650 446 /c 7

PIXELDRAW /dl /p 1008 400 1008 446 /c 7

PIXELDRAW /dl /p 651 447 1007 447 /c 3

::Set cursor for typing
BatBOX /g 94 30 /d ""
set /p _WBX_PASSWORD=

call :USERDATA.SVC
:SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE
:: THIS IS A POP-UP
:: Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 0

::shouldnt be this long
call insertphoto 580 305 240 blank.bmp
call insertphoto 581 306 240 blank.bmp
call insertphoto 579 309 240 blank.bmp
call insertphoto 650 305 240 blank.bmp
call insertphoto 651 306 240 blank.bmp
call insertphoto 649 309 240 blank.bmp
call insertphoto 750 305 240 blank.bmp
call insertphoto 751 306 240 blank.bmp
call insertphoto 749 309 240 blank.bmp
call insertphoto 850 305 240 blank.bmp
call insertphoto 851 306 240 blank.bmp
call insertphoto 849 309 240 blank.bmp

CALL ButtonHeight0 90 25 f0 "Your password has been changed." X _Button_Boxes _Button_Hover
CALL ButtonHeight0 90 25 f0 "Please use your new password to login next time." X _Button_Boxes _Button_Hover


call insertphoto 920 450 40 UI.buttongray.bmp
call insertphoto 919 451 40 UI.buttongray.bmp
call insertphoto 921 454 40 UI.buttongray.bmp
CALL ButtonHeight0 133 32 f0 "Okay" X _Button_Boxes _Button_Hover


goto :WBXCore.EXE


:SETTINGS.TIMELANGUAGE
set _SETTINGS.SECTION=TIMELANGUAGE

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp
CALL ButtonHeight0 55 4 f0 "Time & Language" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE


:SETTINGS.ACCESSIBILITY
set _SETTINGS.SECTION=ACCESSIBILITY

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp
CALL ButtonHeight0 55 4 f0 "Accessibility" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE


:SETTINGS.PRIVACYSECURITY
set _SETTINGS.SECTION=PRIVACYSECURITY

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp
CALL ButtonHeight0 55 4 f0 "Privacy & Security" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE



:SETTINGS.UPDATE
set _SETTINGS.SECTION=UPDATE

:: Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.bmp 
call insertphoto 380 210 110 blankloadapp.bmp

call insertphoto 400 100 110 UI.settingsapp.update.bmp

CALL ButtonHeight0 55 4 f0 "WinBatchX Update" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 70 8 f0 "%_WBXCore-updatemessage%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 70 9 f0 "Release: %_version%" X _Button_Boxes _Button_Hover
call insertphoto 1270 125 40 UI.buttonblue.bmp
call insertphoto 1269 126 41 UI.buttonblue.bmp
call insertphoto 1271 129 40 UI.buttonblue.bmp
call insertphoto 1300 125 40 UI.buttonblue.bmp
call insertphoto 1299 126 41 UI.buttonblue.bmp
call insertphoto 1301 129 40 UI.buttonblue.bmp
CALL ButtonHeight0 180 9 3f "Check for updates" X _Button_Boxes _Button_Hover

:: note stuff
call insertphoto 380 300 100 UI.buttonwhite.bmp
call insertphoto 379 301 100 UI.buttonwhite.bmp
call insertphoto 381 304 100 UI.buttonwhite.bmp

call insertphoto 580 300 100 UI.buttonwhite.bmp
call insertphoto 579 301 100 UI.buttonwhite.bmp
call insertphoto 581 304 100 UI.buttonwhite.bmp

call insertphoto 780 300 100 UI.buttonwhite.bmp
call insertphoto 779 301 100 UI.buttonwhite.bmp
call insertphoto 781 304 100 UI.buttonwhite.bmp

call insertphoto 980 300 100 UI.buttonwhite.bmp
call insertphoto 979 301 100 UI.buttonwhite.bmp
call insertphoto 981 304 100 UI.buttonwhite.bmp

CALL ButtonHeight0 60 21 f0 "Notice:" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 25 f0 "%_WBXCore-updatealert%" X _Button_Boxes _Button_Hover
goto :WBXCore.EXE













:SETTINGS.UPDATE.WGET
:: Update Manager - wget

:: Set Variable for _link= (Universal)
SET "_Link=https://github.com/bes-ptah/WinBatchX/archive/refs/heads/main.zip"

:: download it quietly using -q. It won't spam the command line.
wget -q "%_Link%" > nul

:: Unpack it (This is why Windows 1809 and higher is recommended, or use tar yourself)
tar -xf main.zip

:: Enter the directory (always this name)
cd winbatchx-main

:: Enter the update directory
cd update

:: CALL the program
call update.bat

:: Then remove the old files.
del update.bat

cd ..

:: delete it without a request from user. (or we screw the display screen up)
rmdir update > nul

del LICENSE
del README.md
del _config.yml

:: go back into the system directory.
cd ..

:: remove the folder itself.
rmdir winbatchx-main > nul

:: delete the zip file downloaded so the next download update wont crash the cmd line.
del main.zip

goto :SETTINGS.UPDATE














:SETTINGS.REWRITECONFIG

ECHO SET lock-screen=%lock-screen%> data-settings.bat
ECHO SET lock-wallpapersize=%lock-wallpapersize%>> data-settings.bat

ECHO SET BACKGROUND=%background%>> data-settings.bat
ECHO SET BACKGROUND-SIZE=%background-size%>> data-settings.bat
ECHO SET DO-NOT-DISTURB=%DO-NOT-DISTURB%>> data-settings.bat

exit /b






















:: WinBatchX Edge - There is no official license yet. 
:: Respectivly is 'outbranched' from Microsoft Edge.
:EDGE.EXE

goto :WBX.EXE





































:: Explorer App
:: Based on Windows Insider Build 22621 (at this time)
:: This app was also imported from an later build (1666) that isn't released yet.
:: This app does not work or function until the soon-intergrated NIFS filesystem works.
:EXPLORER.EXE

:: If you want to replicate the actual app of explorer (Win32)

IF %_EXPLORER.EXE%==on goto :EXPLORER.LOOP
set _LAST-ACTIVEAPP=explorer.exe
set _LAST-ACTIVEAPP-BMP=explorer
SET "_LAST-ACTIVEAPP-NAME=File Explorer"

set _EXPLORER.EXE=on
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 explorer.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

timeout /NOBREAK /T 2 > nul
:EXPLORER.LOOP
call insertphoto 0 35 147 blankloadapp.white.bmp &call insertphoto 0 35 147 blankloadapp.white.bmp &call insertphoto 7 35 147 blankloadapp.white.bmp &call insertphoto 7 35 147 blankloadapp.white.bmp



call insertphoto 20 15 41 UI.buttonbrightwhite.bmp
call insertphoto 40 15 41 UI.buttonbrightwhite.bmp
call insertphoto 60 15 41 UI.buttonbrightwhite.bmp
call insertphoto 80 15 41 UI.buttonbrightwhite.bmp
call insertphoto 100 15 41 UI.buttonbrightwhite.bmp

call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
set _LAST-ACTIVEAPP=explorer.exe

call insertphoto 1410 9 100 NIbuttons.bmp

Call insertphoto 35 20 80 explorer.home.bmp
Call insertphoto 180 26 120 UI.context.close.explorer.bmp
CALL ButtonHeight0 8 1 f0 "Home" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 100 1490 100 /c 0

:: Command Bar
Call insertphoto 20 67 120 explorer.top.new.bmp
CALL ButtonHeight0 5 4 f0 "New" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 90 60 90 90 /c 7
Call insertphoto 120 67 120 explorer.top.cut.bmp
Call insertphoto 180 67 120 explorer.top.copy.bmp
Call insertphoto 240 67 120 explorer.top.paste.bmp
Call insertphoto 300 67 120 explorer.top.rename.bmp
Call insertphoto 360 67 120 explorer.top.share.bmp
Call insertphoto 420 67 120 explorer.top.trash.bmp

PIXELDRAW /dl /p 0 100 1490 100 /c 7

:: Navigation Pane
PIXELDRAW /dl /p 300 100 300 783 /c 7

Call insertphoto 35 145 80 explorer.home.bmp
CALL ButtonHeight0 9 10 f0 "Home" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 20 180 280 180 /c 7

Call insertphoto 35 190 100 explorer.desktop.nav.bmp
CALL ButtonHeight0 9 13 f0 "Desktop" X _Button_Boxes _Button_Hover

Call insertphoto 35 233 100 explorer.documents.nav.bmp
CALL ButtonHeight0 9 16 f0 "Documents" X _Button_Boxes _Button_Hover

Call insertphoto 35 275 100 explorer.downloads.nav.bmp
CALL ButtonHeight0 9 19 f0 "Downloads" X _Button_Boxes _Button_Hover

Call insertphoto 35 317 100 explorer.music.nav.bmp
CALL ButtonHeight0 9 22 f0 "Music" X _Button_Boxes _Button_Hover

Call insertphoto 35 358 100 explorer.pictures.nav.bmp
CALL ButtonHeight0 9 25 f0 "Pictures" X _Button_Boxes _Button_Hover

Call insertphoto 35 400 100 explorer.videos.nav.bmp
CALL ButtonHeight0 9 28 f0 "Videos" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 20 432 280 432 /c 7

:: Displayed Part

CALL ButtonHeight0 44 10 f0 "Quick Access" X _Button_Boxes _Button_Hover

Call insertphoto 320 180 100 explorer.desktop.folder.bmp
CALL ButtonHeight0 54 13 f0 "Desktop" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 54 14 f7 "Locally Stored" X _Button_Boxes _Button_Hover

Call insertphoto 520 180 100 explorer.documents.folder.bmp
CALL ButtonHeight0 84 13 f0 "Documents" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 84 14 f7 "Locally Stored" X _Button_Boxes _Button_Hover

Call insertphoto 720 180 100 explorer.downloads.folder.bmp
CALL ButtonHeight0 111 13 f0 "Downloads" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 111 14 f7 "Locally Stored" X _Button_Boxes _Button_Hover

Call insertphoto 920 180 100 explorer.music.folder.bmp
CALL ButtonHeight0 140 13 f0 "Music" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 140 14 f7 "Locally Stored" X _Button_Boxes _Button_Hover

Call insertphoto 1120 180 100 explorer.pictures.folder.bmp
CALL ButtonHeight0 168 13 f0 "Pictures" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 168 14 f7 "Locally Stored" X _Button_Boxes _Button_Hover

Call insertphoto 320 280 100 explorer.videos.folder.bmp
CALL ButtonHeight0 54 20 f0 "Videos" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 54 21 f7 "Locally Stored" X _Button_Boxes _Button_Hover

call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE

goto :WBXCore.EXE
goto :EXPLORER.EXE




























:SECURITY.EXE
goto :WBX.EXE
















:: Calendar App
:: (The calculating day thing is imported from 16.0)


:CALENDAR.EXE

IF %_CALENDAR.EXE%==on goto :CALENDAR.LOOP
set _LAST-ACTIVEAPP=calendar.exe
set _LAST-ACTIVEAPP-BMP=calendar
SET _LAST-ACTIVEAPP-NAME=Calendar

set _CALENDAR.EXE=on
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 calendar.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

timeout /NOBREAK /T 2 > nul
:CALENDAR.LOOP
call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
set _LAST-ACTIVEAPP=calendar.exe
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

:: call insertphoto 1452 38 115 UI.setting.bmp

Call insertphoto 20 10 8 calendar.bmp
CALL ButtonHeight0 6 0 f0 "Calendar - %year%" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c 0

call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE

:: This is the orginial CALENDAR.EXE, in a graphical interface.
:: With premission of the open-source license, we are allowed to use other pieces of code.
:: This stil works in Windows 10/11!
:: Most Author's comments are untouched.
:: ========================================================================================


:: Xp batch for generating calendars
:: Chances look good for win 2000 and above(untested)
:: By Judago, August 2009



:: The current codepage is stored in variable %CodePage%,
:: then changed to 850 to facilitate box drawing characters.....

SETLOCAL ENABLEDELAYEDEXPANSION

:: The results are displayed below using substrings of each month's 
:: variable.


:: Edited portion of calendar




Call Button 12 10 f0 "January" X _Button_Boxes _Button_Hover
Call Button 8 12 f0 "%JAN:~0,20%" X _Button_Boxes _Button_Hover
Call Button 8 14 f0 "%JAN:~21,20%" X _Button_Boxes _Button_Hover
Call Button 8 16 f0 "%JAN:~42,20%" X _Button_Boxes _Button_Hover
Call Button 8 18 f0 "%JAN:~63,20%" X _Button_Boxes _Button_Hover
Call Button 8 20 f0 "%JAN:~84,20%" X _Button_Boxes _Button_Hover
Call Button 8 22 f0 "%JAN:~105%" X _Button_Boxes _Button_Hover

Call Button 42 10 f0 "February" X _Button_Boxes _Button_Hover
Call Button 38 12 f0 "%FEB:~0,20%" X _Button_Boxes _Button_Hover
Call Button 38 14 f0 "%FEB:~21,20%" X _Button_Boxes _Button_Hover
Call Button 38 16 f0 "%FEB:~42,20%" X _Button_Boxes _Button_Hover
Call Button 38 18 f0 "%FEB:~63,20%" X _Button_Boxes _Button_Hover
Call Button 38 20 f0 "%FEB:~84,20%" X _Button_Boxes _Button_Hover
Call Button 38 22 f0 "%FEB:~105%" X _Button_Boxes _Button_Hover

Call Button 72 10 f0 "March" X _Button_Boxes _Button_Hover
Call Button 68 12 f0 "%MAR:~0,20%" X _Button_Boxes _Button_Hover
Call Button 68 14 f0 "%MAR:~21,20%" X _Button_Boxes _Button_Hover
Call Button 68 16 f0 "%MAR:~42,20%" X _Button_Boxes _Button_Hover
Call Button 68 18 f0 "%MAR:~63,20%" X _Button_Boxes _Button_Hover
Call Button 68 20 f0 "%MAR:~84,20%" X _Button_Boxes _Button_Hover
Call Button 68 22 f0 "%MAR:~105%" X _Button_Boxes _Button_Hover

Call Button 102 10 f0 "April" X _Button_Boxes _Button_Hover
Call Button 98 12 f0 "%APR:~0,20%" X _Button_Boxes _Button_Hover
Call Button 98 14 f0 "%APR:~21,20%" X _Button_Boxes _Button_Hover
Call Button 98 16 f0 "%APR:~42,20%" X _Button_Boxes _Button_Hover
Call Button 98 18 f0 "%APR:~63,20%" X _Button_Boxes _Button_Hover
Call Button 98 20 f0 "%APR:~84,20%" X _Button_Boxes _Button_Hover
Call Button 98 22 f0 "%APR:~105%" X _Button_Boxes _Button_Hover

Call Button 132 10 f0 "May" X _Button_Boxes _Button_Hover
Call Button 128 12 f0 "%MAY:~0,20%" X _Button_Boxes _Button_Hover
Call Button 128 14 f0 "%MAY:~21,20%" X _Button_Boxes _Button_Hover
Call Button 128 16 f0 "%MAY:~42,20%" X _Button_Boxes _Button_Hover
Call Button 128 18 f0 "%MAY:~63,20%" X _Button_Boxes _Button_Hover
Call Button 128 20 f0 "%MAY:~84,20%" X _Button_Boxes _Button_Hover
Call Button 128 22 f0 "%MAY:~105%" X _Button_Boxes _Button_Hover

Call Button 162 10 f0 "June" X _Button_Boxes _Button_Hover
Call Button 158 12 f0 "%JUN:~0,20%" X _Button_Boxes _Button_Hover
Call Button 158 14 f0 "%JUN:~21,20%" X _Button_Boxes _Button_Hover
Call Button 158 16 f0 "%JUN:~42,20%" X _Button_Boxes _Button_Hover
Call Button 158 18 f0 "%JUN:~63,20%" X _Button_Boxes _Button_Hover
Call Button 158 20 f0 "%JUN:~84,20%" X _Button_Boxes _Button_Hover
Call Button 158 22 f0 "%JUN:~105%" X _Button_Boxes _Button_Hover

Call Button 12 30 f0 "July" X _Button_Boxes _Button_Hover
Call Button 8 32 f0 "%JUL:~0,20%" X _Button_Boxes _Button_Hover
Call Button 8 34 f0 "%JUL:~21,20%" X _Button_Boxes _Button_Hover
Call Button 8 36 f0 "%JUL:~42,20%" X _Button_Boxes _Button_Hover
Call Button 8 38 f0 "%JUL:~63,20%" X _Button_Boxes _Button_Hover
Call Button 8 40 f0 "%JUL:~84,20%" X _Button_Boxes _Button_Hover
Call Button 8 42 f0 "%JUL:~105%" X _Button_Boxes _Button_Hover

Call Button 42 30 f0 "August" X _Button_Boxes _Button_Hover
Call Button 38 32 f0 "%AUG:~0,20%" X _Button_Boxes _Button_Hover
Call Button 38 34 f0 "%AUG:~21,20%" X _Button_Boxes _Button_Hover
Call Button 38 36 f0 "%AUG:~42,20%" X _Button_Boxes _Button_Hover
Call Button 38 38 f0 "%AUG:~63,20%" X _Button_Boxes _Button_Hover
Call Button 38 40 f0 "%AUG:~84,20%" X _Button_Boxes _Button_Hover
Call Button 38 42 f0 "%AUG:~105%" X _Button_Boxes _Button_Hover

Call Button 72 30 f0 "September" X _Button_Boxes _Button_Hover
Call Button 68 32 f0 "%SEP:~0,20%" X _Button_Boxes _Button_Hover
Call Button 68 34 f0 "%SEP:~21,20%" X _Button_Boxes _Button_Hover
Call Button 68 36 f0 "%SEP:~42,20%" X _Button_Boxes _Button_Hover
Call Button 68 38 f0 "%SEP:~63,20%" X _Button_Boxes _Button_Hover
Call Button 68 40 f0 "%SEP:~84,20%" X _Button_Boxes _Button_Hover
Call Button 68 42 f0 "%SEP:~105%" X _Button_Boxes _Button_Hover

Call Button 102 30 f0 "October" X _Button_Boxes _Button_Hover
Call Button 98 32 f0 "%OCT:~0,20%" X _Button_Boxes _Button_Hover
Call Button 98 34 f0 "%OCT:~21,20%" X _Button_Boxes _Button_Hover
Call Button 98 36 f0 "%OCT:~42,20%" X _Button_Boxes _Button_Hover
Call Button 98 38 f0 "%OCT:~63,20%" X _Button_Boxes _Button_Hover
Call Button 98 40 f0 "%OCT:~84,20%" X _Button_Boxes _Button_Hover
Call Button 98 42 f0 "%OCT:~105%" X _Button_Boxes _Button_Hover

Call Button 132 30 f0 "November" X _Button_Boxes _Button_Hover
Call Button 128 32 f0 "%NOV:~0,20%" X _Button_Boxes _Button_Hover
Call Button 128 34 f0 "%NOV:~21,20%" X _Button_Boxes _Button_Hover
Call Button 128 36 f0 "%NOV:~42,20%" X _Button_Boxes _Button_Hover
Call Button 128 38 f0 "%NOV:~63,20%" X _Button_Boxes _Button_Hover
Call Button 128 40 f0 "%NOV:~84,20%" X _Button_Boxes _Button_Hover
Call Button 128 42 f0 "%NOV:~105%" X _Button_Boxes _Button_Hover

Call Button 162 30 f0 "December" X _Button_Boxes _Button_Hover
Call Button 158 32 f0 "%DEC:~0,20%" X _Button_Boxes _Button_Hover
Call Button 158 34 f0 "%DEC:~21,20%" X _Button_Boxes _Button_Hover
Call Button 158 36 f0 "%DEC:~42,20%" X _Button_Boxes _Button_Hover
Call Button 158 38 f0 "%DEC:~63,20%" X _Button_Boxes _Button_Hover
Call Button 158 40 f0 "%DEC:~84,20%" X _Button_Boxes _Button_Hover
Call Button 158 42 f0 "%DEC:~105%" X _Button_Boxes _Button_Hover


goto :WBXCore.EXE
goto :CALENDAR.LOOP


:: Task Manager App
:TASKMGR.EXE
IF %_TASKMGR.EXE%==on goto :TASKMGR.LOOP
set _LAST-ACTIVEAPP=taskmgr.exe
set _LAST-ACTIVEAPP-BMP=taskmgr
SET _LAST-ACTIVEAPP-NAME=Task Manager

set _TASKMGR.EXE=on
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 taskmgr.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

timeout /NOBREAK /T 2 > nul
:TASKMGR.LOOP
call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE
set _LAST-ACTIVEAPP=taskmgr.exe
call insertphoto 0 0 147 blankloadapp.bmp &call insertphoto 0 35 147 blankloadapp.bmp &call insertphoto 7 0 147 blankloadapp.bmp &call insertphoto 7 35 147 blankloadapp.bmp

call insertphoto 1410 9 100 NIbuttons.bmp

:: call insertphoto 1452 38 115 UI.setting.bmp

Call insertphoto 20 15 100 UI.lines.bmp
Call insertphoto 60 10 8 taskmgr.bmp
CALL ButtonHeight0 12 0 f0 "Task Manager" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c 0


:: Navigation Pane
PIXELDRAW /dl /p 55 35 55 783 /c 0
Call insertphoto 20 45 100 ui.appbox.bmp

:: Main Window
CALL ButtonHeight0 10 3 f0 "Processes (7)" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 193 3 f0 "+ Start New Task" X _Button_Boxes _Button_Hover
PIXELDRAW /dl /p 55 85 1491 85 /c 0

CALL ButtonHeight0 10 6 f0 "Apps (1)" X _Button_Boxes _Button_Hover
CALL insertphoto 70 123 8 %_LAST-ACTIVEAPP-BMP%.bmp
CALL ButtonHeight0 12 8 f0 "%_LAST-ACTIVEAPP-NAME%" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 10 10 f0 "Services (3)" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 12 12 f0 "WinBatchX Update Service" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 12 13 f0 "WinBatchX Security Service" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 12 14 f0 "UserProfiles Service" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 10 16 f0 "WinBatchX Processes (3)" X _Button_Boxes _Button_Hover
CALL insertphoto 70 262 8 app-installer.bmp
CALL ButtonHeight0 12 18 f0 "NI AppLauncher" X _Button_Boxes _Button_Hover
CALL insertphoto 70 276 8 explorer.bmp
CALL ButtonHeight0 12 19 f0 "NI Desktop" X _Button_Boxes _Button_Hover
CALL insertphoto 70 290 8 Settings-light.bmp
CALL ButtonHeight0 12 20 f0 "NI Kernel" X _Button_Boxes _Button_Hover

call :WBX-DRAWTASKBAR.EXE
call :WBX-ICONTASKBAR.EXE

goto :WBXCore.EXE





:: END OF WINBATCHX CODE
:: WinBatchX.

rem  WinBatchX 19.0 Beta 10 - Version 2305
rem  Build 1900.251
rem  Quantum Kernel 1.0rc1

rem  The unlicense below is used for this "batch" software. Also in LICENSE.txt.

rem  Unlicense License
rem  - 
rem  This is free and unencumbered software released into the public domain.
rem 
rem  Anyone is free to copy, modify, publish, use, compile, sell, or
rem  distribute this software, either in source code form or as a compiled
rem  binary, for any purpose, commercial or non-commercial, and by any
rem  means.
rem 
rem  In jurisdictions that recognize copyright laws, the author or authors
rem  of this software dedicate any and all copyright interest in the
rem  software to the public domain. We make this dedication for the benefit
rem  of the public at large and to the detriment of our heirs and
rem  successors. We intend this dedication to be an overt act of
rem  relinquishment in perpetuity of all present and future rights to this
rem  software under copyright law.
rem 
rem  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
rem  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
rem  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
rem  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
rem  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
rem  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
rem  OTHER DEALINGS IN THE SOFTWARE.
rem  
rem  For more information, please refer to <https://unlicense.org>




@Echo off
timeout /T 0 /NOBREAK > nul
If /i "%~1" == "" (goto :bootWBX.exe)
If /i "%~1" == "start" (goto :WBX-STARTUP.EXE)

:bootWBX.exe
start WinBatchX start
echo You can find WinBatchX in a window named 'WinBatchX'.
endlocal
exit /b

:WBX-STARTUP.EXE
rem  Use windows commands to adjust for WinBatchX
setlocal
mode 213,60
chcp 437 > nul
rem  Enter the System Directory
cd System
rem Unzip the BMP folder
tar -xf BMP.zip
rem  clear up the cmd line
cls
rem cmdwiz showcursor 0
call insertphoto 0 0 85 bootimage.bmp
rem  1. General Variables
rem  2. Record Boot Time
rem  3. Date Variables
rem  4. Time Variables
rem  5. data-system.bat
rem  6. data-settings.bat
rem  7. data-user.bat
rem  8. Quantum Kernel Variables:
rem   8.1: Kernel Variables
rem   8.2: Windowed Mode Variables
rem   8.3: Start WBXFS 
rem        (beta virtual filesystem from NIFS!)
rem   8.4: App Variables
rem  9. Fetch Updates
rem  9.1: Security check
rem  10. ASCII Load



rem  1.
SET "_WBX-OS=WinBatchX"
SET "_quantum-ver=1.0rc1"
SET "_version=19 Beta 2"
SET "_build=1900.251"



rem  2.
SET _DATESTART=%DATE%
SET _TIMESTART=%TIME%
SET "_BOOTTIME=%_DATESTART% at %_TIMESTART%"



rem  3.
rem set variables

SET _WBX-TIMETEMP1=0
SET _WBX-TIMETEMP2=0
SET _WBX-TIMETEMP3=0

SET _WBX-DATETEMP1=%DATE:~-10,2%
SET _WBX-DATETEMP2=%DATE:~7,-5%
SET _WBX-DATETEMP3=%DATE:~-4%



rem This is here for the GUI on calendar and notification center
rem Most author's comments are untouched.

rem  Xp batch for generating calendars
rem  Chances look good for win 2000 and above(untested)
rem  By Judago, August 2009



rem  The current codepage is stored in variable %CodePage%,
rem  then changed to 850 to facilitate box drawing characters.....

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











rem  4.
rem set variables
SET _WBX-TIMETEMP1=0
SET _WBX-TIMETEMP2=0
SET _WBX-TIMETEMP3=0

rem do calculations
set _WBX-TIMETEMP1=%Time:~0,-9%
set _WBX-TIMETEMP2=%Time:~3,-6%

rem find the time, am or pm, via the _WBX-TIMETEMP1 (hours)
IF %_WBX-TIMETEMP1%==12 set _WBX-TIMETEMP1= 1&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==13 set _WBX-TIMETEMP1= 1&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==14 set _WBX-TIMETEMP1= 2&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==15 set _WBX-TIMETEMP1= 3&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==16 set _WBX-TIMETEMP1= 4&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==17 set _WBX-TIMETEMP1= 5&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==18 set _WBX-TIMETEMP1= 6&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==19 set _WBX-TIMETEMP1= 7&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==20 set _WBX-TIMETEMP1= 8&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==21 set _WBX-TIMETEMP1= 9&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==22 set _WBX-TIMETEMP1=10&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==23 set _WBX-TIMETEMP1=11&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==24 set _WBX-TIMETEMP1=12&set _WBX-TIMETEMP3=AM &GOTO :CONTINUEBOOT
set _WBX-TIMETEMP3=AM

:CONTINUEBOOT
rem set the variables
set "_WBX-TASKBAR-TIME=%_WBX-TIMETEMP1%:%_WBX-TIMETEMP2% %_WBX-TIMETEMP3%"
set "_WBX-TASKBAR-DATE=%_WBX-DATETEMP1%-%_WBX-DATETEMP2%-%DATE:~-7,2%"

rem reset temporary variables
SET _WBX-DATETEMP1=0
SET _WBX-DATETEMP2=0
SET _WBX-TIMETEMP1=0
SET _WBX-TIMETEMP2=0
SET _WBX-TIMETEMP3=0












rem  5.
rem reset variables
set START-STATUS=0
set FLAG-RECOVERYRESTART=0
set HIBERNATE-STATUS=0
set RESTART-STATUS=0

rem call data-system.bat
call data-system.bat
rem  new flags, maybe?
IF %START-STATUS%==1 Call ButtonHeight0 72 42 0f "Make sure you shut down your computer correctly. You did not shut down properly last time." X _Button_Boxes _Button_Hover
set START-STATUS=1
set RESTART-STATUS=0

rem write a new data-system.bat file
(
  echo SET START-STATUS=%START-STATUS%
  echo SET FLAG-RECOVERYRESTART=%FLAG-RECOVERYRESTART%
  echo SET HIBERNATE-STATUS=%HIBERNATE-STATUS%
  echo SET RESTART-STATUS=%RESTART-STATUS%
) > data-system.bat











rem  6.

rem make sure default settings are set here
SET THEME=light
SET COLORMODE=0
SET ACCENT.COLOR=3
SET HIGHLIGHT.WINDOW.BORDERS=b
SET VOLUME=100
SET NOTIFICATIONS=0
SET DO-NOT-DISTURB=0


SET BACKGROUND.LOCKSCREEN.IMAGE=background-lock
SET BACKGROUND.LOCKSCREEN.SIZE=77
SET _TASKBAR.ALIGNMENT=0

SET BACKGROUND.DESKTOP.IMAGE=background
SET BACKGROUND.DESKTOP.SIZE=100
SET _HOSTNAME-winbatchx=COMPUTER-0



rem call data-settings.bat
call data-settings.bat
IF %THEME%==light set THEMEcolor=f0
IF %THEME%==dark set THEMEcolor=0f

rem  7. 
rem call data-user.bat
call data-user.bat



rem  8.
rem Quantum Kernel Variables

rem default variables!:
set _START.EXE=0
set _START-POWERMENU.EXE=0
set _SEARCH.EXE=0
set _TASKVIEW.EXE=0
set _WIDGETS.EXE=0
set _APP.EXE=0
set _TASKBAROVERFLOW.EXE=0
set _ACTION.EXE=0
set _NOTIFICATION.EXE=0


rem  8.1

rem LOCKSCREEN.EXE variables:
rem 0 = off
rem 1 = on
rem 2 = loginloop
SET _LOCKSCREEN.EXE=0


rem  8.2
SET _ACTIVEAPPLABEL=explorer.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=WinBatchX

SET _ACTIVEAPPDRAG=
SET _ACTIVEAPP.X=
SET _ACTIVEAPP.Y=


rem  8.3

rem CALL NIFS.BAT



rem  8.4

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

set _PHOTOS.EXE=0

SET _SETTINGS.EXE=0
SET _SETTINGS.SECTION=SYSTEM

SET _SECURITY.EXE=0

SET _TERMINAL.EXE=0

SET _SNIPTOOL.EXE=0

SET _TASKMGR.EXE=0

SET _TIPS.EXE=0


rem  9.
rem  WBX UpdateCheck - wget 2.0
rem  Retrieves data for WinBatchX Update.
rem We don't use %_LINK% anymore as it can be easily changed.
rem  download it quietly using -q. It won't spam the command line.
wget -q "https://github.com/bes-ptah/WinBatchX/archive/refs/heads/main.zip" > nul
rem  Unpack it (This is why Windows 1809 and higher is recommended, or use tar yourself)
tar -xf main.zip
rem  Enter the directory (always this name)
cd winbatchx-main
rem  Enter the update directory
cd update
rem  CALL the program
rem  (!) the variables are new for 17.0
call update.bat
rem  Then remove the old files.
del update.bat
cd ..
rem  delete it without a request from user.
rmdir update > nul
del LICENSE
del README.md
del _config.yml
rem  go back into the system directory.
cd ..
rem  remove the folder itself.
rmdir winbatchx-main > nul
rem  delete the zip file downloaded so the next download update wont crash the cmd line.
del main.zip
IF %_WBXCore-update%==1 set "UPDATE-USERFIND=System is up to date."
IF %_WBXCore-update%==2 set "UPDATE-USERFIND=There is a new update."
IF %_WBXCore-update%==3 set "UPDATE-USERFIND=System Update Failed."


rem  9.1.
set "CD_winbatchx=%CD%"
cd C:\Program Files\Windows Defender
MpCmdRun -Scan -ScanType 3 -File %CD_winbatchx% > nul
rem  The 3rd flag tells it as a custom scan.
rem  Change directory back to WBX-17.
cd "%CD_winbatchx%"


rem  10.
rem load the ascii letters from pixcel.fo!
rem not available on this build.


cls
PIXELDRAW /refresh 00
GOTO :WBX-LOGIN.EXE






:WBX-LOGIN.EXE

:LOCKSCREEN.EXE
set _LOCKSCREEN.EXE=1

rem clear the screen
cls
PIXELDRAW /refresh 00
call ButtonHeight0 100 25 0f "Please Wait" X _Button_Boxes _Button_Hover

rem clear the screen
cls
PIXELDRAW /refresh 00
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp
call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp

rem make it look like the windows 11 lock screen! (kind-of, the command line does not support fonts)
Call Typo - 95 3 ff %_WBX-TASKBAR-TIME%
Call ButtonHeight0 102 12 %THEMEcolor% %_WBX-TASKBAR-DATE% X _Button_Boxes _Button_Hover

rem GUI for power!
call insertphoto 1380 770 40 UI.buttonmica.bmp
call insertphoto 1379 771 41 UI.buttonmica.bmp
call insertphoto 1381 774 40 UI.buttonmica.bmp
call insertphoto 1420 780 125 ui.power.bmp

:WBX-LOCKSCREEN.INPUT
set I=m
set M=0
set X=0
set Y=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('Batbox.exe /m') Do (
	Set I=m
	Set M=%%C
	Set X=%%A
	Set Y=%%B
	title WinBatchX [%%A] [%%B] [%%C] [%%D]
	)
IF %I%==k goto :WBX-LOCKSCREEN.INPUT
IF %I%==m IF %M%==1 IF %_LOCKSCREEN.EXE%==1 IF %X% GTR 197 IF %Y% GTR 54 IF %X% LSS 211 IF %Y% LSS 57 goto :WBX-LOGIN.POWER
IF %I%==m IF %M%==1 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 211 IF %Y% LSS 58 goto :WBX-LOGIN.LOOP

rem IF %I%==k IF %_LOCKSCREEN.EXE%==0
goto :WBX-LOCKSCREEN.INPUT





:WBX-LOGIN.POWER
set _LOCKSCREEN.EXE=0
call insertphoto 1380 680 40 UI.buttonmica.bmp
call insertphoto 1379 681 41 UI.buttonmica.bmp
call insertphoto 1381 684 40 UI.buttonmica.bmp
call insertphoto 1380 720 40 UI.buttonmica.bmp
call insertphoto 1379 721 41 UI.buttonmica.bmp
call insertphoto 1381 724 40 UI.buttonmica.bmp

call insertphoto 1385 690 95 ui.restart.bmp
call insertphoto 1385 725 100 ui.power.bmp

Call ButtonHeight0 200 49 %THEMEcolor% "Restart" X _Button_Boxes _Button_Hover
Call ButtonHeight0 200 51 %THEMEcolor% "Shut Down" X _Button_Boxes _Button_Hover

:WBX-LOGIN.POWER.LOOP
set I=m
set M=0
set X=0
set Y=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('Batbox.exe /m') Do (
	Set I=m
	Set M=%%C
	Set X=%%A
	Set Y=%%B
	title WinBatchX [%%A] [%%B] [%%C] [%%D]
	)

IF %I%==m IF %M%==1 IF %X% GTR 197 IF %Y% GTR 48 IF %X% LSS 211 IF %Y% LSS 51 goto :RESTART.EXE
IF %I%==m IF %M%==1 IF %X% GTR 197 IF %Y% GTR 51 IF %X% LSS 211 IF %Y% LSS 53 goto :SHUTDOWN.EXE

IF %I%==m IF %M%==1 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 211 IF %Y% LSS 60 goto :WBX-LOGIN.EXE
goto :WBX-LOGIN.POWER.LOOP



:WBX-LOGIN.LOOP
set _LOCKSCREEN.EXE=0

call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp


rem gui rounding for profile
call insertphoto 739 259 125 blank.%THEME%.bmp
call insertphoto 740 258 135 blank.%THEME%.bmp
call insertphoto 765 258 125 blank.%THEME%.bmp
call insertphoto 766 259 125 blank.%THEME%.bmp

call insertphoto 739 275 125 blank.%THEME%.bmp
call insertphoto 766 275 125 blank.%THEME%.bmp

call insertphoto 740 276 125 blank.%THEME%.bmp
call insertphoto 765 276 125 blank.%THEME%.bmp


rem profile photo
call insertphoto 740 260 60 profile-icon.bmp


rem password GUI
call insertphoto 700 450 40 blank.dark.bmp
call insertphoto 730 449 40 blank.dark.bmp
call insertphoto 760 449 40 blank.dark.bmp
call insertphoto 790 449 40 blank.dark.bmp
call insertphoto 820 449 40 blank.dark.bmp
call insertphoto 850 449 40 blank.dark.bmp
call insertphoto 887 449 40 blank.dark.bmp

rem  Round the Main Pasword GUI
call insertphoto 701 449 40 blank.dark.bmp
call insertphoto 701 451 40 blank.dark.bmp
call insertphoto 730 451 40 blank.dark.bmp
call insertphoto 760 451 40 blank.dark.bmp
call insertphoto 790 451 40 blank.dark.bmp
call insertphoto 820 451 40 blank.dark.bmp
call insertphoto 850 451 40 blank.dark.bmp
call insertphoto 887 451 40 blank.dark.bmp
call insertphoto 889 450 39 blank.dark.bmp
call insertphoto 889 451 39 blank.dark.bmp

rem BORDER the Main Passowrd GUI
rem  Top
PIXELDRAW /dl /p 702 449 930 449 /c 8
rem  Left Side
PIXELDRAW /dl /p 700 449 700 493 /c 8
rem  Right Side
PIXELDRAW /dl /p 932 449 932 493 /c 8
rem  Bottom
PIXELDRAW /dl /p 702 493 930 493 /c b



call ButtonHeight0 112 29 0f "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover
call ButtonHeight0 100 32 0f "                " X _Button_Boxes _Button_Hover
BatBOX /g 102 33 /d ""

:WBX-LOGIN.INPUT

SET _PASS=0
SET /p _PASS=
IF %_WBX_PASSWORD%==%_PASS% GOTO :WBX-LOGINLOAD.EXE

rem  (!) Soon it will be possible to click and type at the same time on WinBatchX, like on login. I have not added the shutdown or restart buttons.






:WBX-USERLOGIN.ERROR
call ButtonHeight0 105 36 0f "The password is incorrect. Try again." X _Button_Boxes _Button_Hover
timeout /T 1 /NOBREAK > NUL
goto :WBX-LOGIN.INPUT






:WBX-LOGINLOAD.EXE
rem clear the screen
cls
PIXELDRAW /refresh 00


call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp

rem call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp

rem gui rounding for profile
call insertphoto 739 259 125 blank.%THEME%.bmp
call insertphoto 740 258 135 blank.%THEME%.bmp
call insertphoto 765 258 125 blank.%THEME%.bmp
call insertphoto 766 259 125 blank.%THEME%.bmp

call insertphoto 739 275 125 blank.%THEME%.bmp
call insertphoto 766 275 125 blank.%THEME%.bmp

call insertphoto 740 276 125 blank.%THEME%.bmp
call insertphoto 765 276 125 blank.%THEME%.bmp


rem profile photo
call insertphoto 740 260 60 profile-icon.bmp

rem preparing message
call insertphoto 740 260 60 profile-icon.bmp
call ButtonHeight0 112 29 %THEMEcolor% "%_WBX_USERNAME% " X _Button_Boxes _Button_Hover
call ButtonHeight0 106 32 %THEMEcolor% "Preparing WinBatchX" X _Button_Boxes _Button_Hover



call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp



:SYSTEM.EXE
call :DESKTOP.EXE
goto :SYSTEM.EXE


rem compose desktop:
	:COMPOSE.EXE
	call insertphoto 0 0 77 background1.%THEME%.bmp
	call insertphoto 740 0 77 background2.%THEME%.bmp
	call insertphoto 0 462 77 background3.%THEME%.bmp
	call insertphoto 740 462 77 background4.%THEME%.bmp
	exit /b 

	:GUICOMPOSE.EXE
	IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 105 IF %Y% LSS 32 call insertphoto 0 0 77 background1.%THEME%.bmp
	IF %X% GTR 106 IF %Y% GTR 0 IF %X% LSS 210 IF %Y% LSS 32 call insertphoto 740 0 77 background2.%THEME%.bmp
	IF %X% GTR 0 IF %Y% GTR 33 IF %X% LSS 106 IF %Y% LSS 55 call insertphoto 0 462 77 background3.%THEME%.bmp
	IF %X% GTR 106 IF %Y% GTR 33 IF %X% LSS 210 IF %Y% LSS 55 call insertphoto 740 462 77 background4.%THEME%.bmp
	exit /b



rem CLEAR-CACHE:

	:CLEARCACHE.EXE
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
	set _PHOTOS.EXE=0
	SET _SETTINGS.EXE=0
	SET _SETTINGS.SECTION=SYSTEM
	SET _SECURITY.EXE=0
	SET _TERMINAL.EXE=0
	SET _SNIPTOOL.EXE=0
	SET _TASKMGR.EXE=0
	SET _TIPS.EXE=0
	exit /b


rem TASKBAR:



rem CLEAR TASKBAR:
	:TASKBARCLEAR.EXE
	set _START.EXE=0
	set _SEARCH.EXE=0
	set _TASKVIEW.EXE=0
	set _WIDGETS.EXE=0
	set _TASKBAROVERFLOW.EXE=0
	set _ACTION.EXE=0
	set _NOTIFICATION.EXE=0
	exit /b


rem DRAW TASKBAR:
	:TASKBARDRAW.EXE 
	call insertphoto 30 785 1000 taskbar.%THEME%.bmp
	call insertphoto 0 785 1000 taskbar.%THEME%.bmp
	PIXELDRAW /dr 0 0 /rd 1490 836 /c 0
	PIXELDRAW /dr 0 784 /rd 1490 52 /c 0
	exit /b


rem ICON TASKBAR:
	:TASKBARICON.EXE

	rem _TASKBAR.ALIGNMENT:
	rem 0=center
	rem 1=left




	IF %_TASKBAR.ALIGNMENT%==0 (
		IF %_START.EXE%==0 call insertphoto 635 790 105 taskbar-start-off-%THEME%.bmp
		IF %_SEARCH.EXE%==0 call insertphoto 690 792 140 taskbar-search-off-%THEME%.bmp
		IF %_TASKVIEW.EXE%==0 call insertphoto 740 786 105 taskbar-taskview-off-%THEME%.bmp
		IF %_WIDGETS.EXE%==0 call insertphoto 15 790 105 taskbar-dashboard-off-%THEME%.bmp
		IF %_APP.EXE%==0 call insertphoto 800 795 12 %_ACTIVEAPPIMAGE%.%THEME%.bmp
		IF %_APP.EXE%==1 call insertphoto 800 795 12 %_ACTIVEAPPIMAGE%.%THEME%.bmp
		rem IF %_TASKBAROVERFLOW.EXE%==0 call insertphoto 850 790 105 taskbar-overflow-off-%THEME%.bmp
		IF %_ACTION.EXE%==0 call insertphoto 1368 788 95 taskbaricons-off-%THEME%.bmp
		IF %_NOTIFICATION.EXE%==0 call insertphoto 1405 791 95 timecenter-off-%THEME%.bmp
		rem =======
		IF %_START.EXE%==1 call insertphoto 635 786 105 taskbar-start-on-%THEME%.bmp
		IF %_SEARCH.EXE%==1 call insertphoto 687 789 95 taskbar-search-on-%THEME%.bmp
		IF %_TASKVIEW.EXE%==1 call insertphoto 740 790 95 taskbar-taskview-on-%THEME%.bmp
		IF %_WIDGETS.EXE%==1 call insertphoto 15 790 105 taskbar-dashboard-on-%THEME%.bmp
		IF %_APP.EXE%==1 call insertphoto 804 825 120 taskbar-using-%THEME%.bmp
		rem IF %_TASKBAROVERFLOW.EXE%==1 call insertphoto 850 790 105 taskbar-overflow-on-%THEME%.bmp
		IF %_ACTION.EXE%==1 call insertphoto 1368 788 95 taskbaricons-on-%THEME%.bmp
		IF %_NOTIFICATION.EXE%==1 call insertphoto 1405 791 95 timecenter-on-%THEME%.bmp
	)


	IF %_TASKBAR.ALIGNMENT%==1 (
		IF %_START.EXE%==0 call insertphoto 15 790 105 taskbar-start-off-%THEME%.bmp
		IF %_SEARCH.EXE%==0 call insertphoto 65 792 140 taskbar-search-off-%THEME%.bmp
		IF %_TASKVIEW.EXE%==0 call insertphoto 110 786 105 taskbar-taskview-off-%THEME%.bmp
		IF %_WIDGETS.EXE%==0 call insertphoto 165 790 105 taskbar-dashboard-off-%THEME%.bmp
		IF %_APP.EXE%==1 call insertphoto 230 795 12 %_ACTIVEAPPIMAGE%.%THEME%.bmp
		rem IF %_TASKBAROVERFLOW.EXE%==0 call insertphoto 280 790 105 taskbar-overflow-off-%THEME%.bmp
		IF %_ACTION.EXE%==0 call insertphoto 1368 788 95 taskbaricons-off-%THEME%.bmp
		IF %_NOTIFICATION.EXE%==0 call insertphoto 1405 791 95 timecenter-off-%THEME%.bmp
		rem =======
		IF %_START.EXE%==1 call insertphoto 15 786 105 taskbar-start-on-%THEME%.bmp
		IF %_SEARCH.EXE%==1 call insertphoto 62 789 95 taskbar-search-on-%THEME%.bmp
		IF %_TASKVIEW.EXE%==1 call insertphoto  790 95 taskbar-taskview-on-%THEME%.bmp
		IF %_WIDGETS.EXE%==1 call insertphoto 790 105 taskbar-dashboard-on-%THEME%.bmp
		rem IF %_TASKBAROVERFLOW.EXE%==1 call insertphoto 840 790 105 taskbar-overflow-on-%THEME%.bmp
		IF %_ACTION.EXE%==1 call insertphoto 1368 788 95 taskbaricons-on-%THEME%.bmp
		IF %_NOTIFICATION.EXE%==1 call insertphoto 1405 791 95 timecenter-on-%THEME%.bmp
	)


	rem ======
	rem draw time
	CALL ButtonHeight0 201 56 %THEMEcolor% "%_WBX-TASKBAR-TIME%" 199 57 %THEMEcolor% "%_WBX-TASKBAR-DATE%" X _Button_Boxes _Button_Hover

	exit /b



::Some UI testing on the desktop for b1634

::call insertphoto 100 100 40 UI.buttonblue.bmp
::call insertphoto 99 101 41 UI.buttonblue.bmp
::call insertphoto 101 104 40 UI.buttonblue.bmp



::call insertphoto 100 100 40 UI.buttonwhite.bmp
::call insertphoto 99 101 41 UI.buttonwhite.bmp
::call insertphoto 101 104 40 UI.buttonwhite.bmp




:DESKTOP.EXE
cls
set _APP.EXE=0
rem its better if you dont customize your background with the developer builds right now.
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp


IF %_BATCHINSTALLER.EXE%==1 goto :BATCHINSTALLER.EXE
IF %_CALCULATOR.EXE%==1 goto :CALCULATOR.EXE
IF %_CALENDAR.EXE%==1 goto :CALENDAR.EXE
IF %_CLOCK.EXE%==1 goto :CLOCK.EXE
IF %_EDGE.EXE%==1 goto :EDGE.EXE
IF %_EXPLORER.EXE%==1 goto :EXPLORER.EXE
IF %_FEEDBACKHUB.EXE%==1 goto :FEEDBACKHUB.EXE
IF %_NOTEPAD.EXE%==1 goto :NOTEPAD.EXE
IF %_PAINT.EXE%==1 goto :PAINT.EXE
IF %_PHOTOS.EXE%==1 goto :PHOTOS.EXE
IF %_SETTINGS.EXE%==1 goto :SETTINGS.EXE
IF %_SECURITY.EXE%==1 goto :SECURITY.EXE
IF %_TERMINAL.EXE%==1 goto :TERMINAL.EXE
IF %_SNIPTOOL.EXE%==1 goto :SNIPTOOL.EXE
IF %_TASKMGR.EXE%==1 goto :TASKMGR.EXE
IF %_TIPS.EXE%==1 goto :TIPS.EXE



rem alter this for desktop to clear other app icons
SET _ACTIVEAPPLABEL=explorer.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=WinBatchX

call :COMPOSE.EXE

	call insertphoto 50 15 25 explorer.recyclebin.%THEME%.bmp
	CALL ButtonHeight0 4 5 %THEMEcolor% "Recycle Bin" X _Button_Boxes _Button_Hover
	PIXELDRAW /dr 49 14 /rd 67 67 /c 7
	PIXELDRAW /dr 50 15 /rd 65 65 /c 7


rem Build Previews
rem CALL ButtonHeight0 190 53 %THEMEcolor% "WinBatchX %_version%" X _Button_Boxes _Button_Hover
rem CALL ButtonHeight0 189 54 %THEMEcolor% "Build %_build% Q0.85" X _Button_Boxes _Button_Hover


call :TASKBARDRAW.EXE
call :TASKBARICON.EXE


rem  moved the draw time back to kernel! find it in kernel.exe

goto :KERNEL.EXE



:KERNEL.EXE
set I=m
set M=0
set X=0
set Y=0


For /f "Tokens=1,2,3,4* delims=:" %%A in ('Batbox.exe /m') Do (
	
	rem for fallback purposes:
	Set I=m
	Set X=%%A
	Set Y=%%B
	SET M=%%C

	title WinBatchX 19 [%%A] [%%B] [%%C] [%%D]
	rem [%%A] [%%B] [%%C] [%%D]


	rem reset temporary variables

	REM BUG FIX- theres no need to to so! ..??
	rem SET _WBX-TIMETEMP1=0
	rem SET _WBX-TIMETEMP2=0
	rem SET _WBX-TIMETEMP3=0

	rem do calculations
	set "_WBX-TIMETEMP1=%Time:~0,-9%"
	set "_WBX-TIMETEMP2=%Time:~3,-6%"

	rem find the time, am or pm, via the _WBX-TIMETEMP1 (hours)
	IF %_WBX-TIMETEMP1%==12 set "_WBX-TIMETEMP1=12"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==13 set "_WBX-TIMETEMP1= 1"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==14 set "_WBX-TIMETEMP1= 2"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==15 set "_WBX-TIMETEMP1= 3"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==16 set "_WBX-TIMETEMP1= 4"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==17 set "_WBX-TIMETEMP1= 5"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==18 set "_WBX-TIMETEMP1= 6"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==19 set "_WBX-TIMETEMP1= 7"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==20 set "_WBX-TIMETEMP1= 8"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==21 set "_WBX-TIMETEMP1= 9"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==22 set "_WBX-TIMETEMP1=10"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==23 set "_WBX-TIMETEMP1=11"&set "_WBX-TIMETEMP3=PM" &GOTO :CONTINUEKERNEL
	IF %_WBX-TIMETEMP1%==24 set "_WBX-TIMETEMP1=12"&set "_WBX-TIMETEMP3=AM" &GOTO :CONTINUEKERNEL
	set "_WBX-TIMETEMP3=AM"
	:CONTINUEKERNEL
	rem do calculations
	SET _WBX-DATETEMP1=%DATE:~-10,2%
	SET _WBX-DATETEMP2=%DATE:~7,-5%
	SET _WBX-DATETEMP3=%DATE:~-4%

	rem set the variables
	set "_WBX-TASKBAR-TIME=%_WBX-TIMETEMP1%:%_WBX-TIMETEMP2% %_WBX-TIMETEMP3%"
	set "_WBX-TASKBAR-DATE=%_WBX-DATETEMP1%/%_WBX-DATETEMP2%/%_WBX-DATETEMP3%"


	CALL ButtonHeight0 201 56 %THEMEcolor% "%_WBX-TASKBAR-TIME%" 199 57 %THEMEcolor% "%_WBX-TASKBAR-DATE%" X _Button_Boxes _Button_Hover

	rem GUI SYSTEM!
	rem READ FIRST
	rem .
	rem There are 2 types of ways WinBatchX uses with NI's GUI to make and use an interface:
	rem
	rem X X Y Y TYPE GUI ARRAY. Example: IF %X% GTR # IF %X% LSS # IF %Y% GTR # IF %Y% LSS # COMMAND HERE
	rem
	rem X Y X Y TYPE GUI ARRAY. Example: IF %X% GTR # IF %Y% GTR # IF %X% LSS # IF %Y% LSS # COMMAND HERE
	rem
	rem None of the if's are shorter than that, but X Y X Y does better in some situations, because pair 'x y' is plot 1 and the other 'x y' is plot 2. Much easier to humans reading this, right??
	rem Desktop Icons
	rem IF %_ACTIVEAPPLABEL%==explorer.exe IF %I%==m IF %M% EQU 3 IF %X% GTR 1 IF %Y% GTR 8 IF %X% LSS 24 IF %Y% LSS 15 goto :CALCULATOR.EXE

	rem Core Taskbar!:
	IF %_TASKBAR.ALIGNMENT%==0 (
		rem  WIDGET BUTTON
		rem  USING X Y X Y GUI ARRAY
		
		rem Hover
		rem IF %I%==m IF %M% EQU 0 IF %_WIDGETS.EXE%==0 IF %X% GTR 0 IF %Y% GTR 56 IF %X% LSS 8 IF %Y% LSS 59 set M=0 &call insertphoto 15 790 105 taskbar-dashboard-on-%THEME%.bmp

		IF %I%==m IF %M% EQU 1 IF %_WIDGETS.EXE%==1 IF %X% GTR 0 IF %Y% GTR 56 IF %X% LSS 8 IF %Y% LSS 59 set M=0 &set _WIDGETS.EXE=0 &goto :DESKTOP.EXE
		IF %I%==m IF %M% EQU 1 IF %_WIDGETS.EXE%==0 IF %X% GTR 0 IF %Y% GTR 56 IF %X% LSS 8 IF %Y% LSS 59 set M=0 &goto :WIDGETS.EXE


		rem  START MENU CLICK BUTTON
		rem  Using X X Y Y TYPE GUI ARRAY.

		rem Hover
		rem IF %I%==m IF %M% EQU 0 IF %_START.EXE%==0 IF %X% GTR 91 IF %X% LSS 97 IF %Y% GTR 56 IF %Y% LSS 60 set M=0 &call insertphoto 635 786 105 taskbar-start-on-%THEME%.bmp

		IF %I%==m IF %M% EQU 1 IF %_START.EXE%==0 IF %X% GTR 91 IF %X% LSS 97 IF %Y% GTR 56 IF %Y% LSS 60  goto :START.EXE
		IF %I%==m IF %M% EQU 1 IF %_START.EXE%==1 IF %X% GTR 91 IF %X% LSS 97 IF %Y% GTR 56 IF %Y% LSS 60 set _START.EXE=0 &goto :DESKTOP.EXE
		
		IF %I%==m IF %M% EQU 2 IF %_START.EXE%==0 IF %X% GTR 91 IF %X% LSS 97 IF %Y% GTR 56 IF %Y% LSS 60 set M=0 &goto :RIGHTCLICKSTARTMENU.EXE


		rem  SEARCH CLICK BUTTON
		rem  USING X X Y Y TYPE GUI ARRAY.
		
		rem Hover
		rem IF %I%==m IF %M% EQU 0 IF %_SEARCH.EXE%==0 IF %X% GTR 98 IF %X% LSS 103 IF %Y% GTR 56 IF %Y% LSS 59 set M=0 &call insertphoto 687 789 95 taskbar-search-on-%THEME%.bmp

		IF %I%==m IF %M% EQU 1 IF %_SEARCH.EXE%==1 IF %X% GTR 98 IF %X% LSS 103 IF %Y% GTR 56 IF %Y% LSS 59 set _SEARCH.EXE=0  &goto :DESKTOP.EXE
		IF %I%==m IF %M% EQU 1 IF %_SEARCH.EXE%==0 IF %X% GTR 98 IF %X% LSS 103 IF %Y% GTR 56 IF %Y% LSS 59 set _SEARCH.EXE=1 &goto :SEARCH.EXE
		
		
		rem  TASK VIEW BUTTON
		rem  X X Y Y GUI ARRAY

		rem Hover
		rem IF %I%==m IF %M% EQU 0 IF %_TASKVIEW.EXE%==0 IF %X% GTR 106 IF %X% LSS 111 IF %Y% GTR 56 IF %Y% LSS 59 set M=0 &call insertphoto 740 790 95 taskbar-taskview-on-%THEME%.bmp

		IF %I%==m IF %M% EQU 1 IF %_TASKVIEW.EXE%==0 IF %X% GTR 106 IF %X% LSS 111 IF %Y% GTR 56 IF %Y% LSS 59 goto :TASKVIEW.EXE
		IF %I%==m IF %M% EQU 1 IF %_TASKVIEW.EXE%==1 IF %X% GTR 106 IF %X% LSS 111 IF %Y% GTR 56 IF %Y% LSS 59 set _TASKVIEW.EXE=0 &goto :DESKTOP.EXE
		
		rem  App Button
		rem  X Y X Y GUI ARRAY
		IF %I%==m IF %M% EQU 1 IF %X% GTR 112 IF %Y% GTR 56 IF %X% LSS 119 IF %Y% LSS 59 goto :%_ACTIVEAPPLABEL%
		IF %I%==m IF %M% EQU 2 IF %X% GTR 112 IF %Y% GTR 56 IF %X% LSS 119 IF %Y% LSS 59 goto :RIGHTCLICKAPP.EXE
		
		rem  OVERFLOW TASKBAR BUTTON
		rem  X Y X Y GUI ARRAY

		rem Hover
		rem IF %_TASKBAROVERFLOW.EXE%==0 IF %I%==m IF %M% EQU 0 IF %X% GTR 120 IF %Y% GTR 56 IF %X% LSS 126 IF %Y% LSS 59 set M=0 &call insertphoto 850 790 105 taskbar-overflow-on-%THEME%.bmp

		rem IF %_TASKBAROVERFLOW.EXE%==0 IF %I%==m IF %M% EQU 1 IF %X% GTR 120 IF %Y% GTR 56 IF %X% LSS 126 IF %Y% LSS 59 goto :TASKBAROVERFLOW.EXE
		rem IF %_TASKBAROVERFLOW.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 120 IF %Y% GTR 56 IF %X% LSS 126 IF %Y% LSS 59 set "_TASKBAROVERFLOW=0" &goto :TASKBAROVERFLOW.EXE
	)


	IF %_TASKBAR.ALIGNMENT%==1 (

		rem  START MENU CLICK BUTTON
		rem  Using X X Y Y TYPE GUI ARRAY.

		IF %I%==m IF %M% EQU 1 IF %_START.EXE%==0 IF %X% GTR 0 IF %X% LSS 8 IF %Y% GTR 56 IF %Y% LSS 60  goto :START.EXE
		IF %I%==m IF %M% EQU 1 IF %_START.EXE%==1 IF %X% GTR 0 IF %X% LSS 8 IF %Y% GTR 56 IF %Y% LSS 60 set _START.EXE=0 &goto :DESKTOP.EXE
		
		IF %I%==m IF %M% EQU 2 IF %_START.EXE%==0 IF %X% GTR 0 IF %X% LSS 8 IF %Y% GTR 56 IF %Y% LSS 60 set M=0 &goto :RIGHTCLICKSTARTMENU.EXE


		rem  SEARCH CLICK BUTTON
		rem  USING X X Y Y TYPE GUI ARRAY.
		IF %I%==m IF %M% EQU 1 IF %_SEARCH.EXE%==1 IF %X% GTR 8 IF %X% LSS 14 IF %Y% GTR 56 IF %Y% LSS 59 set _SEARCH.EXE=0  &goto :DESKTOP.EXE
		IF %I%==m IF %M% EQU 1 IF %_SEARCH.EXE%==0 IF %X% GTR 8 IF %X% LSS 14 IF %Y% GTR 56 IF %Y% LSS 59 set _SEARCH.EXE=1 &goto :SEARCH.EXE
		
		
		rem  TASK VIEW BUTTON
		rem  X X Y Y GUI ARRAY
		IF %I%==m IF %M% EQU 1 IF %_TASKVIEW.EXE%==0 IF %X% GTR 15 IF %X% LSS 21 IF %Y% GTR 56 IF %Y% LSS 59 goto :TASKVIEW.EXE
		IF %I%==m IF %M% EQU 1 IF %_TASKVIEW.EXE%==1 IF %X% GTR 15 IF %X% LSS 21 IF %Y% GTR 56 IF %Y% LSS 59 set _TASKVIEW.EXE=0 &goto :DESKTOP.EXE
		
		rem  WIDGET BUTTON
		rem  USING X Y X Y GUI ARRAY
		IF %I%==m IF %M% EQU 1 IF %_WIDGETS.EXE%==1 IF %X% GTR 24 IF %Y% GTR 8 IF %X% LSS 29 IF %Y% LSS 59 set M=0 &set _WIDGETS.EXE=0 &goto :DESKTOP.EXE
		IF %I%==m IF %M% EQU 1 IF %_WIDGETS.EXE%==0 IF %X% GTR 24 IF %Y% GTR 8 IF %X% LSS 29 IF %Y% LSS 59 set M=0 &goto :WIDGETS.EXE


		rem  App Button
		rem  X Y X Y GUI ARRAY
		IF %I%==m IF %M% EQU 1 IF %X% GTR 31 IF %Y% GTR 56 IF %X% LSS 39 IF %Y% LSS 59 goto :%_ACTIVEAPPLABEL%
		IF %I%==m IF %M% EQU 2 IF %X% GTR 31 IF %Y% GTR 56 IF %X% LSS 39 IF %Y% LSS 59 goto :RIGHTCLICKAPP.EXE
		

		rem  OVERFLOW TASKBAR BUTTON
		rem  X Y X Y GUI ARRAY
		rem IF %_TASKBAROVERFLOW.EXE%==0 IF %I%==m IF %M% EQU 1 IF %X% GTR 40 IF %Y% GTR 56 IF %X% LSS 45 IF %Y% LSS 59 goto :TASKBAROVERFLOW.EXE
		rem IF %_TASKBAROVERFLOW.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 40 IF %Y% GTR 56 IF %X% LSS 45 IF %Y% LSS 59 set "_TASKBAROVERFLOW=0" &goto :TASKBAROVERFLOW.EXE
	)



		rem  ACTION CENTER BUTTON
		rem  X Y X Y GUI ARRAY
		IF %_ACTION.EXE%==1 IF %M% EQU 1 IF %X% GTR 195 IF %Y% GTR 56 IF %X% LSS 199 IF %Y% LSS 59 set M=0 &set _ACTION.EXE=0 &timeout /T 0 /NOBREAK > nul &goto :DESKTOP.EXE
		IF %_ACTION.EXE%==0 IF %I%==m IF %M% EQU 1 IF %X% GTR 195 IF %Y% GTR 56 IF %X% LSS 199 IF %Y% LSS 59 goto :ACTION.EXE

		rem  NOTIFICATION CENTER BUTTON
		rem  X Y X Y GUI ARRAY
		IF %_NOTIFICATION.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %Y% GTR 56 IF %X% LSS 212 IF %Y% LSS 58 set _NOTIFICATION.EXE=0 &goto :DESKTOP.EXE
		IF %_NOTIFICATION.EXE%==0 IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %Y% GTR 56 IF %X% LSS 212 IF %Y% LSS 58 GOTO :NOTIFICATION.EXE



		rem  RIGHTCLICKDESKTOP
		IF %I%==m IF %M% EQU 2 IF %X% GTR 0 IF %X% LSS 200 IF %Y% GTR 0 IF %Y% LSS 55 IF %_ACTIVEAPPLABEL%==explorer.exe goto :RIGHTCLICKDESKTOP.EXE


		rem  RIGHTCLICKTASKBAR
		IF %I%==m IF %M% EQU 2 IF %X% GTR 0 IF %X% LSS 212 IF %Y% GTR 56 IF %Y% LSS 59 goto :RIGHTCLICKTASKBAR.EXE



rem Feature system settings-
	
	rem  START MENU TASKS
	rem  Using X Y X Y TYPE GUI ARRAY.
	rem 
	IF %_START.EXE%==1 (

	rem Search Bar:
		IF %I%==m IF %M% EQU 1 IF %X% GTR 74 IF %Y% GTR 10 IF %X% LSS 150 IF %Y% LSS 12 set _SEARCH.EXE=1 &goto :SEARCH.EXE

	rem Apps:
		IF %I%==m IF %M% EQU 1 IF %X% GTR 135 IF %Y% GTR 13 IF %X% LSS 146 IF %Y% LSS 15 set START.EXE=0 &goto :START-ALLAPPS.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 74 IF %Y% GTR 16 IF %X% LSS 89 IF %Y% LSS 22 set _START.EXE=0 &CALL BOX 74 16 7 15 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :EDGE.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 91 IF %Y% GTR 16 IF %X% LSS 101 IF %Y% LSS 22 set _START.EXE=0 &CALL BOX 91 16 7 12 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :NOTEPAD.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 103 IF %Y% GTR 16 IF %X% LSS 117 IF %Y% LSS 22 set _START.EXE=0 &CALL BOX 103 16 7 16 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :EXPLORER.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 121 IF %Y% GTR 16 IF %X% LSS 131 IF %Y% LSS 22 set _START.EXE=0 &CALL BOX 121 16 7 14 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :SETTINGS.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 16 IF %X% LSS 149 IF %Y% LSS 22 set _START.EXE=0 &CALL BOX 137 16 6 12 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :SECURITY.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 74 IF %Y% GTR 23 IF %X% LSS 89 IF %Y% LSS 27 set _START.EXE=0 &CALL BOX 74 23 6 12 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :TERMINAL.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 91 IF %Y% GTR 23 IF %X% LSS 101 IF %Y% LSS 27 set _START.EXE=0 &CALL BOX 91 23 6 12 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :PHOTOS.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 103 IF %Y% GTR 23 IF %X% LSS 117 IF %Y% LSS 27 set _START.EXE=0 &CALL BOX 103 23 6 16 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :PAINT.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 121 IF %Y% GTR 23 IF %X% LSS 131 IF %Y% LSS 27 set _START.EXE=0 &CALL BOX 121 23 6 12 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :CALCULATOR.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 23 IF %X% LSS 149 IF %Y% LSS 27 set _START.EXE=0 &CALL BOX 137 23 6 12 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :CALENDAR.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 74 IF %Y% GTR 30 IF %X% LSS 89 IF %Y% LSS 35 set _START.EXE=0 &CALL BOX 74 29 6 12 - - f3  1 &timeout /T 0 /NOBREAK > nul &call OOBE.BAT &goto :DESKTOP.EXE
    	IF %I%==m IF %M% EQU 1 IF %X% GTR 91 IF %Y% GTR 30 IF %X% LSS 101 IF %Y% LSS 35 set _START.EXE=0 &CALL BOX 89 29 6 15 - - f3  1 &timeout /T 0 /NOBREAK > nul &goto :TASKMGR.EXE

    	IF %I%==m IF %M% EQU 1 IF %X% GTR 139 IF %Y% GTR 14 IF %X% LSS 150 IF %Y% LSS 14 set _START.EXE=0 &goto :DESKTOP.EXE
	)



	rem  START MENU POWER TASKS
	rem  Using X Y X Y TYPE GUI ARRAY.
	
	rem  Sign Out
	IF %_START.EXE%==1 IF %_START-POWERMENU.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 44 IF %X% LSS 149 IF %Y% LSS 46 set _START-POWERMENU.EXE=0 &goto :WBX-LOGIN.EXE
	
	rem  Shut Down
	IF %_START.EXE%==1 IF %_START-POWERMENU.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 46 IF %X% LSS 149 IF %Y% LSS 48 set _START-POWERMENU.EXE=0 &goto :SHUTDOWN.EXE
	
	rem  Restart
	IF %_START.EXE%==1 IF %_START-POWERMENU.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 137 IF %Y% GTR 48 IF %X% LSS 149 IF %Y% LSS 50 set _START-POWERMENU.EXE=0 &goto :RESTART.EXE
	
	rem  Open
	IF %_START.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 140 IF %Y% GTR 51 IF %X% LSS 145 IF %Y% LSS 53 set _START-POWERMENU.EXE=1 &goto :START-POWERMENU.EXE
	
	rem  Close
	IF %_START.EXE%==1 IF %_START-POWERMENU.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 71 IF %Y% GTR 9 IF %X% LSS 152 IF %Y% LSS 54 set _START-POWERMENU.EXE=0 &goto :START.EXE
	



	rem  SEARCH TASKS
	rem  USING X X Y Y TYPE GUI ARRAY.
	IF %_SEARCH.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 70 IF %X% LSS 154 IF %Y% GTR 26 IF %Y% LSS 28 goto :SEARCH.RUN.EXE
		

	rem  TASK VIEW TASKS --funny, [task] view [tasks]
	rem  USING X Y X Y TYPE GUI ARRAY.

	rem Close windows:
	IF %_TASKVIEW.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 147 IF %Y% GTR 14 IF %X% LSS 152 IF %Y% LSS 16 call :CLEARCACHE.EXE &goto :DESKTOP.EXE




	rem  ACTION CENTER TASKS
	rem  USING X X Y Y TYPE GUI ARRAY.
		

	rem the menu:

		rem Accessiblity
		IF %_ACTION.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 166 IF %X% LSS 179 IF %Y% GTR 43 IF %Y% LSS 45 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=ACCESSIBILITY &goto :SETTINGS.EXE


	rem Bottom of the menu:

		rem To personalize the menu:
		IF %_ACTION.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 197 IF %X% LSS 201 IF %Y% GTR 52 IF %Y% LSS 54 goto :SETTINGS.EXE

		rem Settings shortcut
		IF %_ACTION.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 203 IF %X% LSS 207 IF %Y% GTR 52 IF %Y% LSS 54 goto :SETTINGS.EXE
	







































rem Batch App controls-

IF %I%==m IF %M% EQU 1 IF %X% GTR 200 IF %Y% GTR 0 IF %X% LSS 211 IF %Y% LSS 11 set M=0 &call :CLEARCACHE.EXE &goto :DESKTOP.EXE

rem settings revision 4
	IF %_ACTIVEAPPLABEL%==settings.exe (
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 12 IF %X% LSS 33 IF %Y% LSS 14 goto :SETTINGS.SYSTEM
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 15 IF %X% LSS 33 IF %Y% LSS 17 goto :SETTINGS.PERSONALIZATION
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 18 IF %X% LSS 33 IF %Y% LSS 20 goto :SETTINGS.APPS
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 21 IF %X% LSS 33 IF %Y% LSS 23 goto :SETTINGS.ACCOUNTS
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 24 IF %X% LSS 33 IF %Y% LSS 26 goto :SETTINGS.TIMELANGUAGE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 27 IF %X% LSS 33 IF %Y% LSS 29 goto :SETTINGS.ACCESSIBILITY
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 30 IF %X% LSS 33 IF %Y% LSS 32 goto :SETTINGS.PRIVACYSECURITY
		IF %I%==m IF %M% EQU 1 IF %X% GTR 1 IF %Y% GTR 33 IF %X% LSS 33 IF %Y% LSS 35 goto :SETTINGS.UPDATE


	rem opening system-specific pages on settings
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 16 IF %X% LSS 202 IF %Y% LSS 19 goto :SETTINGS.SYSTEM.DISPLAY
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 19 IF %X% LSS 202 IF %Y% LSS 22 goto :SETTINGS.SYSTEM.SOUND
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 22 IF %X% LSS 202 IF %Y% LSS 25 goto :SETTINGS.SYSTEM.NOTIFICATION
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 28 IF %X% LSS 202 IF %Y% LSS 31 goto :SETTINGS.SYSTEM.POWER
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 31 IF %X% LSS 202 IF %Y% LSS 34 goto :SETTINGS.SYSTEM.STORAGE
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 34 IF %X% LSS 202 IF %Y% LSS 37 goto :SETTINGS.SYSTEM.MULTITASKING
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 37 IF %X% LSS 202 IF %Y% LSS 40 goto :SETTINGS.SYSTEM.TROUBLESHOOT
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 40 IF %X% LSS 202 IF %Y% LSS 43 goto :SETTINGS.SYSTEM.RECOVERY
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 43 IF %X% LSS 202 IF %Y% LSS 46 goto :SETTINGS.SYSTEM.CLIPBOARD
	IF %_SETTINGS.SECTION%==SYSTEM IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 46 IF %X% LSS 202 IF %Y% LSS 49 goto :SETTINGS.SYSTEM.ABOUT

	IF %_SETTINGS.SECTION%==PERSONALIZATION IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 45 IF %X% LSS 202 IF %Y% LSS 48 goto :SETTINGS.PERSONALIZATION.TASKBAR

	rem closing system-based pages on settings
	IF %_SETTINGS.SECTION%==SYSTEM.DISPLAY IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.SOUND IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.NOTIFICATION IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.POWER IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.STORAGE IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.MULTITASKING IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.TROUBLESHOOT IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.RECOVERY IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.CLIPBOARD IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM
	IF %_SETTINGS.SECTION%==SYSTEM.ABOUT IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.SYSTEM

	IF %_SETTINGS.SECTION%==PERSONALIZATION.TASKBAR IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.PERSONALIZATION



	rem SYSTEM.DISPLAY
	IF %_SETTINGS.SECTION%==SYSTEM.DISPLAY IF %I%==m IF %M% EQU 1 IF %X% GTR 122 IF %Y% GTR 8 IF %X% LSS 127 IF %Y% LSS 10 CALL ButtonHeight0 65 8 f0 "                                                                  " X _Button_Boxes _Button_Hover

	IF %_SETTINGS.SECTION%==PERSONALIZATION IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.PERSONALIZATION


		IF %_SETTINGS.SECTION%==PERSONALIZATION.TASKBAR IF %I%==m IF %M% EQU 1 IF %X% GTR 121 IF %Y% GTR 23 IF %X% LSS 129 IF %Y% LSS 25 (
			timeout /T 1 /NOBREAK > nul
			set M=0
			IF %_TASKBAR.ALIGNMENT%==1 set _TASKBAR.ALIGNMENT=0
			IF %_TASKBAR.ALIGNMENT%==0 set _TASKBAR.ALIGNMENT=1

			call :SETTINGS.REWRITECONFIG
			call :TASKBARDRAW.EXE
			call :TASKBARICON.EXE
			goto :SETTINGS.PERSONALIZATION.TASKBAR
		)

	)

	IF %_SETTINGS.SECTION%==ACCOUNTS IF %I%==m IF %M% EQU 1 IF %X% GTR 65 IF %Y% GTR 17 IF %X% LSS 193 IF %Y% LSS 19 goto :SETTINGS.ACCOUNTS.PROFILE
	IF %_SETTINGS.SECTION%==ACCOUNTS IF %I%==m IF %M% EQU 1 IF %X% GTR 65 IF %Y% GTR 20 IF %X% LSS 193 IF %Y% LSS 23 goto :SETTINGS.ACCOUNTS.SIGNIN
	
	IF %_SETTINGS.SECTION%==ACCOUNTS.PROFILE IF %I%==m IF %M% EQU 1 IF %X% GTR 55 IF %Y% GTR 4 IF %X% LSS 65 IF %Y% LSS 6 goto :SETTINGS.ACCOUNTS
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 151 IF %Y% GTR 21 IF %X% LSS 157 IF %Y% LSS 24 goto :SETTINGS.ACCOUNTS
	
	
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 92 IF %Y% GTR 31 IF %X% LSS 108 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 130 IF %Y% GTR 31 IF %X% LSS 146 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS
	
	
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE IF %I%==m IF %M% EQU 1 IF %X% GTR 130 IF %Y% GTR 31 IF %X% LSS 146 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS
	
	IF %_SETTINGS.SECTION%==UPDATE IF %I%==m IF %M% EQU 1 IF %X% GTR 180 IF %Y% GTR 8 IF %X% LSS 201 IF %Y% LSS 12 goto :SETTINGS.UPDATE.WGET
	
	
	rem PAINT
	IF %_PAINT.EXE%==1 (
		IF %I%==m IF %M% EQU 1 IF %X% GTR 7 IF %X% LSS 178 IF %Y% GTR 10 IF %Y% LSS 53 CALL ButtonHeight0 %X% %Y% %_PAINT.COLOR%0 " " X _Button_Boxes _Button_Hover &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 21 IF %X% LSS 25 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=0" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 25 IF %X% LSS 30 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=4" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 31 IF %X% LSS 35 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=c" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 36 IF %X% LSS 40 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=6" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 41 IF %X% LSS 45 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=e" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 46 IF %X% LSS 50 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=a" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 51 IF %X% LSS 55 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=2" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %X% LSS 60 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=b" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 61 IF %X% LSS 65 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=3" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 66 IF %X% LSS 70 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=9" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 71 IF %X% LSS 75 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=1" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 76 IF %X% LSS 80 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=5" &goto :KERNEL.EXE
		IF %I%==m IF %M% EQU 1 IF %X% GTR 81 IF %X% LSS 85 IF %Y% GTR 5 IF %Y% LSS 7 set "_PAINT.COLOR=d" &goto :KERNEL.EXE
	)

	rem TERMINAL
	IF %_TERMINAL.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 90 IF %Y% GTR 30 IF %X% LSS 106 IF %Y% LSS 32 goto :TERMINAL.START
	IF %_TERMINAL.EXE%==1 IF %I%==m IF %M% EQU 0 IF %X% GTR 0 IF %X% LSS 200 IF %Y% GTR 0 IF %Y% LSS 55 CALL ButtonBorder 90 30 0f "Open Terminal" X _Button_Boxes _Button_Hover
	IF %_TERMINAL.EXE%==1 IF %I%==m IF %M% EQU 0 IF %X% GTR 90 IF %Y% GTR 30 IF %X% LSS 106 IF %Y% LSS 32 CALL ButtonBorder 90 30 03 "Open Terminal" X _Button_Boxes _Button_Hover


	rem  SECURITY!
	IF %_SECURITY.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 14 IF %Y% GTR 7 IF %X% LSS 30 IF %Y% LSS 10 call :SECURITY.SCAN &goto :SECURITY.EXE


	rem  PHOTOS

	rem  Import
	IF %_PHOTOS.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 172 IF %Y% GTR 0 IF %X% LSS 184 IF %Y% LSS 2 call :PHOTOS.SAVEFILEDIALOG &goto :PHOTOS.EXE
	
	rem  Settings
	IF %_PHOTOS.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 188 IF %Y% GTR 0 IF %X% LSS 195 IF %Y% LSS 2 call :PHOTOS.SAVEFILEDIALOG &goto :PHOTOS.EXE
	)
goto :KERNEL.EXE







:START.EXE

rem To make sure all features are 'shut down' correctly:
call :TASKBARCLEAR.EXE

set M=0
set _START.EXE=1
call :TASKBARICON.EXE
rem  The least to make are sharp corners rounded (3px):

call insertphoto 500 130 544 blank.%THEME%.bmp
call insertphoto 494 132 530 blank.%THEME%.bmp
call insertphoto 492 137 530 blank.%THEME%.bmp



call insertphoto 492 730 30 blank.%THEME%.bmp
call insertphoto 494 734 30 blank.%THEME%.bmp
call insertphoto 500 736 30 blank.%THEME%.bmp
call insertphoto 500 150 550 blank.%THEME%.bmp
call insertphoto 510 174 532 blank.%THEME%.bmp
call insertphoto 1038 735 30 blank.%THEME%.bmp


call insertphoto 1041 137 30 blank.%THEME%.bmp
call insertphoto 1039 132 30 blank.%THEME%.bmp

rem  Start Outlined:
rem  Rounded to support 3px corners (3px corners are a test)

rem  Top
PIXELDRAW /dl /p 501 130 1060 130 /c 7
PIXELDRAW /dl /p 501 130 490 136 /c 7

rem  Left Side
PIXELDRAW /dl /p 490 136 490 764 /c 7
PIXELDRAW /dl /p 490 764 501 770 /c 7

rem  Right Side
PIXELDRAW /dl /p 1072 136 1072 764 /c 7
PIXELDRAW /dl /p 1060 770 1072 764 /c 7

rem  Bottom
PIXELDRAW /dl /p 501 770 1060 770 /c 7
PIXELDRAW /dl /p 1060 130 1072 136 /c 7

rem Line border for bottom/up menu
PIXELDRAW /dl /p 490 700 1072 700 /c 7


rem  Search Bar Outline Rounded:
rem  Top
PIXELDRAW /dl /p 521 143 1049 143 /c 7
rem  Left Side
PIXELDRAW /dl /p 519 145 519 175 /c 7
rem  Right Side
PIXELDRAW /dl /p 1050 145 1050 175 /c 7
rem  Bottom
PIXELDRAW /dl /p 521 177 1049 177 /c 9



rem  All Apps Outline Rounded:
rem  Top
PIXELDRAW /dl /p 945 206 1028 206 /c 7

rem  Left Side
PIXELDRAW /dl /p 943 208 943 226 /c 7

rem  Right Side
PIXELDRAW /dl /p 1030 208 1030 226 /c 7

rem  Bottom
PIXELDRAW /dl /p 945 228 1028 228 /c 7

call insertphoto 535 150 120 taskbar-searchbar-top.bmp

call insertphoto 550 250 15 edge.%THEME%.bmp
call insertphoto 655 250 15 notepad.%THEME%.bmp
call insertphoto 752 250 15 explorer.%THEME%.bmp
call insertphoto 868 250 15 settings.%THEME%.bmp
call insertphoto 985 250 15 security.%THEME%.bmp

call insertphoto 550 330 15 terminal.%THEME%.bmp
call insertphoto 655 330 15 photos.%THEME%.bmp
call insertphoto 752 330 15 paint.%THEME%.bmp
call insertphoto 868 330 15 calculator.%THEME%.bmp
call insertphoto 985 330 15 calendar.%THEME%.bmp

call insertphoto 550 420 17 batchinstaller-%THEME%.bmp
call insertphoto 655 420 15 taskmgr.%THEME%.bmp




call insertphoto 535 720 12 profile-icon.bmp


call insertphoto 990 725 125 ui.power.bmp

CALL ButtonHeight0 80 10 %THEMEcolor% "Type here to search" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 77 14 %THEMEcolor% "Pinned" 133 14 %THEMEcolor% " All Apps > " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 75 35 %THEMEcolor% "Recomended" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 77 20 %THEMEcolor% "Edge" 91 20 %THEMEcolor% "Notepad" 102 20 %THEMEcolor% "File Explorer" 121 20 %THEMEcolor% "Settings" 138 20 %THEMEcolor% "Security" 75 26 %THEMEcolor% "Terminal" 91 26 %THEMEcolor% "Photos" 106 26 %THEMEcolor% "Paint" 120 26 %THEMEcolor% "Calculator" 138 26 %THEMEcolor% "Calendar" 77 32 %THEMEcolor% "Setup" 88 32 %THEMEcolor% "Task Manager" 80 51 %THEMEcolor% "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover
rem  CALL ButtonHeight0 75 35 %THEMEcolor% "Recommended" 75 38 %THEMEcolor% "Get Started" 75 39 %THEMEcolor% "Welcome to WinBatchX" 75 41 %THEMEcolor% "Coming soon." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE




:START-ALLAPPS.EXE
set M=0
call insertphoto 500 130 544 blank.%THEME%.bmp
call insertphoto 494 132 530 blank.%THEME%.bmp
call insertphoto 492 137 530 blank.%THEME%.bmp
call insertphoto 492 730 30 blank.%THEME%.bmp
call insertphoto 494 734 30 blank.%THEME%.bmp
call insertphoto 500 736 30 blank.%THEME%.bmp
call insertphoto 500 150 550 blank.%THEME%.bmp
call insertphoto 510 174 532 blank.%THEME%.bmp
call insertphoto 1038 735 30 blank.%THEME%.bmp
call insertphoto 1041 137 30 blank.%THEME%.bmp
call insertphoto 1039 132 30 blank.%THEME%.bmp



rem  Search Bar Outline Rounded:
rem  Top
PIXELDRAW /dl /p 521 143 1049 143 /c 7
rem  Left Side
PIXELDRAW /dl /p 519 145 519 175 /c 7
rem  Right Side
PIXELDRAW /dl /p 1050 145 1050 175 /c 7
rem  Bottom
PIXELDRAW /dl /p 521 177 1049 177 /c 9


rem  All Apps Outline Rounded:
rem  Top
PIXELDRAW /dl /p 945 206 1028 206 /c 7

rem  Left Side
PIXELDRAW /dl /p 943 208 943 226 /c 7

rem  Right Side
PIXELDRAW /dl /p 1030 208 1030 226 /c 7

rem  Bottom
PIXELDRAW /dl /p 945 228 1028 228 /c 7

call insertphoto 535 150 120 taskbar-searchbar-top.bmp

CALL ButtonHeight0 80 10 %THEMEcolor% "Type here to search" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 74 14 %THEMEcolor% "All Apps" 133 14 %THEMEcolor% " < Go Back " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 96 24 %THEMEcolor% "Unavailable" X _Button_Boxes _Button_Hover

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

call insertphoto 535 720 12 profile-icon.bmp


call insertphoto 990 725 125 ui.power.bmp



Set _Result=0
GetInput /m 86 56 91 58 93 56 97 58 99 56 105 58 107 56 111 58 195 56 199 58 201 56 212 58 139 15 150 15

Set _Result=%Errorlevel%
IF %_Result%==1 goto :DESKTOP.EXE
IF %_Result%==7 goto :START.EXE
goto :DESKTOP.EXE




:START-POWERMENU.EXE
set _START-POWERMENU.EXE=1

rem  Power Button Outlined:

rem  Top
PIXELDRAW /dl /p 988 720 1020 720 /c 7
rem  Left Side
PIXELDRAW /dl /p 984 722 984 755 /c 7
rem  Right Side
PIXELDRAW /dl /p 1022 722 1022 755 /c 7
rem  Bottom
PIXELDRAW /dl /p 988 757 1020 757 /c 7






call insertphoto 950 620 40 UI.buttonwhite.bmp
call insertphoto 949 621 41 UI.buttonwhite.bmp
call insertphoto 951 624 40 UI.buttonwhite.bmp

call insertphoto 950 630 40 UI.buttonwhite.bmp
call insertphoto 949 631 41 UI.buttonwhite.bmp
call insertphoto 951 634 40 UI.buttonwhite.bmp

call insertphoto 950 670 40 UI.buttonwhite.bmp
call insertphoto 949 671 41 UI.buttonwhite.bmp
call insertphoto 951 674 40 UI.buttonwhite.bmp

rem  Top
PIXELDRAW /dl /p 951 620 1049 620 /c 7
rem  Left Side
PIXELDRAW /dl /p 949 622 949 708 /c 7
rem  Right Side
PIXELDRAW /dl /p 1051 622 1051 708 /c 7
rem  Bottom
PIXELDRAW /dl /p 951 710 1049 710 /c 7


call insertphoto 955 630 95 ui.signout.bmp
CALL ButtonHeight0 138 44 f0 "Sign Out" X _Button_Boxes _Button_Hover

call insertphoto 955 655 100 ui.power.bmp
CALL ButtonHeight0 138 46 f0 "Shutdown" X _Button_Boxes _Button_Hover

call insertphoto 955 680 95 ui.restart.bmp
CALL ButtonHeight0 138 48 f0 "Restart" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE


:WBX-STARTMENU-ACCOUNTMENU.EXE
goto :KERNEL.EXE















:SEARCH.EXE

rem To make sure all features are 'shut down' correctly:
call :TASKBARCLEAR.EXE


set M=0
set _SEARCH.EXE=1
call :TASKBARICON.EXE
call insertphoto 470 355 313 blank.%THEME%.bmp
call insertphoto 468 356 313 blank.%THEME%.bmp
call insertphoto 776 356 313 blank.%THEME%.bmp

call insertphoto 775 355 313 blank.%THEME%.bmp

call insertphoto 470 420 313 blank.%THEME%.bmp
call insertphoto 468 420 313 blank.%THEME%.bmp
call insertphoto 776 420 313 blank.%THEME%.bmp

call insertphoto 469 421 313 blank.%THEME%.bmp
call insertphoto 775 421 313 blank.%THEME%.bmp
rem PIXELDRAW /dr 470 355 /rd 631 415 /c 7


rem  Search Bar Outline Rounded:
rem  Top
PIXELDRAW /dl /p 491 370 1079 370 /c 7
rem  Left Side
PIXELDRAW /dl /p 489 372 489 398 /c 7
rem  Right Side
PIXELDRAW /dl /p 1080 372 1080 398 /c 7
rem  Bottom
PIXELDRAW /dl /p 491 400 1079 400 /c 9

call insertphoto 500 374 120 taskbar-searchbar-top.bmp

Call ButtonHeight0 74 26 %THEMEcolor% "Click here to search" X _Button_Boxes _Button_Hover







CALL ButtonHeight0 68 29 %THEMEcolor% "Recent" X _Button_Boxes _Button_Hover

call insertphoto 500 445 8 edge.bmp
CALL ButtonHeight0 75 31 %THEMEcolor% "Edge" X _Button_Boxes _Button_Hover

call insertphoto 500 475 8 explorer.bmp
CALL ButtonHeight0 75 33 %THEMEcolor% "File Explorer" X _Button_Boxes _Button_Hover

call insertphoto 500 500 8 notepad.bmp
CALL ButtonHeight0 75 35 %THEMEcolor% "Notepad" X _Button_Boxes _Button_Hover

call insertphoto 500 530 8 paint.bmp
CALL ButtonHeight0 75 37 %THEMEcolor% "Paint" X _Button_Boxes _Button_Hover

call insertphoto 500 560 8 settings.bmp
CALL ButtonHeight0 75 39 %THEMEcolor% "Settings" X _Button_Boxes _Button_Hover

call insertphoto 500 585 8 calendar.bmp
CALL ButtonHeight0 75 41 %THEMEcolor% "Calendar" X _Button_Boxes _Button_Hover







Call ButtonHeight0 100 29 %THEMEcolor% "Today - %DATE% " X _Button_Boxes _Button_Hover


goto :KERNEL.EXE





:TASKVIEW.EXE

rem To make sure all features are 'shut down' correctly:
call :TASKBARCLEAR.EXE


set M=0
	set _TASKVIEW.EXE=1
	call :TASKBARDRAW.EXE
	call :TASKBARICON.EXE

	call :COMPOSE.EXE


	call insertphoto 19 606 42 blank.%THEME%.bmp
	call insertphoto 1437 606 42 blank.%THEME%.bmp
	call insertphoto 20 605 1000 taskbar.%THEME%.bmp

	call insertphoto 19 646 42 blank.%THEME%.bmp
	call insertphoto 1437 646 42 blank.%THEME%.bmp
	call insertphoto 20 645 1000 taskbar.%THEME%.bmp

	call insertphoto 19 669 42 blank.%THEME%.bmp
	call insertphoto 1437 669 42 blank.%THEME%.bmp
	call insertphoto 20 668 1000 taskbar.%THEME%.bmp

	call insertphoto 19 716 42 blank.%THEME%.bmp
	call insertphoto 1437 716 42 blank.%THEME%.bmp
	call insertphoto 20 715 1000 taskbar.%THEME%.bmp

	rem DEBUG:  IF %_APP.EXE%==0 call BUTTONBORDER 99 23 %THEMEcolor% "No apps open." X _Button_Boxes _Button_Hover

	IF %_APP.EXE%==1 call insertphoto 460 200 60 blankloadapp.%THEME%.bmp &call insertphoto 460 208 60 blankloadapp.%THEME%.bmp &call insertphoto 458 202 61 blankloadapp.%THEME%.bmp &call insertphoto 467 200 60 blankloadapp.%THEME%.bmp &call insertphoto 467 208 60 blankloadapp.%THEME%.bmp &call insertphoto 730 300 25 %_ACTIVEAPPIMAGE%.%THEME%.bmp 
	call insertphoto 465 204 10 %_ACTIVEAPPIMAGE%.%THEME%.bmp &call ButtonHeight0 69 14 %THEMEcolor% "%_ACTIVEAPPTITLE%" X _Button_Boxes _Button_Hover &call insertphoto 1040 210 120 UI.context.close.bmp
	rem  CALL BOX 74 16 10 35 - - f0  0

	call BUTTONHEIGHT0 91 43 %THEMEcolor% "Desktop 1" X _Button_Boxes _Button_Hover
	call insertphoto 650 630 10 "%BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp"
	call insertphoto 740 750 120 taskbar-using-%THEME%.bmp

	PIXELDRAW /dr 650 630 /rd 194 120 /c 7


	PIXELDRAW /dr 640 615 /rd 210 148 /c 7
	call :KERNEL.EXE
	goto :TASKVIEW.EXE 







:WIDGETS.EXE

rem To make sure all features are 'shut down' correctly:
call :TASKBARCLEAR.EXE


set M=0
set _WIDGETS.EXE=1
call :TASKBARICON.EXE
call insertphoto 30 30 650 blank.%THEME%.bmp

rem  Left Side of GUI
call insertphoto 29 31 50 blank.%THEME%.bmp
call insertphoto 29 33 646 blank.%THEME%.bmp


rem  Right Side of GUI
call insertphoto 655 31 50 blank.%THEME%.bmp
call insertphoto 35 33 646 blank.%THEME%.bmp

rem Top
PIXELDRAW /dl /p 31 30 703 30 /c 7
rem Left
PIXELDRAW /dl /p 29 32 29 755 /c 7
rem Right
PIXELDRAW /dl /p 705 32 705 755 /c 7
rem Bottom
PIXELDRAW /dl /p 31 757 703 757 /c 7

call ButtonHeight0 45 2 %THEMEcolor% "%_WBX-TASKBAR-TIME% " X _Button_Boxes _Button_Hover



call ButtonHeight0 10 5 %THEMEcolor% "___________________________________      _________________________________" X _Button_Boxes _Button_Hover



call ButtonHeight0 10 8 %THEMEcolor% "Latest WinBatchX Release:" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 10 %THEMEcolor% "%Newest-Version-Release%" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 14 %THEMEcolor% "%Newest-Version-Release-Link%" X _Button_Boxes _Button_Hover


rem call ButtonHeight0 54 8 %THEMEcolor% "Tips" X _Button_Boxes _Button_Hover
rem call ButtonHeight0 54 10 %THEMEcolor% "This widget is in beta" X _Button_Boxes _Button_Hover





call ButtonHeight0 10 15 %THEMEcolor% "___________________________________      _________________________________" X _Button_Boxes _Button_Hover




call ButtonHeight0 10 18 %THEMEcolor% "Latest WinBatchX Beta Build Release:" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 20 %THEMEcolor% "%Newest-Build-Release%" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 24 %THEMEcolor% "%Newest-Build-Release-Link%" X _Button_Boxes _Button_Hover


rem call ButtonHeight0 54 18 %THEMEcolor% "Calendar" X _Button_Boxes _Button_Hover
rem call ButtonHeight0 54 20 %THEMEcolor% "This widget will be in 18.1." X _Button_Boxes _Button_Hover



call ButtonHeight0 10 25 %THEMEcolor% "___________________________________      _________________________________" X _Button_Boxes _Button_Hover

call ButtonHeight0 10 28 %THEMEcolor% "__________________________________________________________________________" X _Button_Boxes _Button_Hover



call ButtonHeight0 10 31 %THEMEcolor% "Special News" X _Button_Boxes _Button_Hover
call ButtonHeight0 10 32 %THEMEcolor% "%Special-News%" X _Button_Boxes _Button_Hover



call ButtonHeight0 10 38 %THEMEcolor% "__________________________________________________________________________" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE



:ACTION.EXE

rem To make sure all features are 'shut down' correctly:
call :TASKBARCLEAR.EXE


set M=0
set _ACTION.EXE=1
call :TASKBARICON.EXE

rem 1663- outline the rounded action center more efficent
rem removed in this build due to errors

call insertphoto 1150 590 157 blank.light.bmp
call insertphoto 1148 592 157 blank.light.bmp
call insertphoto 1300 590 157 blank.light.bmp
call insertphoto 1302 592 157 blank.light.bmp



call insertphoto 1170 605 35 UI.buttonwhite.bmp

call insertphoto 1174 610 135 ui.accessibility.bmp
PIXELDRAW /dr 1170 605 /rd 90 35 /c 7


call insertphoto 1170 690 115 UI.sound.bmp


PIXELDRAW /dl /p 1200 697 1440 697 /c 3




PIXELDRAW /dl /p 1148 720 1465 720 /c 7

call insertphoto 1385 735 115 UI.pencil.bmp
call insertphoto 1430 735 115 UI.setting.bmp

goto :KERNEL.EXE






:NOTIFICATION.EXE

rem To make sure all features are 'shut down' correctly:
call :TASKBARCLEAR.EXE


set M=0
set _NOTIFICATION.EXE=1
call :TASKBARICON.EXE

::draw backgrounds

call insertphoto 1220 480 252 blank.%THEME%.bmp
call insertphoto 1218 481 252 blank.%THEME%.bmp
call insertphoto 1217 483 252 blank.%THEME%.bmp
:: Outline corners

::Top
PIXELDRAW /dl /p 1221 480 1480 480 /c 7
::Left
PIXELDRAW /dl /p 1219 482 1219 762 /c 7
::Right
PIXELDRAW /dl /p 1482 482 1482 762 /c 7
::Bottom
PIXELDRAW /dl /p 1221 764 1480 764 /c 7



Call ButtonHeight0 176 35 f0 "                              " X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 38 f0 "                              " X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "                              " X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "                              " X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "                              " X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "                              " X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "                              " X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "                              " X _Button_Boxes _Button_Hover


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
Call ButtonHeight0 176 35 f0 "January %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%JAN:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%JAN:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%JAN:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%JAN:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%JAN:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%JAN:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.FEB
Call ButtonHeight0 176 35 f0 "Febuary %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%FEB:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%FEB:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%FEB:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%FEB:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%FEB:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%FEB:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.MAR
Call ButtonHeight0 176 35 f0 "March %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%MAR:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%MAR:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%MAR:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%MAR:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%MAR:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%MAR:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.APR
Call ButtonHeight0 176 35 f0 "April %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%APR:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%APR:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%APR:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%APR:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%APR:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%APR:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.MAY
Call ButtonHeight0 176 35 f0 "May %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%MAY:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%MAY:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%MAY:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%MAY:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%MAY:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%MAY:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.JUN
Call ButtonHeight0 176 35 f0 "June %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%JUN:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%JUN:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%JUN:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%JUN:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%JUN:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%JUN:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1


:WBX-NOTIFICATIONCENTER.JUL
Call ButtonHeight0 176 35 f0 "July %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%JUL:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%JUL:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%JUL:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%JUL:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%JUL:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%JUL:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.AUG
Call ButtonHeight0 176 35 f0 "August %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%AUG:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%AUG:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%AUG:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%AUG:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%AUG:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%AUG:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.SEP
Call ButtonHeight0 176 35 f0 "September %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%SEP:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%SEP:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%SEP:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%SEP:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%SEP:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%SEP:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.OCT
Call ButtonHeight0 176 35 f0 "October %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%OCT:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%OCT:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%OCT:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%OCT:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%OCT:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%OCT:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.NOV
Call ButtonHeight0 176 35 f0 "November %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%NOV:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%NOV:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%NOV:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%NOV:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%NOV:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%NOV:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.DEC
Call ButtonHeight0 176 35 f0 "December %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 41 f0 "%DEC:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 43 f0 "%DEC:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 45 f0 "%DEC:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 47 f0 "%DEC:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 49 f0 "%DEC:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 176 51 f0 "%DEC:~105%" X _Button_Boxes _Button_Hover

goto :NOTIFICATION.EXE1




:NOTIFICATION.EXE1


::draw backgrounds
call insertphoto 1220 350 102 blank.%THEME%.bmp
call insertphoto 1218 351 102 blank.%THEME%.bmp
call insertphoto 1217 353 102 blank.%THEME%.bmp
call insertphoto 1320 350 102 blank.%THEME%.bmp
call insertphoto 1318 351 102 blank.%THEME%.bmp
call insertphoto 1317 353 102 blank.%THEME%.bmp
call insertphoto 1370 350 102 blank.%THEME%.bmp
call insertphoto 1368 351 102 blank.%THEME%.bmp
call insertphoto 1367 353 102 blank.%THEME%.bmp
Call ButtonHeight0 180 28 f8 "No New Notifications" X _Button_Boxes _Button_Hover
Call ButtonHeight0 199 25 f0 "Clear All" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE



















































:RIGHTCLICKDESKTOP.EXE
set M=0

rem Debug purposes: do not use in alpha builds.
rem It's WAYY too slow!


rem set /A "Xright=%X%-1"
rem set /A "Yright1=%Y%+1"
rem set /A "Yright2=%Y%+3"
rem set /A "Yright3=%Y%+5"
rem set /A "Yright4=%Y%+7"
rem set /A "Yright5=%Y%+9"
rem set /A "Yright6=%Y%+11"
rem set /A "Yright7=%Y%+13"
rem set /A "Yright8=%Y%+14"
rem Call ButtonHeight0 %Xright% %Yright1% f0 "                       " X _Button_Boxes _Button_Hover
rem Call ButtonHeight0 %Xright% %Yright2% f0 "                       " X _Button_Boxes _Button_Hover
rem Call ButtonHeight0 %Xright% %Yright3% f0 "                       " X _Button_Boxes _Button_Hover
rem Call ButtonHeight0 %Xright% %Yright4% f0 "                       " X _Button_Boxes _Button_Hover
rem Call ButtonHeight0 %Xright% %Yright5% f0 "                       " X _Button_Boxes _Button_Hover
rem Call ButtonHeight0 %Xright% %Yright6% f0 "                       " X _Button_Boxes _Button_Hover
rem Call ButtonHeight0 %Xright% %Yright7% f0 "                       " X _Button_Boxes _Button_Hover
rem Call ButtonHeight0 %Xright% %Yright8% f0 "                       " X _Button_Boxes _Button_Hover

call list %X% %Y% %THEMEcolor% "View               >" " " "Sort by            >" " " "Refresh" "____________________" " " "New                > " "____________________" " " "Display Settings" " " "Personalize" "____________________" " " "Open in Terminal"
IF %ERRORLEVEL%==0 goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 goto :RIGHTCLICKDESKTOP.VIEW
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
IF %ERRORLEVEL%==3 goto :RIGHTCLICKDESKTOP.SORT
IF %ERRORLEVEL%==4 goto :DESKTOP.EXE
IF %ERRORLEVEL%==5 goto :DESKTOP.EXE 
IF %ERRORLEVEL%==6 goto :DESKTOP.EXE
IF %ERRORLEVEL%==7 goto :DESKTOP.EXE
IF %ERRORLEVEL%==8 goto :RIGHTCLICKDESKTOP.NEW
IF %ERRORLEVEL%==9 goto :DESKTOP.EXE
IF %ERRORLEVEL%==10 goto :DESKTOP.EXE
IF %ERRORLEVEL%==11 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=SYSTEM.DISPLAY &goto :SETTINGS.EXE
IF %ERRORLEVEL%==12 goto :DESKTOP.EXE
IF %ERRORLEVEL%==13 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=PERSONALIZATION &goto :SETTINGS.EXE
IF %ERRORLEVEL%==14 goto :DESKTOP.EXE
IF %ERRORLEVEL%==15 goto :DESKTOP.EXE
IF %ERRORLEVEL%==16 goto :TERMINAL.EXE
goto :RIGHTCLICKDESKTOP.EXE


:RIGHTCLICKDESKTOP.VIEW
set /A "Xright=%X%+28"
call list %Xright% %Y% %THEMEcolor% "Large Icons" "Medium Icons" "Small Icons" "___________________" " " "Show Desktop Icons"
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
IF %ERRORLEVEL%==3 goto :DESKTOP.EXE
IF %ERRORLEVEL%==4 goto :DESKTOP.EXE
IF %ERRORLEVEL%==5 goto :DESKTOP.EXE
IF %ERRORLEVEL%==6 goto :DESKTOP.EXE
goto :RIGHTCLICKDESKTOP.VIEW


:RIGHTCLICKDESKTOP.SORT
set /A "Xright=%X%+28"
set /A "Yright=%Y%+3"
call list %Xright% %Yright% %THEMEcolor% "Name" "Size"
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
goto :RIGHTCLICKDESKTOP.VIEW


:RIGHTCLICKDESKTOP.NEW
set /A "Xright=%X%+28"
set /A "Yright=%Y%+8"
call list %Xright% %Yright% %THEMEcolor% "Shortcut" " " "___________________" " " "Not available: Folder"
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
IF %ERRORLEVEL%==3 goto :DESKTOP.EXE
IF %ERRORLEVEL%==4 goto :DESKTOP.EXE
IF %ERRORLEVEL%==5 goto :DESKTOP.EXE
goto :RIGHTCLICKDESKTOP.VIEW









:RIGHTCLICKTASKBAR.EXE
set M=0
set Y-taskbar=50

rem  Rightclicktaskbar can't be seen from past the desktop
IF %X% GTR 192 set X=192

call list %X% %Y-taskbar% %THEMEcolor% "Task Manager" "________________" " " "Taskbar Settings"


IF %ERRORLEVEL%==0 goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 goto :TASKMGR.EXE
IF %ERRORLEVEL%==2 goto :RIGHTCLICKTASKBAR.EXE
IF %ERRORLEVEL%==3 goto :RIGHTCLICKTASKBAR.EXE
IF %ERRORLEVEL%==4 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=PERSONALIZATION.TASKBAR &goto :SETTINGS.EXE
goto :RIGHTCLICKTASKBAR.EXE






:RIGHTCLICKSTARTMENU.EXE
set M=0
set Y-taskbar=52

rem  Rightclicktaskbar can't be seen from past the desktop
IF %X% GTR 192 set X=192

call list 85 28 %THEMEcolor% "Installed Apps" " " "Power Options" " " "System" " " "NIFS Management" " " "WinBatchX Management" " " "Terminal" " " "Task Manager" " " "Settings" " " "File Explorer" " " "Search" " " "Run" "_____________________" " " "Shut down" " " "Desktop"


IF %ERRORLEVEL%==0 goto rem :SETTINGS.APPS.INSTALLED
IF %ERRORLEVEL%==1 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=SYSTEM.POWER &goto :SETTINGS.EXE
IF %ERRORLEVEL%==3 rem error
IF %ERRORLEVEL%==5 goto :SETTINGS.SYSTEM.ABOUT
IF %ERRORLEVEL%==7 goto :DESKTOP.EXE
IF %ERRORLEVEL%==9 goto :DESKTOP.EXE
IF %ERRORLEVEL%==11 goto :TERMINAL.EXE
IF %ERRORLEVEL%==13 goto :TASKMGR.EXE
IF %ERRORLEVEL%==15 goto :SETTINGS.EXE
IF %ERRORLEVEL%==17 goto :EXPLORER.EXE
IF %ERRORLEVEL%==19 goto :SEARCH.EXE
IF %ERRORLEVEL%==21 goto :DESKTOP.EXE
IF %ERRORLEVEL%==24 goto :SHUTDOWN.EXE
IF %ERRORLEVEL%==26 goto :DESKTOP.EXE

goto :RIGHTCLICKSTARTMENU.EXE





:TASKBAROVERFLOW.EXE
set M=0
call :TASKBARICON.EXE
set _TASKBAROVERFLOW=1

call list 117 53 %THEMEcolor% "Disabled"

IF %ERRORLEVEL%==0 set TASKBAROVERFLOW=0 &goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 set TASKBAROVERFLOW=0 &goto :DESKTOP.EXE
goto :TASKBAROVERFLOW.EXE
































:SHUTDOWN.EXE
cls
PIXELDRAW /refresh 00
call ButtonHeight0 96 25 0f "Shutting Down" X _Button_Boxes _Button_Hover

timeout /T 3 > nul


set START-STATUS=0
rem write a new data-system.bat file
(
  echo SET START-STATUS=%START-STATUS%
  echo SET FLAG-RECOVERYRESTART=%FLAG-RECOVERYRESTART%
  echo SET HIBERNATE-STATUS=%HIBERNATE-STATUS%
  echo SET RESTART-STATUS=%RESTART-STATUS%
) > data-system.bat

exit
goto :SHUTDOWN.EXE











:RESTART.EXE
cls
PIXELDRAW /refresh 00
call ButtonHeight0 98 25 0f "Restarting" X _Button_Boxes _Button_Hover

timeout /T 5 > nul


set START-STATUS=0
set RESTART-STATUS=1
rem write a new data-system.bat file
(
  echo SET START-STATUS=%START-STATUS%
  echo SET FLAG-RECOVERYRESTART=%FLAG-RECOVERYRESTART%
  echo SET HIBERNATE-STATUS=%HIBERNATE-STATUS%
  echo SET RESTART-STATUS=%RESTART-STATUS%
) > data-system.bat

start kernelreboot reboot
goto :SHUTDOWN.EXE


rem cd ..
rem call WinBatchX.bat
rem exit



















































































































rem  WinBatchX Applications 
rem  These applications created are under the Unlicense license.


rem  These are in order
rem  1. Notepad
rem  2. Paint
rem  3. Settings
rem  4. Edge
rem  5. File Explorer
rem  6. Security
rem  7. Calculator
rem  8. Calendar
rem  9. Clock
rem  10. Task Manager
rem  11. Photos
rem  LAST. Terminal


rem  Coming soon! Was still in development when these were revisied for release.
rem  12. Get help
rem  13. Store
rem  14. Snipping Tool
rem  15. Sticky Notes









rem  Notepad App

:NOTEPAD.EXE
set _APP.EXE=1

IF %_NOTEPAD.EXE%==1 goto :NOTEPAD.LOOP
set _ACTIVEAPPLABEL=notepad.exe
set _ACTIVEAPPIMAGE=notepad
SET _ACTIVEAPPTITLE=Notepad


set _NOTEPAD.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 notepad.light.bmp
 
call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul

rem  call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


:NOTEPAD.LOOP

call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 25 12 8 notepad.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

call insertphoto 1452 38 115 UI.setting.bmp


CALL ButtonHeight0 8 0 f0 "Notepad Beta" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 65 1490 65 /c 0


CALL ButtonHeight0 1 2 f8 "File    Edit    View" X _Button_Boxes _Button_Hover
rem  For saving paint (later, in the works)-- test: nircmd savescreenshot "shot.png" 50 50 300 200

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
rem  PIXELDRAW /refresh 00

set _ACTIVEAPPLABEL=notepad.exe

call ButtonHeight0 1 5 f0 "Start Typing... (type 'exit' to exit)                 " X _Button_Boxes _Button_Hover

call ButtonHeight0 1 7 f0 " " X _Button_Boxes _Button_Hover

set /p notepadkey1=
IF %notepadkey1%==exit goto :DESKTOP.EXE

call ButtonHeight0 1 7 f0 " " X _Button_Boxes _Button_Hover

set /p file=Enter a file name: 
call ButtonHeight0 1 7 f0 " " X _Button_Boxes _Button_Hover

set /p extension=Enter a file extension: 

(
  echo %notepadkey1%
) > ../%file%.%extension%

call ButtonHeight0 1 5 fa "File Saved. It is in the main folder (the folder behind the system folder)" X _Button_Boxes _Button_Hover
timeout /T 5 > nul
call :CLEARCACHE.EXE
goto :DESKTOP.EXE


































rem  Paint App

:PAINT.EXE
set _APP.EXE=1

IF %_PAINT.EXE%==1 goto :PAINT.LOOP
set _ACTIVEAPPLABEL=paint.exe
set _ACTIVEAPPIMAGE=paint
SET _ACTIVEAPPTITLE=Paint


set _PAINT.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 paint.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul

rem  call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


rem  PIXELDRAW /refresh 00

:PAINT.LOOP
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 25 12 8 paint.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

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

call insertphoto 50 150 120 blankloadapp.white.bmp

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=paint.exe

goto :KERNEL.EXE






















































rem  Settings App

:SETTINGS.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=settings.exe
set _ACTIVEAPPIMAGE=settings
SET "_ACTIVEAPPTITLE=Settings Beta"
IF %_SETTINGS.EXE%==1 goto :SETTINGS.LOOP



set _SETTINGS.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 Settings.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul

:SETTINGS.LOOP
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0
PIXELDRAW /dl /p 0 35 1490 35 /c 0

rem  Theres no icon in the settings app
rem  call insertphoto 25 12 8 settings.bmp
call insertphoto 25 12 110 ui.left.bmp
call insertphoto 1450 9 110 WindowedButtons.bmp
CALL ButtonHeight0 8 0 f3 "Settings" X _Button_Boxes _Button_Hover

rem  Load left app stuff here
call insertphoto 20 60 30 profile-icon.bmp
CALL ButtonHeight0 15 4 f3 "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 15 6 f0 "Local Account" X _Button_Boxes _Button_Hover

rem Load icons first!
call insertphoto 20 180 150 settings-system-icon.bmp
call insertphoto 20 220 150 settings-personalization-icon.bmp
call insertphoto 20 260 150 settings-apps-icon.bmp
call insertphoto 20 300 150 settings-account-icon.bmp
call insertphoto 20 340 150 settings-timelanguage-icon.bmp
call insertphoto 20 385 150 settings-accessibility-icon.bmp
call insertphoto 20 425 150 settings-security-icon.bmp
call insertphoto 20 470 150 settings-update-icon.bmp

rem Then, load names
CALL ButtonHeight0 9 12 f3 "System" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 15 f3 "Personalization" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 18 f3 "Apps" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 21 f3 "Accounts" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 24 f3 "Time & Lauguage" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 27 f3 "Accessibility" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 30 f3 "Privacy & Security" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 9 33 f3 "WinBatchX Update" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 0 53 f3 "WinBatchX Settings App v18final" X _Button_Boxes _Button_Hover

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=settings.exe

IF %_SETTINGS.SECTION%==SYSTEM goto :SETTINGS.SYSTEM

IF %_SETTINGS.SECTION%==SYSTEM.DISPLAY goto :SETTINGS.SYSTEM.DISPLAY
IF %_SETTINGS.SECTION%==SYSTEM.SOUND goto :SETTINGS.SYSTEM.SOUND
IF %_SETTINGS.SECTION%==SYSTEM.NOTIFICATION goto :SETTINGS.SYSTEM.NOTIFICATION
IF %_SETTINGS.SECTION%==SYSTEM.POWER goto :SETTINGS.SYSTEM.POWER
IF %_SETTINGS.SECTION%==SYSTEM.STORAGE goto :SETTINGS.SYSTEM.STORAGE
IF %_SETTINGS.SECTION%==SYSTEM.MULTITASKING goto :SETTINGS.SYSTEM.MULTITASKING
IF %_SETTINGS.SECTION%==SYSTEM.TROUBLESHOOT goto :SETTINGS.SYSTEM.TROUBLESHOOT
IF %_SETTINGS.SECTION%==SYSTEM.RECOVERY goto :SETTINGS.SYSTEM.RECOVERY
IF %_SETTINGS.SECTION%==SYSTEM.CLIPBOARD goto :SETTINGS.SYSTEM.CLIPBOARD
IF %_SETTINGS.SECTION%==SYSTEM.ABOUT goto :SETTINGS.SYSTEM.ABOUT

IF %_SETTINGS.SECTION%==PERSONALIZATION goto :SETTINGS.PERSONALIZATION

IF %_SETTINGS.SECTION%==PERSONALIZATION.TASKBAR goto :SETTINGS.PERSONALIZATION.TASKBAR

IF %_SETTINGS.SECTION%==APPS goto :SETTINGS.APPS

IF %_SETTINGS.SECTION%==ACCOUNTS goto :SETTINGS.ACCOUNTS

IF %_SETTINGS.SECTION%==TIMELANGUAGE goto :SETTINGS.TIMELANGUAGE

IF %_SETTINGS.SECTION%==ACCESSIBILITY goto :SETTINGS.ACCESSIBILITY

IF %_SETTINGS.SECTION%==PRIVACYSECURITY goto :SETTINGS.SYSTEM.PRIVACYSECURITY

IF %_SETTINGS.SECTION%==UPDATE goto :SETTINGS.UPDATE

goto :KERNEL.EXE





:SETTINGS.SYSTEM
set _SETTINGS.SECTION=SYSTEM

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f0 "System" X _Button_Boxes _Button_Hover


PIXELDRAW /dr 399 99 /rd 196 104 /c f
call insertphoto 400 100 10 "%BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp"

call insertphoto 1000 126 150 settings-update-icon.bmp

CALL ButtonHeight0 146 8 f3 "WinBatchX Update" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 146 9 f8 "%_WBXCore-updatemessage%" X _Button_Boxes _Button_Hover


CALL ButtonHeight0 85 6 f0 "%_HOSTNAME-winbatchx%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 85 8 f7 "Reset PC (Soon)" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 85 10 f7 "Rename" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 400 230 /rd 800 40 /c 7
CALL ButtonHeight0 65 16 f3 "Display" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 17 f3 "Zoom Size, image display, system responsiveness" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 273 /rd 800 40 /c 7
CALL ButtonHeight0 65 19 f3 "Sound" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 20 f3 "Volume, troubleshooting" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 316 /rd 800 40 /c 7
CALL ButtonHeight0 65 22 f3 "Notifications" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 23 f3 "Alerts from your apps and pc" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 359 /rd 800 40 /c 7
CALL ButtonHeight0 65 25 f8 "Focus" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 26 f8 "Notifications, user rules" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 402 /rd 800 40 /c 7
CALL ButtonHeight0 65 28 f3 "Power" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 29 f3 "Startup settings, Shutdown, Services" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 445 /rd 800 40 /c 7
CALL ButtonHeight0 65 31 f3 "Storage" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 32 f3 "Manage filesystem" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 488 /rd 800 40 /c 7
CALL ButtonHeight0 65 34 f3 "Single/Multi Window Settings" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 35 f3 "Side-to-side apps, full apps, windowed apps, desktops" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 531 /rd 800 40 /c 7
CALL ButtonHeight0 65 37 f3 "Troubleshoot" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 38 f3 "Fix problems" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 574 /rd 800 40 /c 7
CALL ButtonHeight0 65 40 f3 "Recovery" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 41 f3 "Advanced Startup, Recovery Enviroment" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 617 /rd 800 40 /c 7
CALL ButtonHeight0 65 43 f3 "Clipboard" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 44 f3 "Copy, Cut, Paste, Clear, History" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 660 /rd 800 40 /c 7
CALL ButtonHeight0 65 46 f3 "About" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 47 f3 "Device infomation, winbatchx and windows version" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE










:SETTINGS.SYSTEM.DISPLAY
set _SETTINGS.SECTION=SYSTEM.DISPLAY

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Display" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 450 124 /rd 500 20 /c 7
CALL ButtonHeight0 65 8 f0 "These settings apply only to the command line display." X _Button_Boxes _Button_Hover
CALL ButtonHeight0 122 8 3f " Ok " X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 180 /rd 800 40 /c 7
CALL ButtonHeight0 65 12 f3 "Animation Effects" X _Button_Boxes _Button_Hover
CALL ButtonBorder 159 13 f3 "Off (Disabled)" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 13 f0 "Try clearing up other apps on your Windows PC to see possible changes." X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 230 /rd 800 40 /c 7
CALL ButtonHeight0 65 16 f3 "Display Resolution" X _Button_Boxes _Button_Hover
CALL ButtonBorder 150 17 f3 "1920x1080 (recommended)" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 17 f8 "Scale of WinBatchX based on your screen resolution" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE








:SETTINGS.SYSTEM.SOUND
set _SETTINGS.SECTION=SYSTEM.SOUND

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Sound" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f3 "Volume" X _Button_Boxes _Button_Hover
CALL ButtonBorder 130 11 f3 "               Unavailable                " X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 11 f0 "This feature is unavailable on WinBatchX 18." X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 205 /rd 800 120 /c 7
CALL ButtonHeight0 65 14 f8 "Sounds enabled:" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 15 f7 "Toggle these on or off" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 17 f8 "Windows Sound on startup" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 19 f8 "Notification Sounds" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 21 f8 "User account control sounds" X _Button_Boxes _Button_Hover

CALL ButtonBorder 65 40 f0 "For more audio/sound settings, open Windows Settings to configure them." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE






:SETTINGS.SYSTEM.NOTIFICATION
set _SETTINGS.SECTION=SYSTEM.NOTIFICATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Notifications" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f3 "Notifications" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 11 f3 "Updates from external apps on WinBatchX" X _Button_Boxes _Button_Hover
CALL ButtonBorder 170 11 f0 "Yes" X _Button_Boxes _Button_Hover


PIXELDRAW /dr 450 205 /rd 800 40 /c 7
CALL ButtonHeight0 65 14 f3 "Do Not Disturb" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 15 f3 "Notifications will go to the notification center" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 161 15 f8 "Not available" X _Button_Boxes _Button_Hover


PIXELDRAW /dr 450 255 /rd 800 320 /c 7
CALL ButtonHeight0 65 18 f3 "Notifications from apps or scripts" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 19 f0 "Based on all current or past app senders" X _Button_Boxes _Button_Hover

CALL ButtonBorder 160 19 f0 "Not available" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE







:SETTINGS.SYSTEM.POWER
set _SETTINGS.SECTION=SYSTEM.POWER

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Power" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f3 "Startup" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 11 f0 "WinBatchX 18 does not have a recovery environment." X _Button_Boxes _Button_Hover
CALL ButtonBorder 160 11 f0 "0 seconds" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE





:SETTINGS.SYSTEM.STORAGE
set _SETTINGS.SECTION=SYSTEM.STORAGE

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Storage" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f3 "WinBatchX storage is not available yet." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE



:SETTINGS.SYSTEM.MULTITASKING
set _SETTINGS.SECTION=SYSTEM.MULTITASKING

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Window Settings" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f3 "Windowed Mode on all apps is not set up in this build of WinBatchX." X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 11 f8 "It is still in beta." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE







:SETTINGS.SYSTEM.TROUBLESHOOT
set _SETTINGS.SECTION=SYSTEM.TROUBLESHOOT

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Troubleshoot" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f3 "Troubleshooting is not available on alpha builds of WinBatchX right now. Report a bug," X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 11 f3 "or upgrade to the next build to see more changes or fixes." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE





:SETTINGS.SYSTEM.RECOVERY
set _SETTINGS.SECTION=SYSTEM.RECOVERY

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Recovery" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f8 "Restart to the WinBatchX recovery enviroment" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 11 f8 "Unavailable" X _Button_Boxes _Button_Hover
CALL ButtonBorder 160 11 f8 "Get Started" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 205 /rd 800 40 /c 7
CALL ButtonHeight0 65 14 f3 "Reset your WinBatchX Computer" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 15 f8 "Unavailable" X _Button_Boxes _Button_Hover
rem CALL ButtonHeight0 65 15 f8 "Before trying this option, try troubleshooting the issue" X _Button_Boxes _Button_Hover
CALL ButtonBorder 160 14 f8 "Reset WinBatchX" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE







:SETTINGS.SYSTEM.CLIPBOARD
set _SETTINGS.SECTION=SYSTEM.CLIPBOARD


rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   Clipboard" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL ButtonHeight0 65 10 f3 "Clipboard is not available on WinBatchX 18." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE



:SETTINGS.SYSTEM.ABOUT
set _SETTINGS.SECTION=SYSTEM.ABOUT

:: Find the Windows Version

For /f "tokens=1,2 delims=." %%A in ('ver') do (
	For /f "tokens=4" %%C in ("%%A") do (
		Set _Ver=%%C.%%B
	)
)

If /i "%_Ver%" == "4.0" (Set _winver-winbatchx=NT 4.0)
If /i "%_Ver%" == "5.1" (Set _winver-winbatchx=XP)
If /i "%_Ver%" == "6.0" (Set _winver-winbatchx=Vista)
If /i "%_Ver%" == "6.1" (Set _winver-winbatchx=7)
If /i "%_Ver%" == "6.2" (Set _winver-winbatchx=8)
If /i "%_Ver%" == "6.3" (Set _winver-winbatchx=8.1)
If /i "%_Ver%" == "10.0" (Set _winver-winbatchx=10/11)

If /i "%_winver-winbatchx%" == "" (Set _winver-winbatchx=Unknown)

:: architecture of os
IF Not Defined ProgramFiles(x86) (Set _Type=x86) ELSE (Set _Type=x64)



rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

PIXELDRAW /dr 450 95 /rd 800 40 /c 7
CALL ButtonHeight0 55 4 f3 "System" 61 4 f0 "   >   About" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 6 f0 "%_HOSTNAME-winbatchx%" 166 6 f3 "Rename PC" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 140 /rd 800 120 /c 7
CALL ButtonHeight0 65 10 f3 "Windows Infomation" 170 10 f8 "Copy" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 12 f0 "Windows" 80 12 f8 "%_winver-winbatchx%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 13 f0 "Architecture" 80 13 f8 "%_Type%" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 15 f8 "The infomation above may not be accurate." X _Button_Boxes _Button_Hover



PIXELDRAW /dr 450 265 /rd 800 90 /c 7

call insertphoto 460 280 25 ui.wbxicon.bmp

CALL ButtonHeight0 75 20 f0 "WinBatchX" 100 20 f8 "%_version% Version 2305" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 75 21 f0 "Build " 100 21 f8 "%_build%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 75 22 f0 "Kernel Version" 100 22 f8 "%_quantum-ver%" X _Button_Boxes _Button_Hover





rem Bug check to prevent wrong errors at next startup of the settings page
rem also part of privacy of a computer

set _Ver=0.0
set _Type=x00
set _winver-winbatchx=0

goto :KERNEL.EXE















:SETTINGS.PERSONALIZATION
set _SETTINGS.SECTION=PERSONALIZATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp

CALL ButtonHeight0 55 4 f0 "Personalization" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 399 99 /rd 386 242 /c 0
call insertphoto 400 100 20 "%BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp"

CALL ButtonHeight0 112 6 f0 "Select a theme to apply" X _Button_Boxes _Button_Hover
	
CALL ButtonBorder 125 14 f8 "Not available." X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 400 385 /rd 800 40 /c 7
CALL ButtonHeight0 65 27 f8 "Background" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 28 f8 "Default Image, Solid color" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 428 /rd 800 40 /c 7
CALL ButtonHeight0 65 30 f3 "Color" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 31 f3 "Accent color, transparency effects, light/dark theme" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 471 /rd 800 40 /c 7
CALL ButtonHeight0 65 33 f3 "Themes" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 34 f3 "Create, manage" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 514 /rd 800 40 /c 7
CALL ButtonHeight0 65 36 f3 "Lock screen" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 37 f3 "Default image, app Notifications" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 557 /rd 800 40 /c 7
CALL ButtonHeight0 65 39 f8 "Touch Keyboard" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 40 f8 "Themes, size, " X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 600 /rd 800 40 /c 7
CALL ButtonHeight0 65 42 f8 "Start" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 43 f8 "Pinned, Recomended, Folders" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 643 /rd 800 40 /c 7
CALL ButtonHeight0 65 45 f3 "Taskbar" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 46 f3 "Taskbar alignment, hide/show taskbar" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE




:SETTINGS.PERSONALIZATION.TASKBAR
set _SETTINGS.SECTION=PERSONALIZATION.TASKBAR

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp 

CALL ButtonHeight0 55 4 f3 "Personalization" 70 4 f0 "   >   Taskbar" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 140 /rd 800 180 /c 7
CALL ButtonHeight0 65 10 f3 "Taskbar Items" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 11 f8 "Show certain icons on the taskbar" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 13 fc "The settings below are not available yet on WinBatchX." X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 14 f7 "Search" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 16 f7 "Task View" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 18 f7 "Widgets" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 20 f7 "Taskbar Overflow" X _Button_Boxes _Button_Hover

IF %_TASKBAR.ALIGNMENT%==0 CALL ButtonBorder 120 24 f3 "Center" X _Button_Boxes _Button_Hover
IF %_TASKBAR.ALIGNMENT%==1 CALL ButtonBorder 120 24 f3 "Left" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 330 /rd 800 40 /c 7
CALL ButtonHeight0 65 23 f3 "Taskbar Alignment" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 24 f8 "Toggle the button on the right." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE













:SETTINGS.APPS
set _SETTINGS.SECTION=APPS

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp

CALL ButtonHeight0 55 4 f0 "Apps" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 6 f8 "Installed Apps" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 7 f8 "Manage apps on WinBatchX" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 9 f8 "Advanced App Settings" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 10 f8 "Choose where apps are coming fom, uninstall updates" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 12 f8 "Default apps" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 13 f8 "Default app opening for files" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 15 f8 "Startup" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 16 f8 "Apps auto-start when you start WinBatchX" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE











:SETTINGS.ACCOUNTS
set _SETTINGS.SECTION=ACCOUNTS

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp

CALL ButtonHeight0 55 4 f0 "Accounts" X _Button_Boxes _Button_Hover

call insertphoto 400 115 20 profile-icon.bmp

CALL ButtonHeight0 65 8 f0 "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 9 f0 "Local Account" X _Button_Boxes _Button_Hover


CALL ButtonHeight0 55 15 f0 "Account Settings" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 245 /rd 800 40 /c 7
CALL ButtonHeight0 65 17 f3 "Your info" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 18 f3 "Change username, profile photo" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 288 /rd 800 40 /c 7
CALL ButtonHeight0 65 20 f3 "Sign-in Options" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 21 f3 "Change password" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 331 /rd 800 40 /c 7
CALL ButtonHeight0 65 23 f7 "Other users" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 24 f7 "Currently disabled" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE


:SETTINGS.ACCOUNTS.PROFILE
set _SETTINGS.SECTION=ACCOUNTS.PROFILE

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp

CALL ButtonHeight0 55 4 f3 "Accounts" 63 4 f0 "   >   Profile photo" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 8 f0 "%_USERNAME-WINBATCHX%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 9 f0 "Local Account" X _Button_Boxes _Button_Hover


CALL ButtonHeight0 65 15 f0 "Edit your profile photo" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 17 f0 "Edit using paint" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 18 f7 "Use paint to edit your profile photo" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 65 20 f0 "Manually edit your photo" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 21 f0 "Use your favorite paint app and edit 'profile-icon.bmp' inside /NI/BMP/. " X _Button_Boxes _Button_Hover
goto :KERNEL.EXE

:SETTINGS.ACCOUNTS.SIGNIN
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN

rem  THIS IS A POP-UP
rem  Clear the center of the accounts
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

goto :KERNEL.EXE

:SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN.CHANGEPASSWORD
rem  THIS IS A POP-UP
rem  Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 0

rem shouldnt be this long
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

rem Set cursor for typing
BatBOX /g 94 30 /d ""
set /p _WBX_PASSWORD=

(
  echo SET _WBX_USERNAME=%_WBX_USERNAME%
  echo SET _WBX_PASSWORD=%_WBX_PASSWORD%
) > data-user.bat

:SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE
rem  THIS IS A POP-UP
rem  Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 0

rem shouldnt be this long
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


goto :KERNEL.EXE


:SETTINGS.TIMELANGUAGE
set _SETTINGS.SECTION=TIMELANGUAGE

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp
CALL ButtonHeight0 55 4 f0 "Time & Language" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 55 10 f0 "%_WBX-TASKBAR-TIME%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 55 11 f0 "%_WBX-TASKBAR-DATE%" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 55 15 f0 "To change your time settings, go to Windows Settings." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE


:SETTINGS.ACCESSIBILITY
set _SETTINGS.SECTION=ACCESSIBILITY

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp
CALL ButtonHeight0 55 4 f0 "Accessibility" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 55 7 f3 "Accessibility will not be a main feature on WinBatchX 18." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE


:SETTINGS.PRIVACYSECURITY
set _SETTINGS.SECTION=PRIVACYSECURITY

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp
CALL ButtonHeight0 55 4 f0 "Privacy & Security" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE



:SETTINGS.UPDATE
set _SETTINGS.SECTION=UPDATE

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.light.bmp 
call insertphoto 380 210 110 blankloadapp.light.bmp

call insertphoto 400 100 110 settings.ui.update.bmp

CALL ButtonHeight0 55 4 f0 "WinBatchX Update" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 70 7 f0 "%_WBXCore-updatemessage%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 70 8 f0 "%_WBX-OS% %_version%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 70 9 f0 "Version 2305" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 70 10 f0 "OS Build %_build%" X _Button_Boxes _Button_Hover
call insertphoto 1270 125 40 UI.buttonblue.bmp
call insertphoto 1269 126 41 UI.buttonblue.bmp
call insertphoto 1271 129 40 UI.buttonblue.bmp
call insertphoto 1300 125 40 UI.buttonblue.bmp
call insertphoto 1299 126 41 UI.buttonblue.bmp
call insertphoto 1301 129 40 UI.buttonblue.bmp
CALL ButtonHeight0 180 9 3f "Check for updates" X _Button_Boxes _Button_Hover

rem  note stuff
call insertphoto 380 600 100 UI.buttonwhite.bmp
call insertphoto 379 601 100 UI.buttonwhite.bmp
call insertphoto 381 604 100 UI.buttonwhite.bmp

call insertphoto 580 600 100 UI.buttonwhite.bmp
call insertphoto 579 601 100 UI.buttonwhite.bmp
call insertphoto 581 604 100 UI.buttonwhite.bmp

call insertphoto 780 600 100 UI.buttonwhite.bmp
call insertphoto 779 601 100 UI.buttonwhite.bmp
call insertphoto 781 604 100 UI.buttonwhite.bmp

call insertphoto 980 600 100 UI.buttonwhite.bmp
call insertphoto 979 601 100 UI.buttonwhite.bmp
call insertphoto 981 604 100 UI.buttonwhite.bmp

CALL ButtonHeight0 60 43 f0 "Notice:" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 65 45 f0 "%_WBXCore-updatealert%" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE













:SETTINGS.UPDATE.WGET
rem  Update Manager - wget

rem  Set Variable for _link= (Universal)
SET "_Link=https://github.com/bes-ptah/WinBatchX/archive/refs/heads/main.zip"

rem  download it quietly using -q. It won't spam the command line.
wget -q "%_Link%" > nul

rem  Unpack it (This is why Windows 1809 and higher is recommended, or use tar yourself)
tar -xf main.zip

rem  Enter the directory (always this name)
cd winbatchx-main

rem  Enter the update directory
cd update

rem  CALL the program
call update.bat

rem  Then remove the old files.
del update.bat

cd ..

rem  delete it without a request from user. (or we screw the display screen up)
rmdir update > nul

del LICENSE
del README.md
del _config.yml

rem  go back into the system directory.
cd ..

rem  remove the folder itself.
rmdir winbatchx-main > nul

rem  delete the zip file downloaded so the next download update wont crash the cmd line.
del main.zip

goto :SETTINGS.UPDATE













rem ALWAYS call this program, never go into it!
:SETTINGS.REWRITECONFIG



(
  echo SET COLORMODE=%COLORMODE%

  echo SET NOTIFICATIONS=%NOTIFICATIONS%
  echo SET DO-NOT-DISTURB=%DO-NOT-DISTURB%

  echo SET VOLUME=%VOLUME%

  echo SET ACCENT.COLOR=%ACCENT.COLOR%
  echo SET THEME=%THEME%
  echo SET HIGHLIGHT.WINDOW.BORDERS=%HIGHLIGHT.WINDOW.BORDERS%
  echo SET _TASKBAR.ALIGNMENT=%_TASKBAR.ALIGNMENT%

  echo SET BACKGROUND.LOCKSCREEN.IMAGE=%BACKGROUND.LOCKSCREEN.IMAGE%
  echo SET BACKGROUND.LOCKSCREEN.SIZE=%BACKGROUND.LOCKSCREEN.SIZE%
  echo SET BACKGROUND.DESKTOP.IMAGE=%BACKGROUND.DESKTOP.IMAGE%
  echo SET BACKGROUND.DESKTOP.SIZE=%BACKGROUND.DESKTOP.SIZE%

  echo SET _HOSTNAME-winbatchx=%_HOSTNAME-winbatchx%
) > data-settings.bat
exit /b






















rem  WinBatchX Edge - There is no official license yet. 
rem  Respectivly is 'outbranched' from Microsoft Edge.
:EDGE.EXE
set _APP.EXE=1
IF %_EDGE.EXE%==1 goto :EDGE.LOOP
set _ACTIVEAPPLABEL=edge
set _ACTIVEAPPIMAGE=edge
SET _ACTIVEAPPTITLE=Edge


set _EDGE.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 edge.light.bmp
 
call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul

rem  call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


:EDGE.LOOP

call insertphoto 0 38 147 blankloadapp.white.bmp &call insertphoto 0 38 147 blankloadapp.white.bmp &call insertphoto 7 38 147 blankloadapp.white.bmp &call insertphoto 7 38 147 blankloadapp.white.bmp



call insertphoto 40 15 41 UI.buttonbrightwhite.bmp
call insertphoto 60 15 41 UI.buttonbrightwhite.bmp
call insertphoto 80 15 41 UI.buttonbrightwhite.bmp
call insertphoto 100 15 41 UI.buttonbrightwhite.bmp
call insertphoto 120 15 41 UI.buttonbrightwhite.bmp

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=edge.exe

call insertphoto 1450 9 110 WindowedButtons.bmp


Call insertphoto 16 20 120 edge.tabs.bmp

Call insertphoto 57 20 120 edge.newtab.bmp
Call insertphoto 180 26 120 UI.context.close.explorer.bmp
CALL ButtonHeight0 10 1 f0 "New Tab" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 100 1490 100 /c 0




PIXELDRAW /dl /p 0 100 1490 100 /c 7

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE



goto :KERNEL.EXE






































rem  Explorer App
rem  Based on Windows Insider Build 22621
:EXPLORER.EXE
set _APP.EXE=1
rem  If you want to replicate the actual app of explorer (Win32)

IF %_EXPLORER.EXE%==1 goto :EXPLORER.LOOP
set _ACTIVEAPPLABEL=explorer.exe
set _ACTIVEAPPIMAGE=explorer
SET "_ACTIVEAPPTITLE=File Explorer"

set _EXPLORER.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 explorer.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul
:EXPLORER.LOOP
call insertphoto 0 35 147 blankloadapp.white.bmp &call insertphoto 0 35 147 blankloadapp.white.bmp &call insertphoto 7 35 147 blankloadapp.white.bmp &call insertphoto 7 35 147 blankloadapp.white.bmp



call insertphoto 20 15 41 UI.buttonbrightwhite.bmp
call insertphoto 40 15 41 UI.buttonbrightwhite.bmp
call insertphoto 60 15 41 UI.buttonbrightwhite.bmp
call insertphoto 80 15 41 UI.buttonbrightwhite.bmp
call insertphoto 100 15 41 UI.buttonbrightwhite.bmp

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=explorer.exe

call insertphoto 1450 9 110 WindowedButtons.bmp

Call insertphoto 35 20 80 explorer.home.bmp
Call insertphoto 180 26 120 UI.context.close.explorer.bmp
CALL ButtonHeight0 8 1 f0 "Home" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 100 1490 100 /c 0

rem  Command Bar
Call insertphoto 20 67 120 explorer.top.new.bmp
CALL ButtonHeight0 5 4 f0 "New" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 90 60 90 90 /c 7
Call insertphoto 120 67 120 explorer.top.cut.bmp
Call insertphoto 180 67 120 explorer.top.copy.bmp
Call insertphoto 240 67 120 explorer.top.paste.bmp
Call insertphoto 300 67 120 explorer.top.rename.bmp
Call insertphoto 360 67 120 explorer.top.share.bmp
Call insertphoto 420 67 120 explorer.top.trash.bmp

PIXELDRAW /dl /p 480 60 480 90 /c 7

CALL ButtonHeight0 72 4 f0 "Sort" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 82 4 f0 "View" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 630 60 630 90 /c 7

Call insertphoto 640 55 100 taskbar-overflow-off-light.bmp





PIXELDRAW /dl /p 0 100 1490 100 /c 7

rem  Navigation Pane
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

rem  Displayed Part

CALL ButtonHeight0 44 10 f0 "File Explorer is not updated for WinBatchX 18. Upgrade to WinBatchX 18.1 for a updated file explorer and other released apps." X _Button_Boxes _Button_Hover
rem CALL ButtonHeight0 44 10 f0 "Quick Access" X _Button_Boxes _Button_Hover

 rem Call insertphoto 320 180 100 explorer.desktop.folder.bmp
 rem CALL ButtonHeight0 45 16 f0 "Desktop" X _Button_Boxes _Button_Hover

 rem Call insertphoto 420 180 100 explorer.documents.folder.bmp
 rem CALL ButtonHeight0 59 16 f0 "Documents" X _Button_Boxes _Button_Hover

 rem Call insertphoto 520 180 100 explorer.downloads.folder.bmp
 rem CALL ButtonHeight0 73 16 f0 "Downloads" X _Button_Boxes _Button_Hover

 rem Call insertphoto 620 180 100 explorer.music.folder.bmp
 rem CALL ButtonHeight0 89 16 f0 "Music" X _Button_Boxes _Button_Hover

 rem Call insertphoto 720 180 100 explorer.pictures.folder.bmp
 rem CALL ButtonHeight0 102 16 f0 "Pictures" X _Button_Boxes _Button_Hover

 rem Call insertphoto 820 180 100 explorer.videos.folder.bmp
 rem CALL ButtonHeight0 117 16 f0 "Videos" X _Button_Boxes _Button_Hover

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

goto :KERNEL.EXE
goto :EXPLORER.EXE











































rem  Security

:SECURITY.EXE
set _APP.EXE=1
IF %_SECURITY.EXE%==1 goto :SECURITY.LOOP
set _ACTIVEAPPLABEL=security.exe
set _ACTIVEAPPIMAGE=security
SET "_ACTIVEAPPTITLE=WinBatchX Security"

set _SECURITY.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 security.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul
:SECURITY.LOOP
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=security.exe
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

rem  call insertphoto 1452 38 115 UI.setting.bmp

Call insertphoto 20 10 8 security.light.bmp
CALL ButtonHeight0 6 0 f0 "WinBatchX Security" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c 0

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
CALL ButtonHeight0 14 3 f3 "Scan your system to make sure your computer is up-to-date with alerts." X _Button_Boxes _Button_Hover
CALL ButtonHeight0 14 4 f0 "This uses the Windows Security Command Line tool to scan WinBatchX." X _Button_Boxes _Button_Hover

call insertphoto 100 100 40 UI.buttonblue.bmp
call insertphoto 99 101 41 UI.buttonblue.bmp
call insertphoto 101 104 40 UI.buttonblue.bmp

CALL ButtonHeight0 14 7 3f "Scan Now" X _Button_Boxes _Button_Hover


CALL ButtonHeight0 14 12 f0 "Windows will tell you if your operating system has encountered an issue." X _Button_Boxes _Button_Hover



goto :KERNEL.EXE
goto :SECURITY.LOOP




:SECURITY.SCAN
rem  9.1.
set "CD_winbatchx=%CD%"
cd C:\Program Files\Windows Defender
MpCmdRun -Scan -ScanType 3 -File %CD_winbatchx% > nul
rem  The 3rd flag tells it as a custom scan.
rem  Change directory back to WBX-17.
cd "%CD_winbatchx%"
exit /b































rem  Calculator App (Rev2)
rem  THIS IS A GUI APP that is in development!

:CALCULATOR.EXE

rem App declare variables
set _APP.EXE=1

set _ACTIVEAPPLABEL=calculator.exe
set _ACTIVEAPPIMAGE=calculator
SET _ACTIVEAPPTITLE=Calculator

call :COMPOSE.EXE
call :GUICOMPOSE.EXE
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

set M=0
set WIN2=0


:CALCULATOR.GUI
set M=0
IF %I%==m IF %M% EQU 0 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 200 IF %Y% LSS 50 set WIN2=n

rem changed it for a possible bug fix!
call :COMPOSE.EXE

rem  THIS DOES NOT REALLY WORK YET
rem  CALL BOX %_CALCULATOR.X% %_CALCULATOR.Y% 35 66 - - f0  1

CALL BOX %_CALCULATOR.X% %_CALCULATOR.Y% 15 36 - - f3  1

rem Window Title
set /A _CALCULATOR.X1="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y1="%_CALCULATOR.Y%-1"



set /A _CALCULATOR.X2="%_CALCULATOR.X%-20"
set /A _CALCULATOR.Y2="%_CALCULATOR.Y%-5"

set /A _CALCULATOR.X3="%_CALCULATOR.X%+20"
set /A _CALCULATOR.Y3="%_CALCULATOR.Y%+5"



rem ???? the end of the desk?
set /A _CALCULATOR.X4="%_CALCULATOR.X%+35"
set /A _CALCULATOR.Y4="%_CALCULATOR.Y%+66"






rem Control button (Close only)
set /A _CALCULATOR.X5="%_CALCULATOR.X%+28"
set /A _CALCULATOR.Y5="%_CALCULATOR.Y%-1"

rem for Control Input
set /A _CALCULATOR.X5A="%_CALCULATOR.X%+24"
set /A _CALCULATOR.Y5A="%_CALCULATOR.Y%-3"

set /A _CALCULATOR.X5B="%_CALCULATOR.X%+32"
set /A _CALCULATOR.Y5B="%_CALCULATOR.Y%+4"





rem Show results on calculator
set /A _CALCULATOR.X6="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y6="%_CALCULATOR.Y%+1"

set /A _CALCULATOR.X6A="%_CALCULATOR.X%+12"
set /A _CALCULATOR.Y6A="%_CALCULATOR.Y%+1"


set /A _CALCULATOR.X7="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y7="%_CALCULATOR.Y%+2"

set /A _CALCULATOR.X8="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y8="%_CALCULATOR.Y%+3"

set /A _CALCULATOR.X9="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y9="%_CALCULATOR.Y%+4"






rem 1 2 3 4 5 6 7 8 9 + - = buttons
set /A _CALCULATOR.X10="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y10="%_CALCULATOR.Y%+7"

set /A _CALCULATOR.X11="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y11="%_CALCULATOR.Y%+9"

set /A _CALCULATOR.X12="%_CALCULATOR.X%+2"
set /A _CALCULATOR.Y12="%_CALCULATOR.Y%+11"





CALL ButtonHeight0 %_CALCULATOR.X1% %_CALCULATOR.Y1% f3 " Calculator " %_CALCULATOR.X5% %_CALCULATOR.Y5% f3 " X " X _Button_Boxes _Button_Hover


rem  SET "_CALCULATOR.DIGIT1=0"
rem  SET "_CALCULATOR.DIGIT2=0"
rem  SET "_CALCULATOR.OPERAT=+"


CALL ButtonHeight0 %_CALCULATOR.X6% %_CALCULATOR.Y6% f3 "Result:  " %_CALCULATOR.X6A% %_CALCULATOR.Y6A% f0 "%_CALCULATOR.FINAL%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 %_CALCULATOR.X7% %_CALCULATOR.Y7% f8 "X:  %_CALCULATOR.DIGIT1%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 %_CALCULATOR.X8% %_CALCULATOR.Y8% f8 "Y:  %_CALCULATOR.DIGIT2%" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 %_CALCULATOR.X9% %_CALCULATOR.Y9% f8 "Operator:  %_CALCULATOR.OPERAT%" X _Button_Boxes _Button_Hover


rem  CALL ButtonBorder %_CALCULATOR.X8% %_CALCULATOR.Y8% f0 " Ok " X _Button_Boxes _Button_Hover

CALL ButtonBorder %_CALCULATOR.X10% %_CALCULATOR.Y10% f8 "  7 |  8 |  9 |     -" X _Button_Boxes _Button_Hover
CALL ButtonBorder %_CALCULATOR.X11% %_CALCULATOR.Y11% f8 "  4 |  5 |  6 |     +" X _Button_Boxes _Button_Hover
CALL ButtonBorder %_CALCULATOR.X12% %_CALCULATOR.Y12% f8 "  1 |  2 |  3 |     =" X _Button_Boxes _Button_Hover




	rem test
	call insertphoto 118 224 100 UI.buttongray.bmp
	CALL ButtonHeight0 15 15 %THEMEcolor% "Test" X _Button_Boxes _Button_Hover

	call insertphoto 328 644 100 UI.buttongray.bmp
	CALL ButtonHeight0 45 45 %THEMEcolor% "Test" X _Button_Boxes _Button_Hover
	
	call insertphoto 72 132 100 UI.buttongray.bmp
	CALL ButtonHeight0 9 9 %THEMEcolor% "Test" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE







rem  Calendar App
rem  (The calculating day thing is imported from 16.0)


:CALENDAR.EXE
set _APP.EXE=1
IF %_CALENDAR.EXE%==1 goto :CALENDAR.LOOP
set _ACTIVEAPPLABEL=calendar.exe
set _ACTIVEAPPIMAGE=calendar
SET _ACTIVEAPPTITLE=Calendar

set _CALENDAR.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 calendar.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul
:CALENDAR.LOOP
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=calendar.exe
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

rem  call insertphoto 1452 38 115 UI.setting.bmp

Call insertphoto 20 10 8 calendar.light.bmp
CALL ButtonHeight0 6 0 f0 "Calendar - %year%" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c 0

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

rem  This is the orginial CALENDAR.EXE, in a graphical interface.
rem  With premission of the open-source license, we are allowed to use other pieces of code.
rem  This stil works in Windows 10/11!
rem  Most Author's comments are untouched.
rem  ========================================================================================


rem  Xp batch for generating calendars
rem  Chances look good for win 2000 and above(untested)
rem  By Judago, August 2009



rem  The current codepage is stored in variable %CodePage%,
rem  then changed to 850 to facilitate box drawing characters.....

SETLOCAL ENABLEDELAYEDEXPANSION

rem  The results are displayed below using substrings of each month's 
rem  variable.


rem  Edited portion of calendar




Call ButtonHeight0 12 10 f0 "January" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 12 f0 "%JAN:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 14 f0 "%JAN:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 16 f0 "%JAN:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 18 f0 "%JAN:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 20 f0 "%JAN:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 22 f0 "%JAN:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 42 10 f0 "February" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 12 f0 "%FEB:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 14 f0 "%FEB:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 16 f0 "%FEB:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 18 f0 "%FEB:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 20 f0 "%FEB:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 22 f0 "%FEB:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 72 10 f0 "March" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 12 f0 "%MAR:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 14 f0 "%MAR:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 16 f0 "%MAR:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 18 f0 "%MAR:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 20 f0 "%MAR:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 22 f0 "%MAR:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 102 10 f0 "April" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 12 f0 "%APR:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 14 f0 "%APR:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 16 f0 "%APR:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 18 f0 "%APR:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 20 f0 "%APR:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 22 f0 "%APR:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 132 10 f0 "May" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 12 f0 "%MAY:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 14 f0 "%MAY:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 16 f0 "%MAY:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 18 f0 "%MAY:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 20 f0 "%MAY:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 22 f0 "%MAY:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 162 10 f0 "June" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 12 f0 "%JUN:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 14 f0 "%JUN:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 16 f0 "%JUN:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 18 f0 "%JUN:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 20 f0 "%JUN:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 22 f0 "%JUN:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 12 30 f0 "July" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 32 f0 "%JUL:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 34 f0 "%JUL:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 36 f0 "%JUL:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 38 f0 "%JUL:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 40 f0 "%JUL:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 8 42 f0 "%JUL:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 42 30 f0 "August" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 32 f0 "%AUG:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 34 f0 "%AUG:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 36 f0 "%AUG:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 38 f0 "%AUG:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 40 f0 "%AUG:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 38 42 f0 "%AUG:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 72 30 f0 "September" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 32 f0 "%SEP:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 34 f0 "%SEP:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 36 f0 "%SEP:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 38 f0 "%SEP:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 40 f0 "%SEP:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 68 42 f0 "%SEP:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 102 30 f0 "October" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 32 f0 "%OCT:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 34 f0 "%OCT:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 36 f0 "%OCT:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 38 f0 "%OCT:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 40 f0 "%OCT:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 98 42 f0 "%OCT:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 132 30 f0 "November" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 32 f0 "%NOV:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 34 f0 "%NOV:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 36 f0 "%NOV:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 38 f0 "%NOV:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 40 f0 "%NOV:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 128 42 f0 "%NOV:~105%" X _Button_Boxes _Button_Hover

Call ButtonHeight0 162 30 f0 "December" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 32 f0 "%DEC:~0,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 34 f0 "%DEC:~21,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 36 f0 "%DEC:~42,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 38 f0 "%DEC:~63,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 40 f0 "%DEC:~84,20%" X _Button_Boxes _Button_Hover
Call ButtonHeight0 158 42 f0 "%DEC:~105%" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE
goto :CALENDAR.LOOP












:CLOCK.EXE
goto :DESKTOP.EXE

















rem  Task Manager App
:TASKMGR.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=taskmgr.exe
set _ACTIVEAPPIMAGE=taskmgr
SET _ACTIVEAPPTITLE=Task Manager
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

IF %_TASKMGR.EXE%==1 goto :TASKMGR.LOOP
set _ACTIVEAPPLABEL=taskmgr.exe
set _ACTIVEAPPIMAGE=taskmgr
SET _ACTIVEAPPTITLE=Task Manager

set _TASKMGR.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 taskmgr.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul
:TASKMGR.LOOP
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=taskmgr.exe
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

rem  call insertphoto 1452 38 115 UI.setting.bmp


Call insertphoto 60 10 8 taskmgr.light.bmp
CALL ButtonHeight0 12 0 f0 "Task Manager" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 57 35 1490 35 /c 7


rem  Navigation Pane
PIXELDRAW /dl /p 55 37 55 783 /c 7
Call insertphoto 20 15 100 UI.lines.bmp
Call insertphoto 20 45 100 ui.appbox.bmp
Call insertphoto 19 75 100 ui.performance.bmp
Call insertphoto 20 755 100 ui.setting.bmp



rem Search on top:
call insertphoto 487 10 100 taskbar-searchbar-top.bmp
CALL ButtonHeight0 72 0 f8 "Search" X _Button_Boxes _Button_Hover

rem  Outline for Search Bar:

rem  Top
PIXELDRAW /dl /p 482 5 1012 5 /c 7

rem  Left
PIXELDRAW /dl /p 478 7 478 30 /c 7

rem  Right
PIXELDRAW /dl /p 1014 7 1014 30 /c 7

rem  Bottom
PIXELDRAW /dl /p 482 31 1012 31 /c 7


rem  Main Window
CALL ButtonHeight0 10 3 f0 "Processes (7)" X _Button_Boxes _Button_Hover
CALL ButtonHeight0 90 3 f0 "Executables listed below are not in order." X _Button_Boxes _Button_Hover

CALL ButtonHeight0 193 3 f0 "+ Start New Task" X _Button_Boxes _Button_Hover
PIXELDRAW /dl /p 55 85 1491 85 /c 7

CALL ButtonHeight0 10 7 f0 " Name                                          Status             Size" X _Button_Boxes _Button_Hover
PIXELDRAW /dl /p 60 125 1485 125 /c 7
CALL ButtonHeight0 10 9 f0 "Apps (1)" X _Button_Boxes _Button_Hover


rem Task Manager - running! :D
CALL insertphoto 95 165 8 %_ACTIVEAPPIMAGE%.light.bmp
rem Current running app (use the 'api' rather than saying task manager)
CALL ButtonHeight0 16 11 f0 "%_ACTIVEAPPTITLE%" X _Button_Boxes _Button_Hover
rem say the app is currently running, 'active' being shown on the screen
CALL ButtonHeight0 57 11 f0 "Active" X _Button_Boxes _Button_Hover
rem now variables
CALL ButtonHeight0 77 11 f0 "2G" X _Button_Boxes _Button_Hover


call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

goto :KERNEL.EXE







rem  Photos App
:PHOTOS.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=photos.exe
set _ACTIVEAPPIMAGE=photos
SET _ACTIVEAPPTITLE=Photos
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

IF %_PHOTOS.EXE%==1 goto :PHOTOS.LOOP
set _ACTIVEAPPLABEL=photos.exe
set _ACTIVEAPPIMAGE=photos
SET _ACTIVEAPPTITLE=Photos

set _PHOTOS.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 photos.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul
:PHOTOS.LOOP
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=photos.exe
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp



Call insertphoto 20 10 8 photos.light.bmp
CALL ButtonHeight0 6 0 f0 "Photos" X _Button_Boxes _Button_Hover




call insertphoto 445 10 100 taskbar-searchbar-top.bmp
CALL ButtonHeight0 66 0 f8 "Search" X _Button_Boxes _Button_Hover

rem  Outline for Search Bar:

rem  Top
PIXELDRAW /dl /p 440 5 1050 5 /c 8

rem  Left
PIXELDRAW /dl /p 438 7 438 30 /c 8

rem  Right
PIXELDRAW /dl /p 1052 7 1052 30 /c 8

rem  Bottom
PIXELDRAW /dl /p 441 31 1052 31 /c 8



Call insertphoto 1210 8 100 ui.photos.import.bmp
CALL ButtonHeight0 175 0 f8 "Import" X _Button_Boxes _Button_Hover


call insertphoto 1330 10 115 UI.setting.bmp




PIXELDRAW /dl /p 0 35 1490 35 /c 0


rem  Navigation Pane
PIXELDRAW /dl /p 55 35 55 783 /c 0
Call insertphoto 20 45 100 UI.lines.bmp
Call insertphoto 18 75 100 ui.photos.all.bmp

rem  Main Window
Call insertphoto 80 50 130 ui.photos.all.bmp
CALL ButtonHeight0 15 3 f0 "All Photos" X _Button_Boxes _Button_Hover

CALL ButtonHeight0 15 7 f0 "To show a photo, click on the top-right button named 'Import'. " X _Button_Boxes _Button_Hover

CALL ButtonHeight0 15 9 f0 "%_PHOTOS.SOURCE%" X _Button_Boxes _Button_Hover

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

goto :KERNEL.EXE




:PHOTOS.SAVEFILEDIALOG
Set _PHOTOS.SOURCE=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('savefiledialog "WinBatchX Photos: Find image.." "" "Images (*.*)"') Do (
	Set _PHOTOS.SOURCE=%%A
	title WinBatchX 18 [Source: %%A ]
)
exit /b




































































rem Terminal App
:TERMINAL.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=terminal.exe
set _ACTIVEAPPIMAGE=terminal
SET _ACTIVEAPPTITLE=Terminal
call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

IF %_TERMINAL.EXE%==1 goto :TERMINAL.LOOP
set _ACTIVEAPPLABEL=terminal.exe
set _ACTIVEAPPIMAGE=terminal
SET _ACTIVEAPPTITLE=Terminal

set _TERMINAL.EXE=1
call insertphoto 0 0 147 blankloadapp.light.bmp &call insertphoto 0 35 147 blankloadapp.light.bmp &call insertphoto 7 0 147 blankloadapp.light.bmp &call insertphoto 7 35 147 blankloadapp.light.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 terminal.light.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

timeout /NOBREAK /T 0 > nul
:TERMINAL.LOOP
cls
rem for command line to focus back into the desktop
CALL ButtonHeight0 8 -1 0f "Terminal" 17 -1 03 "BETA" X _Button_Boxes _Button_Hover

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE
set _ACTIVEAPPLABEL=terminal.exe
call insertphoto 0 0 147 blankloadapp.dark.bmp &call insertphoto 0 35 147 blankloadapp.dark.bmp &call insertphoto 7 0 147 blankloadapp.dark.bmp &call insertphoto 7 35 147 blankloadapp.dark.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c f

call insertphoto 25 12 8 Terminal.dark.bmp

call insertphoto 1450 9 110 WindowedButtons.bmp



CALL ButtonHeight0 8 0 0f "Terminal" 17 0 03 "BETA" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c f

call :TASKBARDRAW.EXE
call :TASKBARICON.EXE

CALL ButtonBorder 90 30 0f "Open Terminal" X _Button_Boxes _Button_Hover


CALL ButtonHeight0 60 25 0f "You will not be able to use any of the GUI features while opening Terminal." X _Button_Boxes _Button_Hover
CALL ButtonHeight0 60 26 0f "To exit, type 'exit' during the login process, OR type exit on the prompt." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE











:TERMINAL.START
CALL ButtonHeight0 0 2 0f "Opening WinBatchX Terminal" X _Button_Boxes _Button_Hover
echo.
echo WinBatchX %_version%, Build %_build%
echo Kernel Version %_quantum-ver%
echo.

:TERMINAL.LOGIN
echo User premission required.
echo If you want to exit, type 'exit' now.
echo User: %_WBX_USERNAME%
echo.
SET _PASS=0
SET /p _PASS=Password:
IF %_WBX_PASSWORD%==%_PASS% goto :TERMINAL.SYSTEMLOOP
IF %_PASS%==exit GOTO :TERMINAL.LOOP
IF %_PASS%==0 GOTO :TERMINAL.LOGIN
goto :TERMINAL.LOGIN

:TERMINAL.SYSTEMLOOP
set WBXprompt=0
set /p WBXprompt=%_WBX_USERNAME%@%_HOSTNAME-winbatchx%: 
IF %WBXprompt%==0 goto :TERMINAL.SYSTEMLOOP
IF %WBXprompt%==cls goto :TERMINAL.CLS
IF %WBXprompt%==help goto :TERMINAL.HELP
IF %WBXprompt%==exit goto :TERMINAL.EXIT
IF %WBXprompt%==ver goto :TERMINAL.VER
IF %WBXprompt%==wbxinstall goto :TERMINAL.WBXINSTALL

echo.
echo The command '%WBXprompt%' does not exist.
echo.
goto :TERMINAL.SYSTEMLOOP


rem list of commands here
	:TERMINAL.CLS
	cls
	goto :TERMINAL.SYSTEMLOOP
	
	:TERMINAL.EXIT
	echo.
	echo.
	echo The terminal app is finished. WinBatchX will try to start the desktop again.
	pause
	goto :TERMINAL.LOOP


	:TERMINAL.HELP 
	echo.
	echo Help commands-
	echo Please note the capilization of the commands.
	echo.
	echo cls
	echo exit
	echo help
	echo ver
	echo wbxinstall
	echo.
	goto :TERMINAL.SYSTEMLOOP


	:TERMINAL.VER 
	echo.
	echo WinBatchX %_version%, Build %_build%
	echo Kernel Version %_quantum-ver%
	echo.
	goto :TERMINAL.SYSTEMLOOP

	:TERMINAL.WBXINSTALL 
	echo.
	echo This feature is not enabled or is imcomplete.
	echo.
	goto :TERMINAL.SYSTEMLOOP



















rem  END OF WINBATCHX CODE
rem  WinBatchX.

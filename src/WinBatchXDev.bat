rem =====================================
rem WinBatchX Desktop 2023 Beta (Rev0.5)
rem Flag: BetaBuild
rem Not released to the Alpha Channel yet
rem Quantum Kernel 0.95 - Build 10000
rem =====================================
rem The unlicense below is used for this 
rem "batch" software. Also in LICENSE.txt.
rem =====================================
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
If /i "%~1" == "start" (goto :BOOT.EXE)
If /i "%~1" == "startre" (call WINBATCHX/RECOVERY.BAT)


rem Find the Windows Version.
rem We're only supporting Windows 10, Version 22H2 and Windows 11 from here.
rem If you are using Windows 7 there are some features that are disabled.

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
If /i "%_Ver%" == "10.0" (Set _winver-winbatchx=10)

If /i "%_winver-winbatchx%" == "" (Set _winver-winbatchx=Unknown)

:: architecture of os
IF Not Defined ProgramFiles(x86) (Set _Type=x86) ELSE (Set _Type=x64)


:bootWBX.exe
start WinBatchX start
endlocal
exit /b


:BOOT.EXE
cd WINBATCHX
tar -xf SystemFiles.zip


rem Set up command line accessibility for users
rem who accidently 'outphoto' the imaged os.
setlocal EnableExtensions EnableDelayedExpansion
mode 213,60
mode 1000,1000
chcp 437 > nul

cls
PIXELDRAW /refresh 0f







rem ==================================
rem Boot Load WinBatchX Desktop 2023:
rem More simpler now, as most are in
rem services, yay!
rem ==================================
rem 1. Set General Variables
rem 2. Start WBXFS - filesystem
rem 3. Start up 'OS Critical' Services
rem 4. Start all other apps/services
rem ==================================
timeout /T 0 /NOBREAK > nul
cls
PIXELDRAW /refresh 0f
timeout /T 2 /NOBREAK > nul
call insertphoto 0 0 85 bootimage.bmp
echo ??

rem 1
rem Set General Variables 
SET "_WBX-OS=WinBatchX Desktop"
SET "_quantum-ver=0.95"
SET "_version=2023 RCTB 1"
SET "_build=10000.50"

rem RCTB = Release Candinate Test Build

rem Includes all techinal build info
SET "_sysbuild=23.0.10000.100"

rem CALL Services/TIMEDATE.bat
rem CALL Services/PERSONALIZATION.bat
rem CALL Services/SECURITY.bat
rem CALL Services/WBXUPDATE.bat



rem THIS IS IMPORTED!!


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




 
set "_WBX-TASKBAR-TIME=%_WBX-TIMETEMP1%:%_WBX-TIMETEMP2% %_WBX-TIMETEMP3%"
set "_WBX-TASKBAR-DATE=%_WBX-DATETEMP1%-%_WBX-DATETEMP2%-%DATE:~-7,2%"

rem reset temporary variables
SET _WBX-DATETEMP1=0
SET _WBX-DATETEMP2=0
SET _WBX-TIMETEMP1=0
SET _WBX-TIMETEMP2=0
SET _WBX-TIMETEMP3=0



rem 11
rem Set Default Customizations Right Now
SET THEME=light
SET COLORMODE=0
SET ACCENT.COLOR=3
SET HIGHLIGHT.WINDOW.BORDERS=b
SET VOLUME=100
SET NOTIFICATIONS=0
SET DO-NOT-DISTURB=0

rem Default Set for background (lock screen)
SET BACKGROUND.LOCKSCREEN.IMAGE=background-lock
SET BACKGROUND.LOCKSCREEN.SIZE=77
SET _TASKBAR.ALIGNMENT=0

rem Default Set for background (desktop)
SET BACKGROUND.DESKTOP.IMAGE=background
SET BACKGROUND.DESKTOP.SIZE=100
SET _HOSTNAME-winbatchx=COMPUTER-0



rem 12
rem  Updated in WinBatchX Desktop 2023.
rem  Where'd it go? The file moved to the SystemData folder

call SystemData/data-system.bat

IF %START-STATUS%==1 Call Text 82 42 0f "Make sure you shut down your computer correctly. You did not shut down properly last time." X _Button_Boxes _Button_Hover
set START-STATUS=1
set RESTART-STATUS=0


rem write a new data-system.bat file
(
  echo SET START-STATUS=%START-STATUS%
  echo SET FLAG-RECOVERYRESTART=%FLAG-RECOVERYRESTART%
  echo SET HIBERNATE-STATUS=%HIBERNATE-STATUS%
  echo SET RESTART-STATUS=%RESTART-STATUS%
) > SystemData/data-system.bat



		rem 13
rem call data-settings.bat
call SystemData/data-settings.bat
rem Any conversions from data-settings.bat
IF %THEME%==light set THEMEcolor=f0
IF %THEME%==dark set THEMEcolor=0f

IF %THEME%==light set lightTHEMEcolor=f8
IF %THEME%==dark set lightTHEMEcolor=08



		rem 14
call SystemData/data-user.bat


rem 17
rem  Using current updated update service.
rem  This may not work on older versions (Windows 7/8)
rem  or newer versions (Windows 11 Dev).
set "CD_winbatchx=%CD%"
cd C:\Program Files\Windows Defender
MpCmdRun -Scan -ScanType 3 -File %CD_winbatchx% > nul
rem  The 3rd flag tells it as a custom scan.
rem  Change directory back to WBX-17.
cd "%CD_winbatchx%"

rem WBXUPDATE

rem  Wget - Retrieves data ONLY for WinBatchX Update.
rem  Call the 'WGET' service instad of the 'WBXUPDATE' service.
rem  (Also a copy of the WBXUPDATE service inside this WinBatchX build)

rem  Download it quietly with -q.
wget -q "https://github.com/bes-ptah/WinBatchX/archive/refs/heads/main.zip" > nul

rem  Unpack it using tar.
tar -xf main.zip

rem  Enter the directory (always this name)
cd winbatchx-main

rem  Enter the update directory.
cd update

rem  Call the program!
call update.bat

rem  Then remove the old files without a request from user.
del update.bat > nul
cd ..
rmdir update > nul
del LICENSE
del README.md
del _config.yml

rem  Go back to the previous directory.
cd ..

rem  Remove the update folder
rmdir winbatchx-main > nul

rem  Also delete the downloaded compressed update file so the command line does not crash on the next update.
del main.zip






call insertphoto 0 0 85 blankSystemImage.bmp
timeout /T 0 /NOBREAK > nul
call Text 100 25 0f "Please Wait" X _Button_Boxes _Button_Hover
timeout /T 1 /NOBREAK > nul






rem testing:
rem call insertphoto 770 600 100 loading-dot.bmp
rem call insertphoto 770 600 100 loading-blank.bmp













:LOGIN.EXE
cls
PIXELDRAW /refresh 3f
call insertphoto 0 0 85 blankSystemImage.bmp
call Text 100 25 0f "Please Wait" X _Button_Boxes _Button_Hover
call Text 96 26 0f "Loading LOGIN.EXE" X _Button_Boxes _Button_Hover
timeout /T 1 /NOBREAK > nul
cls
PIXELDRAW /refresh 3f
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
set I=k
set M=0
set X=0
set Y=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('Batbox.exe /m') Do (
	rem for compitability purposes:
	Set I=m
	Set X=%%A
	Set Y=%%B
	Set M=%%C
	title %_WBX-OS% Build %_build% - Debug: [%%A] [%%B] [%%C] [%%D]
	)
IF %I%==m IF %M%==1 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 211 IF %Y% LSS 58 (
call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -10 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -20 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -35 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -40 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -50 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -100 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -150 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -350 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
timeout /T 0 /NOBREAK > nul
IF %_WBX_SETPASSWD%==0 GOTO :WELCOME.EXE
goto :LOGIN.USERFORM
)
goto :LOGIN.LOOP



:LOGIN.USERFORM
cls
PIXELDRAW /refresh 3f

rem _WBX_SETPASSWD:
rem 0 = Not set!
rem 1 = Password was set
rem IF %_WBX_SETPASSWD%==0 goto :WBX-LOGINLOAD.EXE

call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp

rem profile photo
call insertphoto 735 260 60 profile-icon.bmp


call Text 112 29 0f "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover
call Text 98 31 0f "                                 " X _Button_Boxes _Button_Hover
call Text 98 32 0f "                                 " X _Button_Boxes _Button_Hover
call Text 98 33 0f "                                 " X _Button_Boxes _Button_Hover


rem BORDER the Main Passowrd GUI
rem Top
PIXELDRAW /dl /p 702 449 930 449 /c 8
rem Left Side
PIXELDRAW /dl /p 700 449 700 493 /c 8
rem Right Side
PIXELDRAW /dl /p 932 449 932 493 /c 8
rem Bottom
PIXELDRAW /dl /p 702 493 930 493 /c b




call Text 196 54 0f "      " X _Button_Boxes _Button_Hover
call Text 196 55 0f "  (E) " X _Button_Boxes _Button_Hover
call Text 196 56 0f "      " X _Button_Boxes _Button_Hover

call Text 203 54 0f "      " X _Button_Boxes _Button_Hover
call Text 203 55 0f "  (P) " X _Button_Boxes _Button_Hover
call Text 203 56 0f "      " X _Button_Boxes _Button_Hover



BatBOX /g 102 33 /d ""

SET _PASS=0
SET /p _PASS=
IF %_WBX_PASSWORD%==%_PASS% GOTO :WELCOME.EXE


:LOGIN.INCORRECT
cls
PIXELDRAW /refresh 3f
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp


rem gui rounding for profile
rem we skipped the rounding for speed

rem profile photo
call insertphoto 740 260 60 profile-icon.bmp
call Text 112 29 0f "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover

call Text 96 32 0f "The username or password is incorrect." X _Button_Boxes _Button_Hover

call Text 196 54 0f "      " X _Button_Boxes _Button_Hover
call Text 196 55 0f "  (E) " X _Button_Boxes _Button_Hover
call Text 196 56 0f "      " X _Button_Boxes _Button_Hover

call Text 203 54 0f "      " X _Button_Boxes _Button_Hover
call Text 203 55 0f "  (P) " X _Button_Boxes _Button_Hover
call Text 203 56 0f "      " X _Button_Boxes _Button_Hover


call Text 108 35 0f "              " X _Button_Boxes _Button_Hover
call Text 108 36 0f "      Ok      " X _Button_Boxes _Button_Hover
call Text 108 37 0f "              " X _Button_Boxes _Button_Hover


:LOGIN.INCORRECT.LOOP
set I=k
set M=0
set X=0
set Y=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('Batbox.exe /m') Do (
	rem for compitability purposes:
	Set I=m
	Set X=%%A
	Set Y=%%B
	Set M=%%C
	title %_WBX-OS% Build %_build% - Debug: [%%A] [%%B] [%%C] [%%D]
	)
IF %I%==m IF %M%==1 IF %X% GTR 110 IF %Y% GTR 36 IF %X% LSS 124 IF %Y% LSS 38 goto :LOGIN.USERFORM
goto :LOGIN.INCORRECT.LOOP
goto :LOGIN.USERFORM




:WELCOME.EXE

cls
PIXELDRAW /refresh 3f

call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp


rem gui rounding for profile
rem we skipped the rounding for speed

rem profile photo
call insertphoto 740 260 60 profile-icon.bmp
call Text 112 29 0f "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover

call Text 111 32 0f "Welcome" X _Button_Boxes _Button_Hover

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
rem Default Variables Set for WinBatchX
SET _ACTIVEAPPLABEL=explorer.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=WinBatchX

rem Default Variables for windowed mode
SET _ACTIVEAPPDRAG=
SET _ACTIVEAPP.X=
SET _ACTIVEAPP.Y=

rem Default Variables for windowed mode
set _WBX-DESKTOP-1=0

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

SET _DESKTOP.EXE=0

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

set _APP.EXE=0
cls

call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

rem _WBXCore-update = (0 = up to date) (1 = not up to date) (2 = need to update, out of support) (3 = unknown error)
rem _WBXCore-updatemessage = (message for the latest release, or build)
rem _WBXCore-updatealert = (message for anything - major bug problems etc)

IF %_WBXCore-update%==2 CALL Text 155 45 fc "Update Required" 155 46 f0 "Your version is unsupported." X _Button_Boxes _Button_Hover
IF %_WBXCore-update%==1 CALL Text 155 45 f0 "Update Available" 155 46 f0 "A new update is ready." X _Button_Boxes _Button_Hover









































































































rem QKERNELVER SOFTWARE;
	rem These are only released to the public as QKERNELVER software;
	rem ===---===
	rem Release
	rem MinorRelease


rem PRERELEASE SOFTWARE;
	rem These are never released to the public but is available on github;
	rem ===---===
	rem Alpha
	rem EarlyRelease

	rem These are only released to the public as PRERELEASE software;
	rem ===---===
	rem Beta
	rem PreRelease
	rem ReleaseCanidnateTest
	rem ReleaseCanidate


rem RELEASE SOFTWARE;
	rem These are only released to the public as RELEASE software;
	rem ===---===
	rem Release
	rem Update Pack


rem SERVERRELEASE SOFTWARE;
	rem These are also only released to the public as SERVERRELEASE software;
	rem ===---===
	rem ServerReleaseCandidate
	rem ServerRelease
	rem ServerReleasePacks


rem QUANTUM KERNEL 1.0-RCT1 PRERELEASE SOFTWARE 
rem This software is based on the Unlicense License.

rem WINBATCHX 23.0 ARCHITECTURE;

rem *Note:  Executables that are inside WINBATCHX.BAT have a colon: like :DESKTOP.EXE. (The ':')
rem         Others are found in certain folders from the root file.

rem **Note: that all features are executed as an actual winbatchx app.

rem SYSTEM.EXE
rem | 
rem | - CORESCHEDULER.EXE
rem   | - SERVICES (They should be in the services folder or an actual, intergerated service on WinBatchX.bat)
rem     | - User Prefierences        - Services/PERSONALIZATION.BAT
rem     | - WinBatchX Security       - Services/SECURITY.BAT
rem     | - Time and Date Scheduler  - Services/TIMEDATE.BAT
rem     | - WinBatchX Update Service - Services/WBXUPDATE.BAT
rem   | - KERNEL.EXE
rem   | - BACKGROUND APP PROCESSES
rem | - DESKTOP                      - :DESKTOP.EXE
rem   |
rem   | - DESKTOP BACKGROUND COMPOSE - :DESKTOP.COMPOSE
rem   | - TASKBAR COMPOSE            - :DESKTOP.TASKBAR
rem   | - TASKBAR ICON               - :DESKTOP.ICON
rem   | - DESKTOP FILES              - :DESKTOP.LOOP
rem | - START MENU                   - :START.EXE
rem | - SEARCH FEATURE               - :SEARCH.EXE
rem | - TASK VIEW FEATURE            - :TASKVIEW.EXE
rem | - WIDGETS                      - :WIDGETS.EXE
rem | - ACTION CENTER                - :ACTIONCENTER.EXE
rem | - NOTIFICATION CENTER          - :NOTIFICATIONCENTER.EXE

rem | - FRAME EXECUTER DISPLAY       - :KERNEL.EXE
rem   | - START MENU
rem   | - START MENU RIGHT CLICK
rem   | - SEARCH
rem   | - SEARCH APP
rem   | - TASKVIEW
rem   | - TASKVIEW APP
rem   | - WIDGETS
rem   | - WIDGETS APP
rem   | - NOTIFICATION AREA ICONS
rem   | - ACTION CENTER
rem   | - ACTION CENTER RIGHT CLICK
rem   | - NOTIFICATION CENTER
rem   | - NOTIFICATION CENTER RIGHT CLICK
rem   | - TASKBAR RIGHT CLICK
rem   | - DESKTOP RIGHT CLICK



rem QUANTUM KERNEL 'MANUAL':











rem SETTING UP DISPLAYS

rem Part 1:
rem Use some X-value and Y-value to show the limit of the screen, then maxinize the app
rem responsiveness to it's app border by dividing buttons, centering them, or
rem falling back to 16.0 technology (IF it's a 16.0 app)
rem.
rem DO NOT EVER USE PERCISE LOCATION ON THE DISPLAY UNLESS YOU KNOW WHAT
rem YOU ARE DOING!!!
rem.
rem It will bug the screen off if the user does decide to resize the desktop to it's
rem resolution in the Settings App- specifically System > Display.

rem Part 2:
rem IF you decide to turn off the legacy prompt in the command line settings (right-click
rem it and hit properties, and a checkmark box will say 'Use legacy console' in the Options
rem tab), MOST of the desktop is accessible even without the actual icons, wallpaper, and
rem apps. You can't see any of the apps or use features as we're working on it.
rem This type of fallback MAY ONLY BE TOGGLED in future kernel builds as it slows down
rem the UI.




rem COMMAND LINE DISPLAYS

rem IN WINBATCHX, there are 2 ways of x-values and y-values when calculating up
rem the kernel: the 'Xcmd' and 'Ycmd', but there are the 'Xdraw' and 'Ydraw' values, too.
rem.
rem By DEFAULT and FALLBACK, we use Xcmd and Ycmd, simply X and Y values, to 
rem calculate MOST positions on the command line.
rem.
rem Xdraw and Ydraw are newer the Xcmd and Ycmd, but they draw more percisely on the
rem screen. All the features in WinBatchX 23 (Start Menu, Search, Widgets) almost always
rem use Xdraw and Ydraw.
rem.
rem Xdraw, Ydraw, Xcmd and Ycmd are just X and Y values on the command line.
rem They are also in different places; the NORMAL rule is usually:
rem.
rem Xcmd*7=Xdraw
rem Ycmd*14=Ydraw
rem.
rem THIS IS AN API CALL! call it by :DESKTOP.DISPLAY






rem MOUSE CURSOR
rem There are 2 mouse cursors available in WBX: input.exe and batbox.exe.
rem The differences between the 2 text-like mouse-tracking cursors are:
rem. 
rem Input.exe (input /f) does a LIVE track of your mouse cursor IF the cursor
rem (mouse cursor not text cursor) IS on the COMMAND LINE.
rem.
rem Batbox.exe (batbox.exe /m) does a CLICK-ONLY track of your mouse cursor (again)
rem IF the cursor IS on the COMMAND LINE.
rem.
rem The 2 inputs CANNOT track where the mouse is OUTSIDE the COMMAND LINE.
rem Also the 2 inputs use the Xcmd and Ycmd values only. Check Command Line Displays
rem for more information.




:SYSTEM.EXE
cls
PIXELDRAW /refresh 3f
timeout /T 2 /NOBREAK > nul
goto :DESKTOP.EXE
goto :SYSTEM.EXE


rem Everything that is in DESKTOP.EXE is sepreated for your own API! These change at their own risk. Try a actual release for the actual variables, and pull the version being used for each build before running your app.
:DESKTOP.EXE

rem its better if you dont customize your background with the developer builds right now.
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp


call SystemData/data-variables.bat
call :DESKTOP.CACHECLEAR
call :DESKTOP.COMPOSE
call :DESKTOP.TASKBAR
call :DESKTOP.ICON
call :DESKTOP.LOOP

rem alter this for desktop to clear other app icons
SET _ACTIVEAPPLABEL=desktop.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=WinBatchX

goto :KERNEL.EXE


:DESKTOP.COMPOSE
call insertphoto 0 0 77 background1.%THEME%.bmp
call insertphoto 740 0 77 background2.%THEME%.bmp
call insertphoto 0 462 77 background3.%THEME%.bmp
call insertphoto 740 462 77 background4.%THEME%.bmp

rem Build Previews

rem  This is kept here for accessibility

CALL Text 180 53 %THEMEcolor% "                             " X _Button_Boxes _Button_Hover
CALL Text 180 54 %THEMEcolor% "                             " X _Button_Boxes _Button_Hover

CALL Text 180 53 %THEMEcolor% "%_WBX-OS% %_version%" X _Button_Boxes _Button_Hover
CALL Text 183 54 %THEMEcolor% "Build %_build% - Q%_quantum-ver%" X _Button_Boxes _Button_Hover

exit /b 


:DESKTOP.CACHECLEAR
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
exit /b


:DESKTOP.TASKBAR
CALL Text -1 55 %THEMEcolor% "                                                                                                                                                                                                                  " X _Button_Boxes _Button_Hover
CALL Text -1 56 %THEMEcolor% "                                                                                                                                                                                                                  " X _Button_Boxes _Button_Hover
CALL Text -1 57 %THEMEcolor% "                                                                                                                                                                                                                  " X _Button_Boxes _Button_Hover
rem CALL Text -1 58 %THEMEcolor% "                                                                                                                                                                                                                  " X _Button_Boxes _Button_Hover


call insertphoto 30 785 1000 taskbar.%THEME%.bmp
call insertphoto 0 785 1000 taskbar.%THEME%.bmp

call insertphoto 30 784 1000 taskbar.%THEME%.bmp
call insertphoto 0 784 1000 taskbar.%THEME%.bmp

rem PIXELDRAW /dr 0 0 /rd 1490 836 /c 8
rem PIXELDRAW /dr 0 784 /rd 1490 52 /c 8
exit /b





:DESKTOP.ICON
rem _TASKBAR.ALIGNMENT:
rem 0=center
rem 1=left

IF %_TASKBAR.ALIGNMENT%==0 (
	IF %_START.EXE%==0 call insertphoto 635 790 105 taskbar-start-off-%THEME%.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 690 792 140 taskbar-search-off-%THEME%.bmp
	IF %_TASKVIEW.EXE%==0 call insertphoto 740 786 105 taskbar-taskview-off-%THEME%.bmp
	IF %_WIDGETS.EXE%==0 call insertphoto 15 790 105 taskbar-dashboard-off-%THEME%.bmp
		rem Widgets
		CALL Text 7 56 %lightTHEMEcolor% "WinBatchX Update:" X _Button_Boxes _Button_Hover
		CALL Text 7 57 %lightTHEMEcolor% "%_WBXCore-updatemessage%" X _Button_Boxes _Button_Hover
	IF %_APP.EXE%==0 call insertphoto 800 795 12 %_ACTIVEAPPIMAGE%.%THEME%.bmp
	IF %_APP.EXE%==1 call insertphoto 800 795 12 %_ACTIVEAPPIMAGE%.%THEME%.bmp
	IF %_TASKBAROVERFLOW.EXE%==0 call insertphoto 850 790 105 taskbar-overflow-off-%THEME%.bmp
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
	IF %_TASKBAROVERFLOW.EXE%==0 call insertphoto 280 790 105 taskbar-overflow-off-%THEME%.bmp
	IF %_ACTION.EXE%==0 call insertphoto 1368 788 95 taskbaricons-off-%THEME%.bmp
	IF %_NOTIFICATION.EXE%==0 call insertphoto 1405 791 95 timecenter-off-%THEME%.bmp
	rem =======
	IF %_START.EXE%==1 call insertphoto 15 786 105 taskbar-start-on-%THEME%.bmp
	IF %_SEARCH.EXE%==1 call insertphoto 62 789 95 taskbar-search-on-%THEME%.bmp
	IF %_TASKVIEW.EXE%==1 call insertphoto  790 95 taskbar-taskview-on-%THEME%.bmp
	IF %_WIDGETS.EXE%==1 call insertphoto 790 105 taskbar-dashboard-on-%THEME%.bmp
	IF %_TASKBAROVERFLOW.EXE%==1 call insertphoto 840 790 105 taskbar-overflow-on-%THEME%.bmp
	IF %_ACTION.EXE%==1 call insertphoto 1368 788 95 taskbaricons-on-%THEME%.bmp
	IF %_NOTIFICATION.EXE%==1 call insertphoto 1405 791 95 timecenter-on-%THEME%.bmp
)

rem draw time
CALL Text 201 56 %THEMEcolor% "%_WBX-TASKBAR-TIME%" 199 57 %THEMEcolor% "%_WBX-TASKBAR-DATE%" X _Button_Boxes _Button_Hover
exit /b


:DESKTOP.LOOP
call insertphoto 50 15 25 explorer.recyclebin.%THEME%.bmp
CALL Text 4 5 %THEMEcolor% "Recycle Bin" X _Button_Boxes _Button_Hover
PIXELDRAW /dr 49 14 /rd 67 67 /c 7
PIXELDRAW /dr 50 15 /rd 65 65 /c 7

call insertphoto 50 125 25 batchinstaller-%THEME%.bmp
CALL Text 8 13 %THEMEcolor% "Run" X _Button_Boxes _Button_Hover
PIXELDRAW /dr 49 124 /rd 67 67 /c 7
PIXELDRAW /dr 50 125 /rd 65 65 /c 7

exit /b








:KERNEL.EXE
set I=m
set Button=0
set M=0
set X=0
set Y=0

For /F "Delims=: Tokens=1,2,3" %%A in ('Batbox.exe /m') Do (
	set I=m
	
	set Button=%%C
	set M=%%C

	set X=%%A
	set Y=%%B
	title %_WBX-OS% %_version% - Build %_build% - Debug: [%%A] [%%B] [%%C] [%%D]
	)



rem Start Menu:
	IF %_START.EXE%==0 IF %Button%==1 IF %X% GTR 91 IF %Y% GTR 55 IF %X% LSS 96 IF %Y% LSS 59 goto :START.EXE

rem Context Menu for Start:
	IF %_START.EXE%==0 IF %Button%==2 IF %X% GTR 91 IF %Y% GTR 55 IF %X% LSS 96 IF %Y% LSS 59 goto :START.CONTEXTMENU
	rem In case it does not open 'in' start:
	IF %_START.EXE%==1 IF %Button%==2 IF %X% GTR 91 IF %Y% GTR 55 IF %X% LSS 96 IF %Y% LSS 59 goto :START.CONTEXTMENU

rem Close the Start Menu:
	IF %_START.EXE%==1 IF %Button%==1 IF %X% GTR 91 IF %Y% GTR 55 IF %X% LSS 96 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE
	IF %_START.EXE%==2 IF %Button%==2 IF %X% GTR 91 IF %Y% GTR 55 IF %X% LSS 96 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE


IF %_START.EXE%==1 (
	IF %Button%==1 IF %X% GTR 67 IF %Y% GTR 15 IF %X% LSS 77 IF %Y% LSS 20 goto :EDGE.EXE
	IF %Button%==1 IF %X% GTR 81 IF %Y% GTR 15 IF %X% LSS 92 IF %Y% LSS 20 goto :NOTEPAD.EXE
	IF %Button%==1 IF %X% GTR 94 IF %Y% GTR 15 IF %X% LSS 107 IF %Y% LSS 20 goto :EXPLORER.EXE
	IF %Button%==1 IF %X% GTR 109 IF %Y% GTR 15 IF %X% LSS 119 IF %Y% LSS 20 goto :SETTINGS.EXE
	IF %Button%==1 IF %X% GTR 123 IF %Y% GTR 15 IF %X% LSS 133 IF %Y% LSS 20 goto :SECURITY.EXE
	IF %Button%==1 IF %X% GTR 136 IF %Y% GTR 15 IF %X% LSS 147 IF %Y% LSS 20 goto :CALCULATOR.EXE
	
	IF %Button%==2 IF %X% GTR 67 IF %Y% GTR 15 IF %X% LSS 77 IF %Y% LSS 20 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 81 IF %Y% GTR 15 IF %X% LSS 92 IF %Y% LSS 20 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 94 IF %Y% GTR 15 IF %X% LSS 107 IF %Y% LSS 20 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 109 IF %Y% GTR 15 IF %X% LSS 119 IF %Y% LSS 20 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 123 IF %Y% GTR 15 IF %X% LSS 133 IF %Y% LSS 20 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 136 IF %Y% GTR 15 IF %X% LSS 147 IF %Y% LSS 20 goto :START.RIGHTCLICKAPP
	

	IF %Button%==1 IF %X% GTR 67 IF %Y% GTR 21 IF %X% LSS 77 IF %Y% LSS 26 goto :TERMINAL.EXE
	IF %Button%==1 IF %X% GTR 81 IF %Y% GTR 21 IF %X% LSS 92 IF %Y% LSS 26 goto :PHOTOS.EXE
	IF %Button%==1 IF %X% GTR 94 IF %Y% GTR 21 IF %X% LSS 107 IF %Y% LSS 26 goto :PAINT.EXE
	IF %Button%==1 IF %X% GTR 109 IF %Y% GTR 21 IF %X% LSS 119 IF %Y% LSS 26 goto :CALENDAR.EXE
	IF %Button%==1 IF %X% GTR 123 IF %Y% GTR 21 IF %X% LSS 133 IF %Y% LSS 26 goto :WINDOWEDTEST.APP
	IF %Button%==1 IF %X% GTR 136 IF %Y% GTR 21 IF %X% LSS 147 IF %Y% LSS 26 goto :TASKMGR.EXE

	IF %Button%==2 IF %X% GTR 67 IF %Y% GTR 21 IF %X% LSS 77 IF %Y% LSS 26 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 81 IF %Y% GTR 21 IF %X% LSS 92 IF %Y% LSS 26 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 94 IF %Y% GTR 21 IF %X% LSS 107 IF %Y% LSS 26 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 109 IF %Y% GTR 21 IF %X% LSS 119 IF %Y% LSS 26 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 123 IF %Y% GTR 21 IF %X% LSS 133 IF %Y% LSS 26 goto :START.RIGHTCLICKAPP
	IF %Button%==2 IF %X% GTR 136 IF %Y% GTR 21 IF %X% LSS 147 IF %Y% LSS 26 goto :START.RIGHTCLICKAPP

	rem Power
	IF %Button%==1 IF %X% GTR 139 IF %Y% GTR 51 IF %X% LSS 145 IF %Y% LSS 53 goto :START.POWER
)

rem Power
	IF %_START.EXE%==1 IF %Button%==1 IF %X% GTR 139 IF %Y% GTR 51 IF %X% LSS 145 IF %Y% LSS 53 goto :START.POWER


IF %_START.EXE%==2 (
	rem  Sign Out
	IF %_START.EXE%==2 IF %Button%==1 IF %X% GTR 137 IF %Y% GTR 44 IF %X% LSS 149 IF %Y% LSS 46 call :DESKTOP.CACHECLEAR &goto :LOGIN.EXE
	
	rem  Shut Down
	IF %_START.EXE%==2 IF %Button%==1 IF %X% GTR 137 IF %Y% GTR 46 IF %X% LSS 149 IF %Y% LSS 48 call :DESKTOP.CACHECLEAR &goto :SHUTDOWN.EXE
	
	rem  Restart
	IF %_START.EXE%==2 IF %Button%==1 IF %X% GTR 137 IF %Y% GTR 48 IF %X% LSS 149 IF %Y% LSS 50 call :DESKTOP.CACHECLEAR &goto :RESTART.EXE
	
	rem  Close
	IF %_START.EXE%==2 IF %Button%==1 IF %X% GTR 63 IF %Y% GTR 7 IF %X% LSS 152 IF %Y% LSS 55 call :DESKTOP.CACHECLEAR &goto :START.EXE
)



rem Search:
IF %_SEARCH.EXE%==0 IF %Button%==1 IF %X% GTR 98 IF %Y% GTR 56 IF %X% LSS 103 IF %Y% LSS 59 goto :SEARCH.EXE

	rem Close Search:
	IF %_SEARCH.EXE%==1 IF %Button%==1 IF %X% GTR 98 IF %Y% GTR 56 IF %X% LSS 103 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE


rem Task View:
IF %_TASKVIEW.EXE%==0 IF %Button%==1 IF %X% GTR 105 IF %Y% GTR 56 IF %X% LSS 111 IF %Y% LSS 59 goto :TASKVIEW.EXE
	
	rem Close Task View:
	IF %_TASKVIEW.EXE%==1 IF %Button%==1 IF %X% GTR 105 IF %Y% GTR 56 IF %X% LSS 111 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE






IF %_ACTIVEAPPTITLE%==WinBatchX IF %Button%==2 IF %X% Gtr 0 IF %X% Lss 200 IF %Y% Gtr 0 IF %Y% Lss 50 GOTO DESKTOP.EXE


rem Apps:
IF %_RUN.EXE%==1 IF %Button%==1 IF %X% GTR 47 IF %Y% GTR 44 IF %X% LSS 52 IF %Y% LSS 46 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE
goto :KERNEL.EXE






rem Start Menu Version 22.0.10000
:START.EXE

set _START.EXE=1
call :DESKTOP.ICON

rem  The least to make are sharp corners rounded (3px):
call insertphoto 444 100 600 blank.%THEME%.bmp

call insertphoto 448 96 592 blank.%THEME%.bmp
call insertphoto 448 112 592 blank.%THEME%.bmp


CALL Text 65 7 %lightTHEMEcolor% "                                                                                  " X _Button_Boxes _Button_Hover
CALL Text 65 8 %lightTHEMEcolor% "                                                                                  " X _Button_Boxes _Button_Hover
CALL Text 65 9 %lightTHEMEcolor% "                                                                                  " X _Button_Boxes _Button_Hover

rem First, Outline Start:
	rem Start Menu Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 448 96 1064 96 /c 7
	rem Left
	PIXELDRAW /dl /p 444 112 444 776 /c 7
	rem Right
	PIXELDRAW /dl /p 1068 112 1068 776 /c 7
	rem Bottom
	PIXELDRAW /dl /p 448 776 1064 776 /c 7
	rem Line border for bottom/up menu
	PIXELDRAW /dl /p 444 700 1068 700 /c 7

	rem Search Bar Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 475 113 1039 113 /c 7
	rem Left
	PIXELDRAW /dl /p 473 115 473 150 /c 7
	rem Right
	PIXELDRAW /dl /p 1040 115 1040 150 /c 7
	rem Bottom
	PIXELDRAW /dl /p 474 152 1039 152 /c 9

	rem All Apps Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 945 180 1028 180 /c 7
	rem Left
	PIXELDRAW /dl /p 943 182 943 200 /c 7
	rem Right
	PIXELDRAW /dl /p 1030 182 1030 200 /c 7
	rem Bottom
	PIXELDRAW /dl /p 945 202 1028 202 /c 8

rem Second, Draw Start:
	rem Search icon
	call insertphoto 490 120 140 taskbar-searchbar-top.bmp

	rem The start menu is 2x6, no longer 2x5
	rem The delta is 97 (Each one is approximently 97, 97 is the magic number)
	call insertphoto 495 225 15 edge.%THEME%.bmp
	call insertphoto 592 225 15 notepad.%THEME%.bmp
	call insertphoto 689 225 15 explorer.%THEME%.bmp
	call insertphoto 786 225 15 settings.%THEME%.bmp
	call insertphoto 883 225 15 security.%THEME%.bmp
	call insertphoto 980 225 15 calculator.%THEME%.bmp

	call insertphoto 495 310 15 terminal.%THEME%.bmp
	call insertphoto 592 310 15 photos.%THEME%.bmp
	call insertphoto 689 310 15 paint.%THEME%.bmp
	call insertphoto 786 310 15 calendar.%THEME%.bmp
	call insertphoto 883 310 17 batchinstaller-%THEME%.bmp
	call insertphoto 980 310 15 taskmgr.%THEME%.bmp

	rem Self-explaintory:
	call insertphoto 508 720 12 profile-icon.bmp
	call insertphoto 990 725 125 ui.power.bmp


rem Lastly, Text Start:
	CALL Text 74 8 %lightTHEMEcolor% "Type here to search" X _Button_Boxes _Button_Hover
	CALL Text 69 12 %THEMEcolor% "Pinned" 133 12 %THEMEcolor% " All Apps > " X _Button_Boxes _Button_Hover
	CALL Text 69 33 %THEMEcolor% "Recomended" 69 35 %lightTHEMEcolor% "To show your recent files and apps, turn them on in Settings." 69 36 %lightTHEMEcolor% "To find other batch apps not built-in, look in the All apps section." X _Button_Boxes _Button_Hover

	CALL Text 69 18 %lightTHEMEcolor% "Edge" 82 18 %lightTHEMEcolor% "Notepad" 93 18 %lightTHEMEcolor% "File Explorer" 109 18 %lightTHEMEcolor% "Settings" 123 18 %lightTHEMEcolor% "Security" 136 18 %lightTHEMEcolor% "Calculator" X _Button_Boxes _Button_Hover
	CALL Text 68 24 %lightTHEMEcolor% "Terminal" 82 24 %lightTHEMEcolor% "Photos" 97 24 %lightTHEMEcolor% "Paint" 109 24 %lightTHEMEcolor% "Calendar" 125 24 %lightTHEMEcolor% "WINAPP" 136 24 %lightTHEMEcolor% "Task Manager"  X _Button_Boxes _Button_Hover

	CALL Text 76 51 %lightTHEMEcolor% "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover

	rem CALL Text 75 35 %THEMEcolor% "Recommended" 75 38 %THEMEcolor% "Get Started" 75 39 %THEMEcolor% "Welcome to WinBatchX" 75 41 %THEMEcolor% "Coming soon." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE




:START.POWER
set _START.EXE=2
rem  Power Button Outlined:

rem  Top
PIXELDRAW /dl /p 988 720 1020 720 /c 7
rem  Left Side
PIXELDRAW /dl /p 984 722 984 755 /c 7
rem  Right Side
PIXELDRAW /dl /p 1022 722 1022 755 /c 7
rem  Bottom
PIXELDRAW /dl /p 988 757 1020 757 /c 7



rem The code below is flipped so the gui loads bottom-to-top

call insertphoto 950 670 40 UI.buttonwhite.bmp
call insertphoto 949 671 41 UI.buttonwhite.bmp
call insertphoto 951 674 40 UI.buttonwhite.bmp

call insertphoto 950 630 40 UI.buttonwhite.bmp
call insertphoto 949 631 41 UI.buttonwhite.bmp
call insertphoto 951 634 40 UI.buttonwhite.bmp


call insertphoto 950 620 40 UI.buttonwhite.bmp
call insertphoto 949 621 41 UI.buttonwhite.bmp
call insertphoto 951 624 40 UI.buttonwhite.bmp

rem  Top
PIXELDRAW /dl /p 951 620 1049 620 /c 7
rem  Left Side
PIXELDRAW /dl /p 949 622 949 708 /c 7
rem  Right Side
PIXELDRAW /dl /p 1051 622 1051 708 /c 7
rem  Bottom
PIXELDRAW /dl /p 951 710 1049 710 /c 7

call insertphoto 955 680 95 ui.restart.bmp
CALL Text 138 48 f0 "Restart" X _Button_Boxes _Button_Hover

call insertphoto 955 655 100 ui.power.bmp
CALL Text 138 46 f0 "Shutdown" X _Button_Boxes _Button_Hover

call insertphoto 955 630 95 ui.signout.bmp
CALL Text 138 44 f0 "Sleep" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE


:START.LOGIN
call insertphoto 955 630 95 ui.signout.bmp
CALL Text 138 44 f0 "Sleep" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE



:START.ALLAPPS
goto :KERNEL.EXE


:START.RIGHTCLICKAPP
call list1 %X% %Y% %THEMEcolor% "Move to top" " " "Unpin from Start" " " "_____________" " " "Pin to taskbar" " " "App settings" " " "Uninstall"
IF %ERRORLEVEL%==0 goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
goto :START.RIGHTCLICKAPP



:START.CONTEXTMENU
call list 85 28 %THEMEcolor% "Installed Apps" " " "Power Options" " " "System" " " "NIFS Management" " " "WinBatchX Management" " " "Terminal" " " "Task Manager" " " "Settings" " " "File Explorer" " " "Search" " " "Run" "_____________________" " " "Shut down" " " "Desktop"

IF %ERRORLEVEL%==0 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=APPS.INSTALLED &goto :SETTINGS.EXE
IF %ERRORLEVEL%==1 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=SYSTEM.POWER &goto :SETTINGS.EXE
IF %ERRORLEVEL%==3 goto :DESKTOP.EXE
IF %ERRORLEVEL%==5 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=SYSTEM.ABOUT &goto :SETTINGS.EXE
IF %ERRORLEVEL%==7 goto :DESKTOP.EXE
IF %ERRORLEVEL%==9 goto :DESKTOP.EXE
IF %ERRORLEVEL%==11 goto :TERMINAL.EXE
IF %ERRORLEVEL%==13 goto :TASKMGR.EXE
IF %ERRORLEVEL%==15 goto :SETTINGS.EXE
IF %ERRORLEVEL%==17 goto :EXPLORER.EXE
IF %ERRORLEVEL%==19 goto :SEARCH.EXE
IF %ERRORLEVEL%==21 goto :RUN.EXE
IF %ERRORLEVEL%==24 goto :SHUTDOWN.EXE
IF %ERRORLEVEL%==26 goto :DESKTOP.EXE
goto :KERNEL.EXE






:SEARCH.EXE
set _SEARCH.EXE=1
call :DESKTOP.ICON


rem  The least to make are sharp corners rounded (3px):
call insertphoto 444 100 600 blank.%THEME%.bmp
call insertphoto 448 96 592 blank.%THEME%.bmp
call insertphoto 448 112 592 blank.%THEME%.bmp


call insertphoto 494 100 600 blank.%THEME%.bmp
call insertphoto 498 96 592 blank.%THEME%.bmp
call insertphoto 498 112 592 blank.%THEME%.bmp


call insertphoto 394 100 600 blank.%THEME%.bmp
call insertphoto 398 96 592 blank.%THEME%.bmp
call insertphoto 398 112 592 blank.%THEME%.bmp


CALL Text 58 7 %lightTHEMEcolor% "                                                                                                " X _Button_Boxes _Button_Hover
CALL Text 58 8 %lightTHEMEcolor% "                                                                                                " X _Button_Boxes _Button_Hover
CALL Text 58 9 %lightTHEMEcolor% "                                                                                                " X _Button_Boxes _Button_Hover

rem Outline Search:
	rem Start Menu Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 398 96 1114 96 /c 7
	rem Left
	PIXELDRAW /dl /p 394 112 394 776 /c 7
	rem Right
	PIXELDRAW /dl /p 1118 112 1118 776 /c 7
	rem Bottom
	PIXELDRAW /dl /p 398 776 1114 776 /c 7

	rem Search Bar Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 425 113 1089 113 /c 7
	rem Left
	PIXELDRAW /dl /p 423 115 423 150 /c 7
	rem Right
	PIXELDRAW /dl /p 1090 115 1090 150 /c 7
	rem Bottom
	PIXELDRAW /dl /p 424 152 1089 152 /c 9


rem Mostly Text Search:
	rem Search icon
	call insertphoto 440 123 120 taskbar-searchbar-top.bmp

	CALL Text 65 8 %lightTHEMEcolor% "Type here to search" X _Button_Boxes _Button_Hover
	CALL Text 58 12 %THEMEcolor% "Recent" 142 12 %THEMEcolor% "..." X _Button_Boxes _Button_Hover

	CALL Text 65 14 %lightTHEMEcolor% "Settings" X _Button_Boxes _Button_Hover
	CALL Text 65 17 %lightTHEMEcolor% "Edge" X _Button_Boxes _Button_Hover
	CALL Text 65 20 %lightTHEMEcolor% "Notepad" X _Button_Boxes _Button_Hover
	CALL Text 65 23 %lightTHEMEcolor% "File Explorer" X _Button_Boxes _Button_Hover
	CALL Text 65 26 %lightTHEMEcolor% "Security" X _Button_Boxes _Button_Hover
	CALL Text 65 29 %lightTHEMEcolor% "Calculator" X _Button_Boxes _Button_Hover

	call insertphoto 430 205 10 settings.%THEME%.bmp
	call insertphoto 430 245 10 edge.%THEME%.bmp
	call insertphoto 430 285 10 notepad.%THEME%.bmp
	call insertphoto 430 327 10 explorer.%THEME%.bmp
	call insertphoto 430 368 10 security.%THEME%.bmp
	call insertphoto 430 409 10 calculator.%THEME%.bmp


goto :KERNEL.EXE












:TASKVIEW.EXE
	set _TASKVIEW.EXE=1
	call :DESKTOP.TASKBAR
	call :DESKTOP.ICON

	call :DESKTOP.COMPOSE


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
	call insertphoto 465 204 10 %_ACTIVEAPPIMAGE%.%THEME%.bmp &call Text 69 14 %THEMEcolor% "%_ACTIVEAPPTITLE%" X _Button_Boxes _Button_Hover &call insertphoto 1040 210 120 UI.context.close.bmp
	rem  CALL BOX 74 16 10 35 - - f0  0

	call Text 91 43 %THEMEcolor% "Desktop 1" X _Button_Boxes _Button_Hover
	call insertphoto 650 630 10 "%BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp"
	call insertphoto 740 750 120 taskbar-using-%THEME%.bmp

	PIXELDRAW /dr 650 630 /rd 194 120 /c 7


	PIXELDRAW /dr 640 615 /rd 210 148 /c 7
	goto :KERNEL.EXE
	goto :TASKVIEW.EXE 















rem Lastly, Text Start:


rem multitasking os:

rem for /l %%a in (0,1,64) do (cls &&set "_WBX-MEMORY-S%%a=0"
rem 	call insertphoto 0 0 85 bootimage.bmp
rem 	rem Start preloading memory lines:
rem 	for /l %%b in (0,1,64) do (set "_WBX-MEMORY-S%%aL%%b=0" &&cls &&echo Preloading Set: %%a/64 &&echo Preloading Lines: %%b/64)
rem )
































rem pi=3.14159265358979323846264338327950288419716939937510
rem pi=3.14159265358979323846264338327950





:WINDOWEDTEST.APP
call :DESKTOP.TASKBAR
:WINDOWEDTEST.LOOP
call :DESKTOP.COMPOSE
call list1 4 42 %THEMEcolor% "WindowedControls" "                   " "Top" "Left" "Right" "Bottom" "Minimize" "Maximize" "Close"

IF %ERRORLEVEL%==0 goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 goto :WINDOWEDTEST.LOOP
IF %ERRORLEVEL%==2 goto :WINDOWEDTEST.LOOP
IF %ERRORLEVEL%==3 set /A Y=%Y%-10 &goto :WINDOWEDTEST.LOOP
IF %ERRORLEVEL%==4 set /A X=%X%-15 &goto :WINDOWEDTEST.LOOP
IF %ERRORLEVEL%==5 set /A X=%X%+15 &goto :WINDOWEDTEST.LOOP
IF %ERRORLEVEL%==6 set /A Y=%Y%+10 &goto :WINDOWEDTEST.LOOP
goto :WINDOWEDTEST.LOOP











:SHUTDOWN.EXE
cls
PIXELDRAW /refresh 00
call Text 96 25 0f "Shutting Down" X _Button_Boxes _Button_Hover

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
call Text 98 25 0f "Restarting" X _Button_Boxes _Button_Hover

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





















rem  Last Revised- Nov25/2022

:RUN.EXE
set _START.EXE=1
set _RUN.EXE=1
call :DESKTOP.ICON

call insertphoto 20 620 100 blank.white.bmp
call insertphoto 60 620 100 blank.white.bmp
call insertphoto 100 620 100 blank.white.bmp
call insertphoto 140 620 100 blank.white.bmp
call insertphoto 180 620 100 blank.white.bmp
call insertphoto 220 620 100 blank.white.bmp
call insertphoto 260 620 100 blank.white.bmp

call insertphoto 20 650 100 blank.%THEME%.bmp
call insertphoto 60 650 100 blank.%THEME%.bmp
call insertphoto 100 650 100 blank.%THEME%.bmp
call insertphoto 140 650 100 blank.%THEME%.bmp
call insertphoto 180 650 100 blank.%THEME%.bmp
call insertphoto 220 650 100 blank.%THEME%.bmp
call insertphoto 260 650 100 blank.%THEME%.bmp

call insertphoto 18 622 100 blank.white.bmp
call insertphoto 18 652 96 blank.%THEME%.bmp

call insertphoto 262 622 100 blank.white.bmp
call insertphoto 262 648 100 blank.%THEME%.bmp


call insertphoto 25 622 10 batchinstaller-%THEME%.bmp
call insertphoto 340 625 120 UI.context.close.explorer.bmp

CALL Text 6 44 %THEMEcolor% "Run" X _Button_Boxes _Button_Hover
CALL Text 8 47 %lightTHEMEcolor% "Type the name of a program or executable," 8 48 %lightTHEMEcolor% "and WinBatchX will open it for you." X _Button_Boxes _Button_Hover

call insertphoto 80 720 30 blank.white.bmp
call insertphoto 100 720 30 blank.white.bmp
call insertphoto 120 720 30 blank.white.bmp
call insertphoto 140 720 30 blank.white.bmp
call insertphoto 160 720 30 blank.white.bmp
call insertphoto 180 720 30 blank.white.bmp
call insertphoto 200 720 30 blank.white.bmp
call insertphoto 220 720 30 blank.white.bmp
call insertphoto 240 720 30 blank.white.bmp
call insertphoto 260 720 30 blank.white.bmp
call insertphoto 280 720 30 blank.white.bmp
call insertphoto 300 720 30 blank.white.bmp
call insertphoto 320 720 30 blank.white.bmp


rem Field Outlined:

CALL Text 4 51 %THEMEcolor% "Open:" 10 51 %lightTHEMEcolor% "Click this box to start typing" X _Button_Boxes _Button_Hover
PIXELDRAW /dr 80 720 /rd 270 30 /c 7

goto :KERNEL.EXE



































































































































































































































































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


































































































































































































































































































































































































rem END OF WINBATCHX CODE
rem WinBatchX.

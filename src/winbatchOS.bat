

rem WinBatchOS 24 (Rev1)
rem This software is licensed under the Microsoft Public License (Ms-PL).




rem Microsoft Public License (Ms-PL)
rem.
rem This license governs use of the accompanying software. If you use the
rem software, you accept this license. If you do not accept the license, do not
rem use the software.
rem.
rem 1.  Definitions
rem The terms "reproduce," "reproduction," "derivative works," and "distribution"
rem have the same meaning here as under U.S. copyright law. A "contribution" is
rem the original software, or any additions or changes to the software. A
rem "contributor" is any person that distributes its contribution under this
rem license. "Licensed patents" are a contributor's patent claims that read
rem directly on its contribution.
rem. 
rem 2.  Grant of Rights
rem      (A) Copyright Grant- Subject to the terms of this license, including the
rem      license conditions and limitations in section 3, each contributor grants
rem      you a non-exclusive, worldwide, royalty-free copyright license to
rem      reproduce its contribution, prepare derivative works of its contribution,
rem      and distribute its contribution or any derivative works that you create.
rem.
rem      (B) Patent Grant- Subject to the terms of this license, including the
rem      license conditions and limitations in section 3, each contributor grants
rem      you a non-exclusive, worldwide, royalty-free license under its licensed
rem      patents to make, have made, use, sell, offer for sale, import, and/or
rem      otherwise dispose of its contribution in the software or derivative works
rem      of the contribution in the software.
rem.
rem 3.  Conditions and Limitations
rem      (A) No Trademark License- This license does not grant you rights to use
rem      any contributors' name, logo, or trademarks.
rem.
rem      (B) If you bring a patent claim against any contributor over patents that
rem      you claim are infringed by the software, your patent license from such
rem      contributor to the software ends automatically.
rem.
rem      (C) If you distribute any portion of the software, you must retain all
rem      copyright, patent, trademark, and attribution notices that are present in
rem      the software.
rem.
rem      (D) If you distribute any portion of the software in source code form,
rem      you may do so only under this license by including a complete copy of
rem      this license with your distribution. If you distribute any portion of the
rem      software in compiled or object code form, you may only do so under a
rem      license that complies with this license.
rem.
rem      (E) The software is licensed "as-is." You bear the risk of using it. The
rem      contributors give no express warranties, guarantees, or conditions. You
rem      may have additional consumer rights under your local laws which this
rem      license cannot change. To the extent permitted under your local laws, the
rem      contributors exclude the implied warranties of merchantability, fitness
rem      for a particular purpose and non-infringement.







































@Echo off
IF "%~1" == "" start WinBatchOS start &&endlocal &&exit /b
IF "%~1" == "start" goto :boot.exe
IF "%~1" == "startre" call winbatchos/RECOVERY.BAT


:BOOT.EXE
cd winbatchOS
tar -xf CoreImage.zip

rem Set up command line accessibility for users
rem who accidently 'outphoto' the imaged os.
setlocal EnableExtensions EnableDelayedExpansion
mode 1000,1000
mode 211,60
chcp 437 > nul

cls
PIXELDRAW /refresh 3f

rem ==================================
rem Boot Load winbatchOS Desktop 2023:
rem More simpler now, as most are in
rem services, yay!
rem ==================================
rem 1. Set General Variables
rem 2. Start up 'OS Critical' Services
rem 3. Check Hibernation File
rem ==================================
cls
PIXELDRAW /refresh 3f
call insertphoto 0 0 77 bootimage.bmp

rem 1
rem Set General Variables
SET "_WbOS=WinBatchOS"
SET "_version=11 Beta 1"
SET "_build=11.0.10008.100"
SET "_quantum-ver=1.0rc2"
SET "_ni-ver=11.0"
SET "_ni-SDK=11"

for /l %%a in (0,1,64) do (cls &&set "_WBX-MEMORY-S%%a=0"
	call insertphoto 0 0 85 bootimage.bmp
	rem	Start preloading memory lines:
	for /l %%b in (0,1,64) do (set "_WBX-MEMORY-S%%aL%%b=0" &&cls &&echo Preloading Set: %%a/64 &&echo Preloading Lines: %%b/64)
)


rem 2
rem Start up 'OS Critical' Services
call Text 83 38 0f "Please Wait for the WinBatchOS File System to initalize " X _Button_Boxes _Button_Hover


call Text 83 38 0f "Please Wait for the Time & Date Service                 " X _Button_Boxes _Button_Hover
CALL :WbOS/SERVICES/TIMEDATE.BAT

call Text 83 38 0f "Please Wait for the User Profile Service                " X _Button_Boxes _Button_Hover
CALL Services\PERSONALIZATION.bat

call Text 83 38 0f "Please Wait for the WinBatchOS Security Service         " X _Button_Boxes _Button_Hover
CALL Services\SECURITY.bat

call Text 83 38 0f "Please Wait for the WinBatchOS Update Service           " X _Button_Boxes _Button_Hover
CALL :WbOS/SERVICES/WBXUPDATE.BAT

call Text 83 38 0f "Please Wait for the Desktop Text Maginification Service " X _Button_Boxes _Button_Hover
Call Load "Pixcel.fo" "ASCII.DB"

call Text 83 38 0f "Please Wait for winbatchOS Containers to start          " X _Button_Boxes _Button_Hover


rem 3
rem Check Hibernation File
FOR %%A In (CoreData\hibernationfile.bat) DO call CoreData\hibernationfile.bat && del CoreData\hibernationfile.bat &&GOTO :SYSTEM.EXE



call insertphoto 0 0 85 blankSystemImage.bmp

goto :LOGIN.EXE




























rem Built-In File System for Disking
rem WinbatchOS File System v1


rem WinBatchOS File System (WbFS)
rem Directory Tree

rem diskC-
rem WbOS/
rem | SERVICES/ 
rem    | - WBXUPDATE.BAT
rem    | - TIMEDATE.BAT
rem | NIKERNEL/
rem    | - (old NI kernel dev)

rem | NIGUI/
rem    | - (old NI kernel dev)
rem | NI/
rem    | - (old NI kernel dev)






rem  +++
rem  |-------------------------------|-------------------|
rem  | OS Specifics:                 |                   |
rem  |-------------------------------|-------------------|
rem  | Virtual Disk Version          | 1.0               |
rem  | Stacks                        | Unavailable       |
rem  | Graphics                      | Unavailable       |
rem  | Linux Envirnoment             | Unavailable       |
rem  | OS Name                       | winbatchOS Core   |
rem  | OS Release                    | 11.0              |
rem  | Channel                       | Canary            |
rem  | Flags                         | Unreleased        |
rem  | NI Kernel Version             | 11.0              |
rem  | Quantum Kernel Graphics       | 1.0               |
rem  | Build Release                 | 10008.100         |
rem  | Installed Updates:            | 0                 |
rem  | Last Security Update Patch    | None              |
rem  |-------------------------------|-------------------|
rem  +++






:WbOS/SERVICES/WBXUPDATE.BAT
rem WBXUPDATE

rem  Wget - Retrieves data ONLY for WinBatchX Update.
rem  Call the 'WGET' service instad of the 'WBXUPDATE' service.
rem  (Also a copy of the WBXUPDATE service inside this WinBatchX build)

rem  Download it quietly with -q.
wget -q "https://github.com/bes-ptah/WinBatchOS/archive/refs/heads/main.zip" > nul

rem  Unpack it using tar.
tar -xf main.zip

rem  Enter the directory (always this name)
cd winbatchos-main

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
rmdir winbatchos-main > nul

rem  Also delete the downloaded compressed update file so the command line does not crash on the next update.
del main.zip
goto :OS_FILESYSTEM_ENDOFFILE









:WbOS/SERVICES/TIMEDATE.BAT
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
goto :OS_FILESYSTEM_ENDOFFILE






































































































































































































































:LOGIN.EXE
cls
PIXELDRAW /refresh 3f
call insertphoto 0 0 85 blankSystemImage.bmp
call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp

Call Typo - 95 3 ff "%Time:~0,-6%"
Call Text 102 12 %THEMEcolor% %DATE:~-10% X _Button_Boxes _Button_Hover

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
	title %_WbOS% Build %_build% - Debug: [%%A] [%%B] [%%C] [%%D]
	)
IF %I%==m IF %M%==1 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 211 IF %Y% LSS 58 (
call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -20 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -40 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -100 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
call insertphoto 0 -350 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp
timeout /T 0 /NOBREAK > nul

rem + Disabled Autopassword for this build
rem IF %_WBX_SETPASSWD%==0 GOTO :WELCOME.EXE

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



rem Im not sure why this is here
rem call Text 196 54 3f "      " X _Button_Boxes _Button_Hover
rem call Text 196 55 3f "  (E) " X _Button_Boxes _Button_Hover
rem call Text 196 56 3f "      " X _Button_Boxes _Button_Hover

call Text 203 54 07 "      " X _Button_Boxes _Button_Hover
call Text 203 55 07 "  (P) " X _Button_Boxes _Button_Hover
call Text 203 56 07 "      " X _Button_Boxes _Button_Hover



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

rem Im not sure why this is here
rem call Text 196 54 3f "      " X _Button_Boxes _Button_Hover
rem call Text 196 55 3f "  (E) " X _Button_Boxes _Button_Hover
rem call Text 196 56 3f "      " X _Button_Boxes _Button_Hover

call Text 203 54 3f "      " X _Button_Boxes _Button_Hover
call Text 203 55 3f "  (P) " X _Button_Boxes _Button_Hover
call Text 203 56 3f "      " X _Button_Boxes _Button_Hover


call Text 108 35 0f "              " X _Button_Boxes _Button_Hover
call Text 108 36 0f "      Ok      " X _Button_Boxes _Button_Hover
call Text 108 37 0f "              " X _Button_Boxes _Button_Hover


:LOGIN.INCORRECT.LOOP
PIXELDRAW /refresh 3f
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
	title %_WbOS% Build %_build% - Debug: [%%A] [%%B] [%%C] [%%D]
	)
IF %I%==m IF %M%==1 IF %X% GTR 110 IF %Y% GTR 36 IF %X% LSS 124 IF %Y% LSS 38 goto :LOGIN.USERFORM
IF %I%==m IF %M%==1 IF %X% GTR 205 IF %Y% GTR 55 IF %X% LSS 210 IF %Y% LSS 57 goto :LOGIN.POWER
goto :LOGIN.INCORRECT.LOOP
goto :LOGIN.USERFORM



:LOGIN.POWER
call insertphoto 0 0 %BACKGROUND.LOCKSCREEN.SIZE% %BACKGROUND.LOCKSCREEN.IMAGE%.bmp

CALL Text1 1 1 %THEMEcolor% "%_WbOS% %_version% %_build% - Q%_quantum-ver%" X _Button_Boxes _Button_Hover
CALL Text 101 23 %THEMEcolor% "Power:" X _Button_Boxes _Button_Hover

CALL Text1 92 26 %THEMEcolor% "        Shut down        " 92 30 %THEMEcolor% "         Restart         " 92 42 %THEMEcolor% "          Cancel         " X _Button_Boxes _Button_Hover

GetInput /M %_BOX% %_Button_Boxes% /h 7f
IF %Errorlevel%==1 GOTO :SHUTDOWN.EXE
IF %Errorlevel%==2 GOTO :RESTART.EXE
IF %Errorlevel%==3 GOTO :LOGIN.EXE
goto :LOGIN.POWER







rem WELCOME.EXE Sets the DESKTOP.EXE environment up
rem You should always go through WELCOME.EXE first before hitting the desktop
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
rem Default Variables Set for winbatchOS
SET _ACTIVEAPPLABEL=explorer.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=winbatchOS



rem Default Variables for windowed mode
SET _ACTIVEAPP.DRAGSTATUS=

rem Set how large the Xpos and Ypos can be within a frame
SET _ACTIVEAPP.Xframe=
SET _ACTIVEAPP.Yframe=








rem Set how large the current active app stack is

rem.
rem Feature disabled.
rem.





SET _ACTIVEAPP=
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

























rem Bug Fix before build final release flag
SET _ACTIVEAPPLABEL=desktop.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=winbatchOS















































































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
rem This software is based on the Ms-PT License.

rem winbatchOS 23.0 ARCHITECTURE;

rem *Note:  Executables that are inside winbatchOS.BAT have a colon: like :DESKTOP.EXE. (The ':')
rem         Others are found in certain folders from the root file.

rem **Note: that all features are executed as an actual winbatchOS app.

rem SYSTEM.EXE
rem | 
rem | - CORESCHEDULER.EXE
rem   | - SERVICES (They should be in the services folder or an actual, intergerated service on winbatchOS.bat)
rem     | - User Prefierences        - Services/PERSONALIZATION.BAT
rem     | - winbatchOS Security       - Services/SECURITY.BAT
rem     | - Time and Date Scheduler  - Services/TIMEDATE.BAT
rem     | - winbatchOS Update Service - Services/WBXUPDATE.BAT
rem   | - KERNEL.EXE
rem   | - BACKGROUND APP PROCESSES
rem | - DESKTOP                      - :DESKTOP.EXE
rem   |
rem   | - DESKTOP BACKGROUND COMPOSE - :DESKTOP.COMPOSE
rem   | - TASKBAR COMPOSE            - :DESKTOP.TASKBAR
rem   | - TASKBAR ICON               - :DESKTOP.ICON
rem   | - DESKTOP FILES              - :DESKTOP.LOOP
rem   | - DESKTOP CONTEXT MENU       - :DESKTOP.MENU
rem   | - DESKTOP API CALL- DISPLAY  - :DESKTOP.DISPLAY
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

rem IN winbatchOS, there are 2 ways of x-values and y-values when calculating up
rem the kernel: the 'Xcmd' and 'Ycmd', but there are the 'Xdraw' and 'Ydraw' values, too.
rem.
rem By DEFAULT and FALLBACK, we use Xcmd and Ycmd, simply X and Y values, to 
rem calculate MOST positions on the command line.
rem.
rem Xdraw and Ydraw are newer the Xcmd and Ycmd, but they draw more percisely on the
rem screen. All the features in winbatchOS 23 (Start Menu, Search, Widgets) almost always
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


rem Bug Fix before build final release flag
SET _ACTIVEAPPLABEL=desktop.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=winbatchOS

goto :DESKTOP.EXE
goto :SYSTEM.EXE





rem Everything that is in DESKTOP.EXE is sepreated for your own API! These change at their own risk. Try a actual release for the actual variables, and pull the version being used for each build before running your app.
:DESKTOP.EXE
cls

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


call :DESKTOP.COMPOSE
rem - Feature superseded due to errors: call CoreData\data-variables.bat
call :DESKTOP.CACHECLEAR
call :DESKTOP.TASKBAR
call :DESKTOP.ICON
call :DESKTOP.LOOP

goto :KERNEL.EXE





:DESKTOP.COMPOSE
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

rem call insertphoto 0 0 77 background1.%THEME%.bmp
rem call insertphoto 740 0 77 background2.%THEME%.bmp
rem call insertphoto 0 462 77 background3.%THEME%.bmp
rem call insertphoto 740 462 77 background4.%THEME%.bmp

rem Build Previews

rem  This is kept here for accessibility

CALL Text 184 3 %THEMEcolor% "%_WbOS% %_version%" X _Button_Boxes _Button_Hover
CALL Text 183 4 %THEMEcolor% "%_build% - Q%_quantum-ver%" X _Button_Boxes _Button_Hover
exit /b 







:DESKTOP.CACHECLEAR
set _DESKTOP.EXE=0
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
 call insertphoto 705 785 80 UI.buttonmica.bmp
 call insertphoto 675 785 80 UI.buttonmica.bmp
rem call insertphoto 30 784 1000 taskbar.%THEME%.bmp
rem call insertphoto 0 784 1000 taskbar.%THEME%.bmp

rem PIXELDRAW /dr 0 0 /rd 1490 836 /c 8
rem PIXELDRAW /dr 0 784 /rd 1490 52 /c 8
exit /b





:DESKTOP.ICON
rem _TASKBAR.ALIGNMENT:
rem 0=center
rem 1=left

	IF %_START.EXE%==0 call insertphoto 685 790 105 taskbar-start-off-%THEME%.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 530 8 30 UI.buttonmica.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 600 8 30 UI.buttonmica.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 670 8 30 UI.buttonmica.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 710 8 30 UI.buttonwhite.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 780 8 30 UI.buttonwhite.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 850 8 30 UI.buttonwhite.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 540 13 80 taskbar-search-off-%THEME%.bmp
	IF %_SEARCH.EXE%==0 call insertphoto 720 10 8 %_ACTIVEAPPIMAGE%.%THEME%.bmp
		rem Widgets
		CALL Text 80 0 %lightTHEMEcolor% "Type here to search" X _Button_Boxes _Button_Hover
		CALL Text 105 0 %THEMEcolor% "%_ACTIVEAPPTITLE%" X _Button_Boxes _Button_Hover
	IF %_TASKVIEW.EXE%==0 call insertphoto 740 786 105 taskbar-taskview-off-%THEME%.bmp
	IF %_WIDGETS.EXE%==0 call insertphoto 15 1 105 taskbar-dashboard-off-%THEME%.bmp
		rem Widgets
		CALL Text 7 0 %lightTHEMEcolor% "Update:" X _Button_Boxes _Button_Hover
		CALL Text 16 0 %lightTHEMEcolor% "%_WBXCore-updatemessage%" X _Button_Boxes _Button_Hover
	IF %_APP.EXE%==0 call insertphoto 800 795 12 %_ACTIVEAPPIMAGE%.%THEME%.bmp
	IF %_APP.EXE%==1 call insertphoto 800 795 12 %_ACTIVEAPPIMAGE%.%THEME%.bmp
	IF %_TASKBAROVERFLOW.EXE%==0 call insertphoto 850 790 105 taskbar-overflow-off-%THEME%.bmp
	IF %_ACTION.EXE%==0 call insertphoto 1260 -2 100 taskbaricons-off-%THEME%.bmp
	rem IF %_NOTIFICATION.EXE%==0 call insertphoto 1405 791 95 timecenter-off-%THEME%.bmp
	rem =======
	IF %_START.EXE%==1 call insertphoto 685 786 105 taskbar-start-on-%THEME%.bmp
	IF %_SEARCH.EXE%==1 call insertphoto 540 13 50 taskbar-search-on-%THEME%.bmp
	IF %_TASKVIEW.EXE%==1 call insertphoto 740 790 95 taskbar-taskview-on-%THEME%.bmp
	IF %_WIDGETS.EXE%==1 call insertphoto 15 1 105 taskbar-dashboard-on-%THEME%.bmp
	IF %_APP.EXE%==1 call insertphoto 804 825 120 taskbar-using-%THEME%.bmp
	rem IF %_TASKBAROVERFLOW.EXE%==1 call insertphoto 850 790 105 taskbar-overflow-on-%THEME%.bmp
	IF %_ACTION.EXE%==1 call insertphoto 1360 788 95 taskbaricons-on-%THEME%.bmp
	rem IF %_NOTIFICATION.EXE%==1 call insertphoto 1405 791 95 timecenter-on-%THEME%.bmp


rem draw time
CALL Text 198 0 %THEMEcolor% "%Time:~0,-6%" 185 0 %THEMEcolor% "%DATE:~0,-5%" X _Button_Boxes _Button_Hover

exit /b


:DESKTOP.LOOP
call insertphoto 50 230 25 explorer.recyclebin.%THEME%.bmp
CALL Text 4 23 %THEMEcolor% "Recycle Bin" X _Button_Boxes _Button_Hover
PIXELDRAW /dr 49 229 /rd 67 67 /c 7
PIXELDRAW /dr 50 230 /rd 65 65 /c 7

call insertphoto 50 125 25 batchinstaller-%THEME%.bmp
CALL Text 8 13 %THEMEcolor% "Run" X _Button_Boxes _Button_Hover
PIXELDRAW /dr 49 124 /rd 67 67 /c 7
PIXELDRAW /dr 50 125 /rd 65 65 /c 7

exit /b









:DESKTOP.DISPLAY
rem - Removal of this feature in Q0.9
rem + Added this feature back in Q1.0beta: reason- using this label keeps the gui more responsive.
rem   call this feature to get the accurate at the time of the mouse cursor.
set /A Xdraw=%Xcmd%*7
set /A Ydraw=%Ycmd%*14
exit /b



:DESKTOP.MENU
set _DESKTOP.EXE=2
rem THIS LABEL USES THE NEW winbatchOS SDK 19
rem There is fallback- winbatchOS SDK 16 is still available

call :DESKTOP.DISPLAY

rem Draw the context menu
call insertphoto %Xdraw% %Ydraw% 260 blank.%THEME%.bmp

rem Round those corners


set /A X.TEMP.DESKTOP.MENU=%Xdraw%+2
set /A Y.TEMP.DESKTOP.MENU=%Ydraw%
call insertphoto %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% 259 blank.%THEME%.bmp

set /A X.TEMP.DESKTOP.MENU=%Xdraw%
set /A Y.TEMP.DESKTOP.MENU=%Ydraw%+2
call insertphoto %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% 260 blank.%THEME%.bmp

set /A X.TEMP.DESKTOP.MENU=%Xdraw%+2
set /A Y.TEMP.DESKTOP.MENU=%Ydraw%+2
call insertphoto %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% 260 blank.%THEME%.bmp


set /A X.TEMP.DESKTOP.MENU=%Xdraw%+1
set /A Y.TEMP.DESKTOP.MENU=%Ydraw%-1
call insertphoto %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% 259 blank.%THEME%.bmp

set /A X.TEMP.DESKTOP.MENU=%Xdraw%+1
set /A Y.TEMP.DESKTOP.MENU=%Ydraw%+4
call insertphoto %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% 259 blank.%THEME%.bmp


rem Display the menu
set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "View" X _Button_Boxes _Button_Hover


set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%+2
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "Sort by" X _Button_Boxes _Button_Hover

set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%+4
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "Refresh" X _Button_Boxes _Button_Hover

set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%+7
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "New" X _Button_Boxes _Button_Hover

set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%+10
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "Display Settings" X _Button_Boxes _Button_Hover

set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%+12
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "Personalize" X _Button_Boxes _Button_Hover

set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%+15
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "Open in Terminal" X _Button_Boxes _Button_Hover

set /A X.TEMP.DESKTOP.MENU=%Xcmd%+4
set /A Y.TEMP.DESKTOP.MENU=%Ycmd%+18
CALL Text %X.TEMP.DESKTOP.MENU% %Y.TEMP.DESKTOP.MENU% %THEMEcolor% "Show more options" X _Button_Boxes _Button_Hover




set /A X1.TEMP.DESKTOP.MENU=%Xcmd%
set /A Y1.TEMP.DESKTOP.MENU=%Ycmd%

set /A X2.TEMP.DESKTOP.MENU=%Xcmd%+39
set /A Y2.TEMP.DESKTOP.MENU=%Ycmd%+2

set /A X3.TEMP.DESKTOP.MENU=%X1.TEMP.DESKTOP.MENU%
set /A Y3.TEMP.DESKTOP.MENU=%Y1.TEMP.DESKTOP.MENU%+2

set /A X4.TEMP.DESKTOP.MENU=%X2.TEMP.DESKTOP.MENU%+39
set /A Y4.TEMP.DESKTOP.MENU=%Y2.TEMP.DESKTOP.MENU%+2

set /A X5.TEMP.DESKTOP.MENU=%X3.TEMP.DESKTOP.MENU%
set /A Y5.TEMP.DESKTOP.MENU=%Y3.TEMP.DESKTOP.MENU%+2

set /A X6.TEMP.DESKTOP.MENU=%X4.TEMP.DESKTOP.MENU%+39
set /A Y6.TEMP.DESKTOP.MENU=%Y4.TEMP.DESKTOP.MENU%+2

set /A X7.TEMP.DESKTOP.MENU=%X5.TEMP.DESKTOP.MENU%
set /A Y7.TEMP.DESKTOP.MENU=%Y5.TEMP.DESKTOP.MENU%+2

set /A X8.TEMP.DESKTOP.MENU=%X6.TEMP.DESKTOP.MENU%+39
set /A Y8.TEMP.DESKTOP.MENU=%Y6.TEMP.DESKTOP.MENU%+2

set /A X9.TEMP.DESKTOP.MENU=%X7.TEMP.DESKTOP.MENU%
set /A Y9.TEMP.DESKTOP.MENU=%Y7.TEMP.DESKTOP.MENU%+2

set /A X10.TEMP.DESKTOP.MENU=%X8.TEMP.DESKTOP.MENU%+39
set /A Y10.TEMP.DESKTOP.MENU=%Y8.TEMP.DESKTOP.MENU%+3

set /A X11.TEMP.DESKTOP.MENU=%X9.TEMP.DESKTOP.MENU%
set /A Y11.TEMP.DESKTOP.MENU=%Y9.TEMP.DESKTOP.MENU%+2

set /A X12.TEMP.DESKTOP.MENU=%X10.TEMP.DESKTOP.MENU%+39
set /A Y12.TEMP.DESKTOP.MENU=%Y10.TEMP.DESKTOP.MENU%+2

set /A X13.TEMP.DESKTOP.MENU=%X11.TEMP.DESKTOP.MENU%
set /A Y13.TEMP.DESKTOP.MENU=%Y11.TEMP.DESKTOP.MENU%+2

set /A X14.TEMP.DESKTOP.MENU=%X12.TEMP.DESKTOP.MENU%+39
set /A Y14.TEMP.DESKTOP.MENU=%Y12.TEMP.DESKTOP.MENU%+2

set /A X15.TEMP.DESKTOP.MENU=%X13.TEMP.DESKTOP.MENU%
set /A Y15.TEMP.DESKTOP.MENU=%Y13.TEMP.DESKTOP.MENU%+2

set /A X16.TEMP.DESKTOP.MENU=%X14.TEMP.DESKTOP.MENU%+39
set /A Y16.TEMP.DESKTOP.MENU=%Y14.TEMP.DESKTOP.MENU%+3

set /A X17.TEMP.DESKTOP.MENU=%X15.TEMP.DESKTOP.MENU%
set /A Y17.TEMP.DESKTOP.MENU=%Y15.TEMP.DESKTOP.MENU%+2

set /A X18.TEMP.DESKTOP.MENU=%X16.TEMP.DESKTOP.MENU%+39
set /A Y18.TEMP.DESKTOP.MENU=%Y16.TEMP.DESKTOP.MENU%+3

exit /b


:DESKTOP.MENU.OLD
set _DESKTOP.EXE=2
rem This label uses winbatchOS SDK 16
call list %X% %Y% %THEMEcolor% "View               >" " " "Sort by            >" " " "Refresh" "____________________" " " "New                > " "____________________" " " "Display Settings" " " "Personalize" "____________________" " " "Open in Terminal"
IF %ERRORLEVEL%==0 goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 goto :DESKTOP.MENU.VIEW.OLD
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
IF %ERRORLEVEL%==3 goto :DESKTOP.MENU.SORT.OLD
IF %ERRORLEVEL%==4 goto :DESKTOP.EXE
IF %ERRORLEVEL%==5 goto :DESKTOP.EXE 
IF %ERRORLEVEL%==6 goto :DESKTOP.EXE
IF %ERRORLEVEL%==7 goto :DESKTOP.EXE
IF %ERRORLEVEL%==8 goto :DESKTOP.MENU.NEW.OLD
IF %ERRORLEVEL%==9 goto :DESKTOP.EXE
IF %ERRORLEVEL%==10 goto :DESKTOP.EXE
IF %ERRORLEVEL%==11 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=SYSTEM.DISPLAY &goto :SETTINGS.EXE
IF %ERRORLEVEL%==12 goto :DESKTOP.EXE
IF %ERRORLEVEL%==13 set _SETTINGS.EXE=0 &set _SETTINGS.SECTION=PERSONALIZATION &goto :SETTINGS.EXE
IF %ERRORLEVEL%==14 goto :DESKTOP.EXE
IF %ERRORLEVEL%==15 goto :DESKTOP.EXE
IF %ERRORLEVEL%==16 goto :TERMINAL.EXE
goto :DESKTOP.MENU.OLD



:DESKTOP.MENU.VIEW.OLD
set /A "Xright=%X%+28"
call list %Xright% %Y% %THEMEcolor% "Large Icons" "Medium Icons" "Small Icons" "___________________" " " "Show Desktop Icons"
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
IF %ERRORLEVEL%==3 goto :DESKTOP.EXE
IF %ERRORLEVEL%==4 goto :DESKTOP.EXE
IF %ERRORLEVEL%==5 goto :DESKTOP.EXE
IF %ERRORLEVEL%==6 goto :DESKTOP.EXE
goto :RIGHTCLICKDESKTOP.VIEW


:DESKTOP.MENU.SORT.OLD
set /A "Xright=%X%+28"
set /A "Yright=%Y%+3"
call list %Xright% %Yright% %THEMEcolor% "Name" "Size"
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
goto :RIGHTCLICKDESKTOP.VIEW


:DESKTOP.MENU.NEW.OLD
set /A "Xright=%X%+28"
set /A "Yright=%Y%+8"
call list %Xright% %Yright% %THEMEcolor% "Shortcut" " " "___________________" " " "Not available: Folder"
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
IF %ERRORLEVEL%==2 goto :DESKTOP.EXE
IF %ERRORLEVEL%==3 goto :DESKTOP.EXE
IF %ERRORLEVEL%==4 goto :DESKTOP.EXE
IF %ERRORLEVEL%==5 goto :DESKTOP.EXE
goto :RIGHTCLICKDESKTOP.VIEW





:ACTIVEAPP.MENU
rem This label uses winbatchOS SDK 16
call list 110 2 %THEMEcolor% "%_ACTIVEAPPLABEL%" "Pin to Desk" "Close Window"
IF %ERRORLEVEL%==0 goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
IF %ERRORLEVEL%==2 goto :ERROR.EXE &goto :DESKTOP.EXE
IF %ERRORLEVEL%==3 call :DESKTOP.CACHECLEAR &call :KERNEL.API.BUILTIN.APPCLOSE &goto :DESKTOP.EXE
:ACTIVEAPP.MENU






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


	set Xcmd=%%A
	set Ycmd=%%B
	
	set /A Xdraw=%Xcmd%*7
	set /A Ydraw=%Ycmd%*14

	title %_WbOS% %_version% - Build %_build% - Debug: [%%A] [%%B] [%%C] [%%D]


	CALL Text 198 0 %THEMEcolor% "%Time:~0,-6%" 185 0 %THEMEcolor% "%DATE:~0,-5%" X _Button_Boxes _Button_Hover

	)


IF %_ACTIVEAPPLABEL%==desktop.exe IF %Button%==1 IF %X% Gtr 6 IF %X% Lss 17 IF %Y% Gtr 1 IF %Y% Lss 7 call :EXPLORER.EXE


IF %_ACTIVEAPPLABEL%==desktop.exe IF %Button%==2 IF %X% Gtr 0 IF %X% Lss 200 IF %Y% Gtr 4 IF %Y% Lss 50 call :DESKTOP.MENU



IF %_TASKBAR.ALIGNMENT%==0 (
	rem Start Menu:
		IF %_START.EXE%==0 IF %Button%==1 IF %X% GTR 98 IF %Y% GTR 55 IF %X% LSS 103 IF %Y% LSS 59 goto :START.EXE

	rem Context Menu for Start:
		IF %_START.EXE%==0 IF %Button%==2 IF %X% GTR 98 IF %Y% GTR 55 IF %X% LSS 103 IF %Y% LSS 59 goto :START.CONTEXTMENU
		rem In case it does not open 'in' start:
		IF %_START.EXE%==1 IF %Button%==2 IF %X% GTR 98 IF %Y% GTR 55 IF %X% LSS 103 IF %Y% LSS 59 goto :START.CONTEXTMENU

	rem Close the Start Menu:
		IF %_START.EXE%==1 IF %Button%==1 IF %X% GTR 98 IF %Y% GTR 55 IF %X% LSS 103 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE
		IF %_START.EXE%==2 IF %Button%==2 IF %X% GTR 98 IF %Y% GTR 55 IF %X% LSS 103 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE


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


	rem Search:
	IF %_SEARCH.EXE%==0 IF %Button%==1 IF %X% GTR 75 IF %Y% GTR 0 IF %X% LSS 101 IF %Y% LSS 2 goto :SEARCH.EXE

		rem Close Search:
		IF %_SEARCH.EXE%==1 IF %Button%==1 IF %X% GTR 75 IF %Y% GTR 0 IF %X% LSS 101 IF %Y% LSS 2 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE

		rem Right Click Search:
		IF %Button%==2 IF %X% GTR 101 IF %Y% GTR 0 IF %X% LSS 132 IF %Y% LSS 3 goto :ACTIVEAPP.MENU


	rem Task View:
	IF %_TASKVIEW.EXE%==0 IF %Button%==1 IF %X% GTR 105 IF %Y% GTR 56 IF %X% LSS 111 IF %Y% LSS 59 goto :TASKVIEW.EXE
		
		rem Close Task View:
		IF %_TASKVIEW.EXE%==1 IF %Button%==1 IF %X% GTR 105 IF %Y% GTR 56 IF %X% LSS 111 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE

	rem Widgets:
	IF %_WIDGETS.EXE%==0 IF %Button%==1 IF %X% GTR 2 IF %Y% GTR 56 IF %X% LSS 28 IF %Y% LSS 59 goto :WIDGETS.EXE

		rem Close Widgets:
		IF %_WIDGETS.EXE%==1 IF %Button%==1 IF %X% GTR 2 IF %Y% GTR 56 IF %X% LSS 28 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE
)


rem Close the Start Menu - Outside Start Menu UI- Desktop:
	IF %_START.EXE%==1 IF %Button%==1 IF %X% Gtr 0 IF %X% Lss 200 IF %Y% Gtr 0 IF %Y% Lss 50 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE




rem Action Center:
IF %_ACTION.EXE%==0 IF %Button%==1 IF %X% GTR 193 IF %Y% GTR 56 IF %X% LSS 198 IF %Y% LSS 59 goto :ACTION.EXE
	rem Close Action Center:
	IF %_ACTION.EXE%==1 IF %Button%==1 IF %X% GTR 193 IF %Y% GTR 56 IF %X% LSS 198 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE

rem Notification Center:
IF %_NOTIFICATION.EXE%==0 IF %Button%==1 IF %X% GTR 199 IF %Y% GTR 56 IF %X% LSS 211 IF %Y% LSS 59 goto :NOTIFICATION.EXE
	rem Close Notification Center:
	IF %_NOTIFICATION.EXE%==1 IF %Button%==1 IF %X% GTR 199 IF %Y% GTR 56 IF %X% LSS 211 IF %Y% LSS 59 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE



rem Desktop Context Menu:
IF %_DESKTOP.EXE%==2 (
	IF %X% GTR %X1.TEMP.DESKTOP.MENU% IF %Y% GTR %Y1.TEMP.DESKTOP.MENU% IF %X% LSS %X2.TEMP.DESKTOP.MENU% IF %Y% LSS %Y2.TEMP.DESKTOP.MENU% echo test1 &goto :DESKTOP.EXE
	IF %X% GTR %X3.TEMP.DESKTOP.MENU% IF %Y% GTR %Y3.TEMP.DESKTOP.MENU% IF %X% LSS %X4.TEMP.DESKTOP.MENU% IF %Y% LSS %Y4.TEMP.DESKTOP.MENU% echo test2 &goto :DESKTOP.EXE
	IF %X% GTR %X5.TEMP.DESKTOP.MENU% IF %Y% GTR %Y5.TEMP.DESKTOP.MENU% IF %X% LSS %X6.TEMP.DESKTOP.MENU% IF %Y% LSS %Y6.TEMP.DESKTOP.MENU% echo test3 &goto :DESKTOP.EXE
	IF %X% GTR %X7.TEMP.DESKTOP.MENU% IF %Y% GTR %Y7.TEMP.DESKTOP.MENU% IF %X% LSS %X8.TEMP.DESKTOP.MENU% IF %Y% LSS %Y8.TEMP.DESKTOP.MENU% echo test4 &goto :DESKTOP.EXE
	IF %X% GTR %X9.TEMP.DESKTOP.MENU% IF %Y% GTR %Y9.TEMP.DESKTOP.MENU% IF %X% LSS %X10.TEMP.DESKTOP.MENU% IF %Y% LSS %Y10.TEMP.DESKTOP.MENU% goto :ERROR.EXE
	IF %X% GTR %X11.TEMP.DESKTOP.MENU% IF %Y% GTR %Y11.TEMP.DESKTOP.MENU% IF %X% LSS %X12.TEMP.DESKTOP.MENU% IF %Y% LSS %Y12.TEMP.DESKTOP.MENU% echo test6 &goto :DESKTOP.EXE
	IF %X% GTR %X13.TEMP.DESKTOP.MENU% IF %Y% GTR %Y13.TEMP.DESKTOP.MENU% IF %X% LSS %X14.TEMP.DESKTOP.MENU% IF %Y% LSS %Y14.TEMP.DESKTOP.MENU% echo test7 &goto :DESKTOP.EXE
	IF %X% GTR %X15.TEMP.DESKTOP.MENU% IF %Y% GTR %Y15.TEMP.DESKTOP.MENU% IF %X% LSS %X16.TEMP.DESKTOP.MENU% IF %Y% LSS %Y16.TEMP.DESKTOP.MENU% echo test8 &goto :DESKTOP.EXE
	IF %X% GTR %X17.TEMP.DESKTOP.MENU% IF %Y% GTR %Y17.TEMP.DESKTOP.MENU% IF %X% LSS %X18.TEMP.DESKTOP.MENU% IF %Y% LSS %Y18.TEMP.DESKTOP.MENU% echo test9 &goto :DESKTOP.MENU.OLD

)




rem Apps:
IF %_RUN.EXE%==1 IF %Button%==1 IF %X% GTR 47 IF %Y% GTR 44 IF %X% LSS 52 IF %Y% LSS 46 call :DESKTOP.CACHECLEAR &goto :DESKTOP.EXE



rem Built-in Windowed App controls-

rem App closes:

rem Minimize
IF %I%==m IF %M% EQU 1 IF %X% GTR 191 IF %Y% GTR 0 IF %X% LSS 196 IF %Y% LSS 4 call :KERNEL.API.BUILTIN.APPCLOSE &goto :DESKTOP.EXE

rem Maxinize
IF %I%==m IF %M% EQU 1 IF %X% GTR 197 IF %Y% GTR 0 IF %X% LSS 202 IF %Y% LSS 4 call :KERNEL.API.BUILTIN.APPCLOSE &goto :DESKTOP.EXE

rem Close
IF %I%==m IF %M% EQU 1 IF %X% GTR 203 IF %Y% GTR 0 IF %X% LSS 210 IF %Y% LSS 4 call :KERNEL.API.BUILTIN.APPCLOSE &goto :DESKTOP.EXE








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


	IF %_SETTINGS.SECTION%==PERSONALIZATION IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 30 IF %X% LSS 202 IF %Y% LSS 33 goto :SETTINGS.PERSONALIZATION.COLOR
	IF %_SETTINGS.SECTION%==PERSONALIZATION IF %I%==m IF %M% EQU 1 IF %X% GTR 58 IF %Y% GTR 45 IF %X% LSS 202 IF %Y% LSS 48 goto :SETTINGS.PERSONALIZATION.TASKBAR
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

	IF %_SETTINGS.SECTION%==PERSONALIZATION.COLOR IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.PERSONALIZATION
	IF %_SETTINGS.SECTION%==PERSONALIZATION.TASKBAR IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.PERSONALIZATION

	IF %_SETTINGS.SECTION%==UPDATE.BUILDS IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.UPDATE




	rem SYSTEM.DISPLAY
	IF %_SETTINGS.SECTION%==SYSTEM.DISPLAY IF %I%==m IF %M% EQU 1 IF %X% GTR 122 IF %Y% GTR 8 IF %X% LSS 127 IF %Y% LSS 10 CALL Text 65 8 f0 "                                                                  " X _Button_Boxes _Button_Hover

		rem SYSTEM.NOTIFICATION
		IF %_SETTINGS.SECTION%==SYSTEM.NOTIFICATION IF %I%==m IF %M% EQU 1 IF %X% GTR 166 IF %Y% GTR 10 IF %X% LSS 178 IF %Y% LSS 13 (
			set M=0
			IF %NOTIFICATIONS%==0 set NOTIFICATIONS=1
			IF %NOTIFICATIONS%==1 set NOTIFICATIONS=0

			call :SETTINGS.REWRITECONFIG
			call Services\PERSONALIZATION.BAT
			call :DESKTOP.TASKBAR
			call :DESKTOP.ICON
			goto :SETTINGS.SYSTEM.NOTIFICATION
		)

		rem SYSTEM.RECOVERY
		IF %_SETTINGS.SECTION%==SYSTEM.RECOVERY IF %I%==m IF %M% EQU 1 IF %X% GTR 160 IF %Y% GTR 14 IF %X% LSS 178 IF %Y% LSS 16 goto :SETTINGS.RECOVERY.RESET

		rem For Yes/No question on popup!
		
		rem Yes
			IF %_SETTINGS.SECTION%==SYSTEM.RECOVERY.RESET IF %I%==m IF %M% EQU 1 IF %X% GTR 92 IF %Y% GTR 31 IF %X% LSS 108 IF %Y% LSS 35 goto :SETTINGS.RECOVERY
		rem No
			IF %_SETTINGS.SECTION%==SYSTEM.RECOVERY.RESET IF %I%==m IF %M% EQU 1 IF %X% GTR 130 IF %Y% GTR 31 IF %X% LSS 146 IF %Y% LSS 35 goto :SETTINGS.RECOVERY
	
	rem PERSONALIZATION
	IF %_SETTINGS.SECTION%==PERSONALIZATION IF %I%==m IF %M% EQU 1 IF %X% GTR 56 IF %Y% GTR 4 IF %X% LSS 63 IF %Y% LSS 6 goto :SETTINGS.PERSONALIZATION


		rem PERSONALIZATION.COLOR
		IF %_SETTINGS.SECTION%==PERSONALIZATION.COLOR IF %I%==m IF %M% EQU 1 IF %X% GTR 139 IF %Y% GTR 26 IF %X% LSS 148 IF %Y% LSS 29 (
			set M=0
			IF %THEME%==light set THEME=dark
			IF %THEME%==dark set THEME=light

			call :SETTINGS.REWRITECONFIG
			call Services\PERSONALIZATION.BAT
			call :DESKTOP.TASKBAR
			call :DESKTOP.ICON
			goto :SETTINGS.EXE
			goto :SETTINGS.PERSONALIZATION.COLOR
		)


		rem PERSONALIZATION.TASKBAR
		IF %_SETTINGS.SECTION%==PERSONALIZATION.TASKBAR IF %I%==m IF %M% EQU 1 IF %X% GTR 121 IF %Y% GTR 23 IF %X% LSS 129 IF %Y% LSS 26 (
			set M=0
			IF %_TASKBAR.ALIGNMENT%==1 set _TASKBAR.ALIGNMENT=0
			IF %_TASKBAR.ALIGNMENT%==0 set _TASKBAR.ALIGNMENT=1

			call :SETTINGS.REWRITECONFIG
			call :DESKTOP.TASKBAR
			call :DESKTOP.ICON
			goto :SETTINGS.PERSONALIZATION.TASKBAR
		)




	IF %_SETTINGS.SECTION%==ACCOUNTS IF %I%==m IF %M% EQU 1 IF %X% GTR 65 IF %Y% GTR 17 IF %X% LSS 193 IF %Y% LSS 19 goto :SETTINGS.ACCOUNTS.PROFILE
	IF %_SETTINGS.SECTION%==ACCOUNTS IF %I%==m IF %M% EQU 1 IF %X% GTR 65 IF %Y% GTR 20 IF %X% LSS 193 IF %Y% LSS 23 goto :SETTINGS.ACCOUNTS.SIGNIN
	
	IF %_SETTINGS.SECTION%==ACCOUNTS.PROFILE IF %I%==m IF %M% EQU 1 IF %X% GTR 55 IF %Y% GTR 4 IF %X% LSS 65 IF %Y% LSS 6 goto :SETTINGS.ACCOUNTS
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 151 IF %Y% GTR 21 IF %X% LSS 157 IF %Y% LSS 24 goto :SETTINGS.ACCOUNTS
	
	
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 92 IF %Y% GTR 31 IF %X% LSS 108 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN IF %I%==m IF %M% EQU 1 IF %X% GTR 130 IF %Y% GTR 31 IF %X% LSS 146 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS
	
	IF %_SETTINGS.SECTION%==ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE IF %I%==m IF %M% EQU 1 IF %X% GTR 130 IF %Y% GTR 31 IF %X% LSS 146 IF %Y% LSS 35 goto :SETTINGS.ACCOUNTS
	


	IF %_SETTINGS.SECTION%==UPDATE IF %I%==m IF %M% EQU 1 IF %X% GTR 152 IF %Y% GTR 8 IF %X% LSS 172 IF %Y% LSS 12 goto :SETTINGS.UPDATE.WGET
	IF %_SETTINGS.SECTION%==UPDATE IF %I%==m IF %M% EQU 1 IF %X% GTR 57 IF %Y% GTR 27 IF %X% LSS 170 IF %Y% LSS 29 goto :SETTINGS.UPDATE.BUILDS
)
	
	rem PAINT
	IF %_PAINT.EXE%==1 (
		IF %I%==m IF %M% EQU 1 IF %X% GTR 7 IF %X% LSS 178 IF %Y% GTR 10 IF %Y% LSS 53 CALL Text %X% %Y% %_PAINT.COLOR%0 " " X _Button_Boxes _Button_Hover &goto :KERNEL.EXE
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
	IF %_TERMINAL.EXE%==1 IF %I%==m IF %M% EQU 0 IF %X% GTR 0 IF %X% LSS 200 IF %Y% GTR 0 IF %Y% LSS 55 CALL Text 90 30 0f "Open Terminal" X _Button_Boxes _Button_Hover
	IF %_TERMINAL.EXE%==1 IF %I%==m IF %M% EQU 0 IF %X% GTR 90 IF %Y% GTR 30 IF %X% LSS 106 IF %Y% LSS 32 CALL Text 90 30 03 "Open Terminal" X _Button_Boxes _Button_Hover


	rem  SECURITY!
	IF %_SECURITY.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 14 IF %Y% GTR 7 IF %X% LSS 30 IF %Y% LSS 10 call :SECURITY.SCAN &goto :SECURITY.EXE


	rem  PHOTOS

	rem  Import
	IF %_PHOTOS.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 172 IF %Y% GTR 0 IF %X% LSS 184 IF %Y% LSS 2 call :PHOTOS.SAVEFILEDIALOG &goto :PHOTOS.EXE
	
	rem  Settings
	IF %_PHOTOS.EXE%==1 IF %I%==m IF %M% EQU 1 IF %X% GTR 188 IF %Y% GTR 0 IF %X% LSS 195 IF %Y% LSS 2 call :PHOTOS.SAVEFILEDIALOG &goto :PHOTOS.EXE
	



	rem FILE EXPLORER

	IF %_EXPLORER.EXE%==1 (
		rem Home
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 9 IF %Y% LSS 12 goto :EXPLORER.EXE



		rem Desktop
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 13 IF %Y% LSS 15 goto :EXPLORER.DESKTOP

		rem Documents
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 15 IF %Y% LSS 18 goto :EXPLORER.DOCUMENTS

		rem Downloads
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 18 IF %Y% LSS 21 goto :EXPLORER.DOWNLOADS

		rem Music
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 21 IF %Y% LSS 24 goto :EXPLORER.MUSIC

		rem Pictures
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 24 IF %Y% LSS 27 goto :EXPLORER.PICTURES

		rem Videos
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 28 IF %Y% LSS 30 goto :EXPLORER.VIDEOS



		rem Disk 1 (Default)
		IF %I%==m IF %M% EQU 1 IF %X% GTR 2 IF %X% LSS 39 IF %Y% GTR 31 IF %Y% LSS 33 goto :EXPLORER.DISK1
	)

goto :KERNEL.EXE






rem Start Menu Version 22.0.10000
:START.EXE


IF %_TASKBAR.ALIGNMENT%==1 goto :START.LEFT
IF %_TASKBAR.ALIGNMENT%==0 goto :START.CENTER


:START.CENTER
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

	rem CALL Text 75 35 %THEMEcolor% "Recommended" 75 38 %THEMEcolor% "Get Started" 75 39 %THEMEcolor% "Welcome to winbatchOS" 75 41 %THEMEcolor% "Coming soon." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE








:START.LEFT
set _START.EXE=1
call :DESKTOP.ICON

rem  The least to make are sharp corners rounded (3px):
call insertphoto 4 100 600 blank.%THEME%.bmp

call insertphoto 8 96 592 blank.%THEME%.bmp
call insertphoto 8 112 592 blank.%THEME%.bmp

call insertphoto 52 96 592 blank.%THEME%.bmp
call insertphoto 52 112 590 blank.%THEME%.bmp


CALL Text 5 7 %lightTHEMEcolor% "                                                                                  " X _Button_Boxes _Button_Hover
CALL Text 5 8 %lightTHEMEcolor% "                                                                                  " X _Button_Boxes _Button_Hover
CALL Text 5 9 %lightTHEMEcolor% "                                                                                  " X _Button_Boxes _Button_Hover

rem First, Outline Start:
	rem Start Menu Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 8 96 664 96 /c 8
	rem Left
	PIXELDRAW /dl /p 4 112 4 776 /c 8
	rem Right
	PIXELDRAW /dl /p 668 112 668 776 /c 8
	rem Bottom
	PIXELDRAW /dl /p 8 776 664 776 /c 8
	rem Line border for bottom/up menu
	PIXELDRAW /dl /p 4 700 668 700 /c 8

	rem Search Bar Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 35 113 639 113 /c 7
	rem Left
	PIXELDRAW /dl /p 33 115 33 150 /c 7
	rem Right
	PIXELDRAW /dl /p 640 115 640 150 /c 7
	rem Bottom
	PIXELDRAW /dl /p 34 152 639 152 /c 9

	rem All Apps Outline Rounded:
	rem Top
	PIXELDRAW /dl /p 545 180 628 180 /c 7
	rem Left
	PIXELDRAW /dl /p 543 182 543 200 /c 7
	rem Right
	PIXELDRAW /dl /p 630 182 630 200 /c 7
	rem Bottom
	PIXELDRAW /dl /p 545 202 628 202 /c 8

rem Second, Draw Start:
	rem Search icon
	call insertphoto 50 120 140 taskbar-searchbar-top.bmp

	rem The start menu is 2x6, no longer 2x5
	rem The delta is 97 (Each one is approximently 97, 97 is the magic number)
	call insertphoto 45 225 15 edge.%THEME%.bmp
	call insertphoto 152 225 15 notepad.%THEME%.bmp
	call insertphoto 269 225 15 explorer.%THEME%.bmp
	call insertphoto 376 225 15 settings.%THEME%.bmp
	call insertphoto 483 225 15 security.%THEME%.bmp
	call insertphoto 590 225 15 calculator.%THEME%.bmp

	call insertphoto 45 310 15 terminal.%THEME%.bmp
	call insertphoto 152 310 15 photos.%THEME%.bmp
	call insertphoto 269 310 15 paint.%THEME%.bmp
	call insertphoto 376 310 15 calendar.%THEME%.bmp
	call insertphoto 483 310 17 batchinstaller-%THEME%.bmp
	call insertphoto 590 310 15 taskmgr.%THEME%.bmp

	rem Self-explaintory:
	call insertphoto 48 720 12 profile-icon.bmp
	call insertphoto 600 725 125 ui.power.bmp


rem Lastly, Text Start:
	CALL Text 11 8 %lightTHEMEcolor% "Type here to search" X _Button_Boxes _Button_Hover
	CALL Text 4 12 %THEMEcolor% "Pinned" 76 12 %THEMEcolor% " All Apps > " X _Button_Boxes _Button_Hover
	CALL Text 4 33 %THEMEcolor% "Recomended" 4 35 %lightTHEMEcolor% "To show your recent files and apps, turn them on in Settings." 4 36 %lightTHEMEcolor% "To find other batch apps not built-in, look in the All apps section." X _Button_Boxes _Button_Hover

	CALL Text 5 18 %lightTHEMEcolor% "Edge" 19 18 %lightTHEMEcolor% "Notepad" 33 18 %lightTHEMEcolor% "File Explorer" 51 18 %lightTHEMEcolor% "Settings" 66 18 %lightTHEMEcolor% "Security" 80 18 %lightTHEMEcolor% "Calculator" X _Button_Boxes _Button_Hover
	CALL Text 4 24 %lightTHEMEcolor% "Terminal" 19 24 %lightTHEMEcolor% "Photos" 37 24 %lightTHEMEcolor% "Paint" 51 24 %lightTHEMEcolor% "Calendar" 67 24 %lightTHEMEcolor% "WINAPP" 80 24 %lightTHEMEcolor% "Task Manager"  X _Button_Boxes _Button_Hover

	CALL Text 11 51 %lightTHEMEcolor% "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover

	rem CALL Text 75 35 %THEMEcolor% "Recommended" 75 38 %THEMEcolor% "Get Started" 75 39 %THEMEcolor% "Welcome to winbatchOS" 75 41 %THEMEcolor% "Coming soon." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE







:START.POWER
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

CALL Text1 1 1 %THEMEcolor% "%_WbOS% %_version% %_build% - Q%_quantum-ver%" X _Button_Boxes _Button_Hover
CALL Text 101 23 %THEMEcolor% "Power:" X _Button_Boxes _Button_Hover

CALL Text 92 26 %THEMEcolor% "        Shut down        " 92 30 %THEMEcolor% "         Restart         " 92 34 %THEMEcolor% "        Hibernate        " 92 38 %THEMEcolor% "        Sign  Out        " 92 42 %THEMEcolor% "          Cancel         " X _Button_Boxes _Button_Hover

GetInput /M %_BOX% %_Button_Boxes% /h 7f
IF %Errorlevel%==1 GOTO :SHUTDOWN.EXE
IF %Errorlevel%==2 GOTO :RESTART.EXE
IF %Errorlevel%==3 GOTO :HIBERNATE.EXE
IF %Errorlevel%==4 GOTO :LOGIN.EXE
IF %Errorlevel%==5 GOTO :DESKTOP.EXE
goto :START.POWER



:START.ALLAPPS
goto :KERNEL.EXE


:START.RIGHTCLICKAPP
call list1 %X% %Y% %THEMEcolor% "Move to top" " " "Unpin from Start" " " "_____________" " " "Pin to taskbar" " " "App settings" " " "Uninstall"
IF %ERRORLEVEL%==0 goto :DESKTOP.EXE
IF %ERRORLEVEL%==1 goto :DESKTOP.EXE
goto :START.RIGHTCLICKAPP



:START.CONTEXTMENU
IF %_TASKBAR.ALIGNMENT%==1 call list 2 28 %THEMEcolor% "Installed Apps" " " "Power Options" " " "System" " " "NIFS Management" " " "winbatchOS Management" " " "Terminal" " " "Task Manager" " " "Settings" " " "File Explorer" " " "Search" " " "Run" "_____________________" " " "Shut down" " " "Desktop"
IF %_TASKBAR.ALIGNMENT%==0 call list 85 28 %THEMEcolor% "Installed Apps" " " "Power Options" " " "System" " " "NIFS Management" " " "winbatchOS Management" " " "Terminal" " " "Task Manager" " " "Settings" " " "File Explorer" " " "Search" " " "Run" "_____________________" " " "Shut down" " " "Desktop"

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

	rem DEBUG:  IF %_APP.EXE%==0 call Text 99 23 %THEMEcolor% "No apps open." X _Button_Boxes _Button_Hover

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








:WIDGETS.EXE
	set _WIDGETS.EXE=1
	call :DESKTOP.TASKBAR
	call :DESKTOP.ICON


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

	call Text 45 2 %THEMEcolor% "%_WBX-TASKBAR-TIME% " X _Button_Boxes _Button_Hover



	call Text 10 5 %THEMEcolor% "___________________________________      _________________________________" X _Button_Boxes _Button_Hover



	call Text 10 8 %THEMEcolor% "Latest winbatchOS Release:" X _Button_Boxes _Button_Hover
	call Text 10 10 %THEMEcolor% "%Newest-Version-Release%" X _Button_Boxes _Button_Hover
	call Text 10 14 %THEMEcolor% "%Newest-Version-Release-Link%" X _Button_Boxes _Button_Hover


	rem call Text 54 8 %THEMEcolor% "Tips" X _Button_Boxes _Button_Hover
	rem call Text 54 10 %THEMEcolor% "This widget is in beta" X _Button_Boxes _Button_Hover





	call Text 10 15 %THEMEcolor% "___________________________________      _________________________________" X _Button_Boxes _Button_Hover




	call Text 10 18 %THEMEcolor% "Latest winbatchOS Beta Build Release:" X _Button_Boxes _Button_Hover
	call Text 10 20 %THEMEcolor% "%Newest-Build-Release%" X _Button_Boxes _Button_Hover
	call Text 10 24 %THEMEcolor% "%Newest-Build-Release-Link%" X _Button_Boxes _Button_Hover


	rem call Text 54 18 %THEMEcolor% "Calendar" X _Button_Boxes _Button_Hover
	rem call Text 54 20 %THEMEcolor% "This widget will be in 18.1." X _Button_Boxes _Button_Hover



	call Text 10 25 %THEMEcolor% "___________________________________      _________________________________" X _Button_Boxes _Button_Hover
	call Text 10 28 %THEMEcolor% "__________________________________________________________________________" X _Button_Boxes _Button_Hover



	call Text 10 31 %THEMEcolor% "Special News" X _Button_Boxes _Button_Hover
	call Text 10 32 %THEMEcolor% "%Special-News%" X _Button_Boxes _Button_Hover



	call Text 10 38 %THEMEcolor% "__________________________________________________________________________" X _Button_Boxes _Button_Hover

	goto :KERNEL.EXE







:ACTION.EXE

rem To make sure all features are 'shut down' correctly:
call :DESKTOP.CACHECLEAR


set M=0
set _ACTION.EXE=1
call :DESKTOP.ICON

rem 1663- outline the rounded action center more efficent
rem removed in this build due to errors

call insertphoto 1150 590 157 blank.%THEME%.bmp
call insertphoto 1148 592 157 blank.%THEME%.bmp
call insertphoto 1300 590 157 blank.%THEME%.bmp
call insertphoto 1302 592 157 blank.%THEME%.bmp



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
call :DESKTOP.CACHECLEAR


set M=0
set _NOTIFICATION.EXE=1
call :DESKTOP.ICON

::draw backgrounds

call insertphoto 1200 480 252 blank.%THEME%.bmp
call insertphoto 1198 481 252 blank.%THEME%.bmp
call insertphoto 1197 483 252 blank.%THEME%.bmp
:: Outline corners

::Top
PIXELDRAW /dl /p 1201 480 1460 480 /c 7
::Left
PIXELDRAW /dl /p 1199 482 1199 762 /c 7
::Right
PIXELDRAW /dl /p 1462 482 1462 762 /c 7
::Bottom
PIXELDRAW /dl /p 1201 764 1460 764 /c 7



Call Text 176 35 f0 "                              " X _Button_Boxes _Button_Hover
Call Text 176 38 f0 "                              " X _Button_Boxes _Button_Hover
Call Text 176 41 f0 "                              " X _Button_Boxes _Button_Hover
Call Text 176 43 f0 "                              " X _Button_Boxes _Button_Hover
Call Text 176 45 f0 "                              " X _Button_Boxes _Button_Hover
Call Text 176 47 f0 "                              " X _Button_Boxes _Button_Hover
Call Text 176 49 f0 "                              " X _Button_Boxes _Button_Hover
Call Text 176 51 f0 "                              " X _Button_Boxes _Button_Hover


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
Call Text 174 34 f0 "January %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%JAN:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%JAN:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%JAN:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%JAN:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%JAN:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%JAN:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.FEB
Call Text 174 34 f0 "Febuary %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%FEB:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%FEB:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%FEB:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%FEB:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%FEB:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%FEB:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.MAR
Call Text 174 34 f0 "March %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%MAR:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%MAR:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%MAR:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%MAR:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%MAR:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%MAR:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.APR
Call Text 174 34 f0 "April %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%APR:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%APR:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%APR:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%APR:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%APR:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%APR:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.MAY
Call Text 174 34 f0 "May %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%MAY:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%MAY:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%MAY:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%MAY:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%MAY:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%MAY:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.JUN
Call Text 174 34 f0 "June %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%JUN:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%JUN:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%JUN:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%JUN:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%JUN:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%JUN:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1


:WBX-NOTIFICATIONCENTER.JUL
Call Text 174 34 f0 "July %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%JUL:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%JUL:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%JUL:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%JUL:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%JUL:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%JUL:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.AUG
Call Text 174 34 f0 "August %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%AUG:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%AUG:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%AUG:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%AUG:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%AUG:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%AUG:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.SEP
Call Text 174 34 f0 "September %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%SEP:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%SEP:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%SEP:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%SEP:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%SEP:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%SEP:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.OCT
Call Text 174 34 f0 "October %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%OCT:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%OCT:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%OCT:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%OCT:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%OCT:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%OCT:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.NOV
Call Text 174 34 f0 "November %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%NOV:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%NOV:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%NOV:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%NOV:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%NOV:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%NOV:~105%" X _Button_Boxes _Button_Hover
goto :NOTIFICATION.EXE1

:WBX-NOTIFICATIONCENTER.DEC
Call Text 174 34 f0 "December %DATE:~-7,2%" X _Button_Boxes _Button_Hover
Call Text 181 39 f0 "%DEC:~0,20%" X _Button_Boxes _Button_Hover
Call Text 181 41 f0 "%DEC:~21,20%" X _Button_Boxes _Button_Hover
Call Text 181 43 f0 "%DEC:~42,20%" X _Button_Boxes _Button_Hover
Call Text 181 45 f0 "%DEC:~63,20%" X _Button_Boxes _Button_Hover
Call Text 181 47 f0 "%DEC:~84,20%" X _Button_Boxes _Button_Hover
Call Text 181 49 f0 "%DEC:~105%" X _Button_Boxes _Button_Hover

goto :NOTIFICATION.EXE1




:NOTIFICATION.EXE1


rem  draw backgrounds for the notification box on top of the calendar
call insertphoto 1200 310 102 UI.buttonmica.bmp
call insertphoto 1198 312 104 UI.buttonmica.bmp
call insertphoto 1200 350 102 UI.buttonmica.bmp
call insertphoto 1200 352 102 UI.buttonmica.bmp
call insertphoto 1198 348 104 UI.buttonmica.bmp



Call Text 174 22 f8 "Notifications" 182 26 f8 "No New Notifications" 199 22 f0 "Clear All" X _Button_Boxes _Button_Hover


rem  draw the line between the time and calendar listed
PIXELDRAW /dl /p 1199 520 1462 520 /c 7



rem  draw the line between the focus and calendar listed
PIXELDRAW /dl /p 1199 720 1462 720 /c 7

Call Text 174 51 f8 "Focus is incomplete." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE





rem Lastly, Text Start:


rem multitasking os:

rem for /l %%a in (0,1,64) do (cls &&set "_WBX-MEMORY-S%%a=0"
rem 	call insertphoto 0 0 85 bootimage.bmp
rem 	rem Start preloading memory lines:
rem 	for /l %%b in (0,1,64) do (set "_WBX-MEMORY-S%%aL%%b=0" &&cls &&echo Preloading Set: %%a/64 &&echo Preloading Lines: %%b/64)
rem )































rem Calculator will ABSOLUTELY use 50 digits of Pi
rem pi=3.14159265358979323846264338327950288419716939937510





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
PIXELDRAW /refresh 3f
call Text 96 25 0f "Shutting Down" X _Button_Boxes _Button_Hover

timeout /T 3 > nul


set START-STATUS=0
rem write a new data-system.bat file
(
  echo SET START-STATUS=%START-STATUS%
  echo SET FLAG-RECOVERYRESTART=%FLAG-RECOVERYRESTART%
  echo SET HIBERNATE-STATUS=%HIBERNATE-STATUS%
  echo SET RESTART-STATUS=%RESTART-STATUS%
) > CoreData\data-system.bat

exit
goto :SHUTDOWN.EXE











:RESTART.EXE
cls
PIXELDRAW /refresh 3f
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
) > CoreData\data-system.bat

cd ..
call winbatchOS.bat
exit

goto :SHUTDOWN.EXE




:HIBERNATE.EXE
cls
PIXELDRAW /refresh 3f

set START-STATUS=0
set FLAG-RECOVERYRESTART=0
set RESTART-STATUS=0
set HIBERNATE-STATUS=1

(
  echo SET START-STATUS=%START-STATUS%
  echo SET FLAG-RECOVERYRESTART=%FLAG-RECOVERYRESTART%
  echo SET HIBERNATE-STATUS=%HIBERNATE-STATUS%
  echo SET RESTART-STATUS=%RESTART-STATUS%
) > CoreData\data-system.bat


(
ECHO SET _START.EXE=0
ECHO SET _START-POWERMENU.EXE=0
ECHO SET _SEARCH.EXE=0
ECHO SET _SEARCH.DATE=0
ECHO SET _TASKVIEW.EXE=0
ECHO SET _WIDGETS.EXE=0
ECHO SET _APP.EXE=0
ECHO SET _TASKBAROVERFLOW.EXE=0
ECHO SET _ACTION.EXE=0
ECHO SET _NOTIFICATION.EXE=0


ECHO SET _ACTIVEAPPLABEL=%_ACTIVEAPPLABEL%
ECHO SET _ACTIVEAPPIMAGE=%_ACTIVEAPPIMAGE%
ECHO SET _ACTIVEAPPTITLE=%_ACTIVEAPPTITLE%


ECHO SET _BATCHINSTALLER.EXE=%_BATCHINSTALLER.EXE%

ECHO SET _CALCULATOR.EXE=%_CALCULATOR.EXE%
ECHO SET "_CALCULATOR.FINAL=%_CALCULATOR.FINAL%"

ECHO SET "_CALCULATOR.DIGIT1=%_CALCULATOR.DIGIT1%"
ECHO SET "_CALCULATOR.DIGIT2=%_CALCULATOR.DIGIT2%"
ECHO SET "_CALCULATOR.OPERAT=%_CALCULATOR.OPERAT%"

ECHO SET _CALENDAR.EXE=%_CALENDAR.EXE%

ECHO SET _CLOCK.EXE=%_CLOCK.EXE%

ECHO SET _DESKTOP.EXE=%_DESKTOP.EXE%

ECHO SET _EDGE.EXE=%_EDGE.EXE%

ECHO SET _EXPLORER.EXE=%_EXPLORER.EXE%

ECHO SET _FEEDBACKHUB.EXE=%_FEEDBACKHUB.EXE%

ECHO SET _NOTEPAD.EXE=%_NOTEPAD.EXE%

ECHO SET _PAINT.EXE=%_PAINT.EXE%
ECHO SET _PAINT.COLOR=%_PAINT.COLOR%

ECHO SET _PHOTOS.EXE=%_PHOTOS.EXE%

ECHO SET _RUN.EXE=%_RUN.EXE%

ECHO SET _SETTINGS.EXE=%_SETTINGS.EXE%
ECHO SET _SETTINGS.SECTION=%_SETTINGS.SECTION%

ECHO SET _SECURITY.EXE=%_SECURITY.EXE%

ECHO SET _TERMINAL.EXE=%_TERMINAL.EXE%

ECHO SET _SNIPTOOL.EXE=%_SNIPTOOL.EXE%

ECHO SET _TASKMGR.EXE=%_TASKMGR.EXE%

ECHO SET _TIPS.EXE=%_TIPS.EXE%

ECHO SET _APP.EXE=%_APP.EXE%
) > CoreData\hibernationfile.bat

exit
goto :HIBERNATE.EXE












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
CALL Text 8 47 %lightTHEMEcolor% "Type the name of a program or executable," 8 48 %lightTHEMEcolor% "and winbatchOS will open it for you." X _Button_Boxes _Button_Hover

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








































rem winbatchOS API
rem This is licenced techinally under the Unlicense License up until the official release of winbatchOS 23
rem after winbatchOS 23 is released this is now licensed under the Microsoft Public License (Ms-PL)


rem ALL API's SHOULD BE CALLED!!

:KERNEL.API.BUILTIN.APPSTART
call :DESKTOP.CACHECLEAR
set _APP.EXE=1
exit /b

:KERNEL.API.BUILTIN.APPCLOSE

SET _APP.EXE=0
SET _%_ACTIVEAPPLABEL%=0

SET _ACTIVEAPPLABEL=desktop.exe
SET _ACTIVEAPPIMAGE=explorer
SET _ACTIVEAPPTITLE=winbatchOS

exit /b



















































































































































































































:DISKWRITE.EXE

:: WBXFS 2000
:: This software is based on the Ms-PT License.

:: WBXFS: winbatchOS's New Interface File System
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

If /i "%~1" == "ver" (echo. &&echo WBXFS &&echo Version %WBXFS_VERSION%, Build %WBXFS_BUILDVERSION%. WBXFS is under the Ms-PT License. &&echo.)
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













































































































































rem  Notepad App

:NOTEPAD.EXE
set _APP.EXE=1

IF %_NOTEPAD.EXE%==1 goto :NOTEPAD.LOOP
set _ACTIVEAPPLABEL=notepad.exe
set _ACTIVEAPPIMAGE=notepad
SET _ACTIVEAPPTITLE=Notepad
call :KERNEL.API.BUILTIN.APPSTART

set _NOTEPAD.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 notepad.%THEME%.bmp
 
call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul

rem  call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


:NOTEPAD.LOOP

call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 25 12 8 notepad.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

call insertphoto 1452 38 115 UI.setting.bmp


CALL Text 8 0 %THEMEcolor% "Notepad Beta" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 65 1490 65 /c 0


CALL Text 1 2 %lightTHEMEcolor% "File    Edit    View" X _Button_Boxes _Button_Hover
rem  For saving paint (later, in the works)-- test: nircmd savescreenshot "shot.png" 50 50 300 200

call :DESKTOP.TASKBAR
call :DESKTOP.ICON
rem  PIXELDRAW /refresh 3f

set _ACTIVEAPPLABEL=notepad.exe

call Text 1 5 %THEMEcolor% "Start Typing... (type 'exit' to exit)                 " X _Button_Boxes _Button_Hover

call Text 1 7 %THEMEcolor% " " X _Button_Boxes _Button_Hover

set /p notepadkey1=
IF %notepadkey1%==exit goto :DESKTOP.EXE

call Text 1 7 %THEMEcolor% " " X _Button_Boxes _Button_Hover

set /p file=Enter a file name: 
call Text 1 7 %THEMEcolor% " " X _Button_Boxes _Button_Hover

set /p extension=Enter a file extension: 

(
  echo %notepadkey1%
) > ../%file%.%extension%

call Text 1 5 fa "File Saved. It is in the main folder (the folder behind the system folder)" X _Button_Boxes _Button_Hover
timeout /T 5 > nul
call :DESKTOP.CACHECLEAR
goto :DESKTOP.EXE


































rem  Paint App

:PAINT.EXE
set _APP.EXE=1

IF %_PAINT.EXE%==1 goto :PAINT.LOOP
set _ACTIVEAPPLABEL=paint.exe
set _ACTIVEAPPIMAGE=paint
SET _ACTIVEAPPTITLE=Paint
call :KERNEL.API.BUILTIN.APPSTART

set _PAINT.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 paint.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul

rem  call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


rem  PIXELDRAW /refresh 3f

:PAINT.LOOP
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 25 12 8 paint.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

call insertphoto 145 38 115 ui.save.bmp

call insertphoto 205 38 115 ui.undo.bmp
call insertphoto 245 38 115 ui.redo.bmp

call insertphoto 1452 38 115 UI.setting.bmp


CALL Text 8 0 %THEMEcolor% "Paint - Untitled" 25 0 %lightTHEMEcolor% "BETA" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 65 1490 65 /c 0


CALL Text 1 2 %THEMEcolor% "File" X _Button_Boxes _Button_Hover
CALL Text 9 2 %THEMEcolor% "View" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 135 1490 135 /c 0


CALL Text 20 5 00 "    " X _Button_Boxes _Button_Hover
CALL Text 20 6 00 "    " X _Button_Boxes _Button_Hover

CALL Text 25 5 44 "    " X _Button_Boxes _Button_Hover
CALL Text 25 6 44 "    " X _Button_Boxes _Button_Hover

CALL Text 30 5 cc "    " X _Button_Boxes _Button_Hover
CALL Text 30 6 cc "    " X _Button_Boxes _Button_Hover

CALL Text 35 5 66 "    " X _Button_Boxes _Button_Hover
CALL Text 35 6 66 "    " X _Button_Boxes _Button_Hover

CALL Text 40 5 ee "    " X _Button_Boxes _Button_Hover
CALL Text 40 6 ee "    " X _Button_Boxes _Button_Hover

CALL Text 45 5 aa "    " X _Button_Boxes _Button_Hover
CALL Text 45 6 aa "    " X _Button_Boxes _Button_Hover

CALL Text 50 5 22 "    " X _Button_Boxes _Button_Hover
CALL Text 50 6 22 "    " X _Button_Boxes _Button_Hover

CALL Text 55 5 bb "    " X _Button_Boxes _Button_Hover
CALL Text 55 6 bb "    " X _Button_Boxes _Button_Hover

CALL Text 60 5 33 "    " X _Button_Boxes _Button_Hover
CALL Text 60 6 33 "    " X _Button_Boxes _Button_Hover

CALL Text 65 5 99 "    " X _Button_Boxes _Button_Hover
CALL Text 65 6 99 "    " X _Button_Boxes _Button_Hover

CALL Text 70 5 11 "    " X _Button_Boxes _Button_Hover
CALL Text 70 6 11 "    " X _Button_Boxes _Button_Hover

CALL Text 75 5 55 "    " X _Button_Boxes _Button_Hover
CALL Text 75 6 55 "    " X _Button_Boxes _Button_Hover

CALL Text 80 5 dd "    " X _Button_Boxes _Button_Hover
CALL Text 80 6 dd "    " X _Button_Boxes _Button_Hover








CALL Text 50 7 %THEMEcolor% "Color" X _Button_Boxes _Button_Hover

call insertphoto 50 150 120 blankloadapp.white.bmp

call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=paint.exe

goto :KERNEL.EXE




























































rem  Settings App

:SETTINGS.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=settings.exe
set _ACTIVEAPPIMAGE=settings
SET "_ACTIVEAPPTITLE=Settings Beta"
call :KERNEL.API.BUILTIN.APPSTART
IF %_SETTINGS.EXE%==1 goto :SETTINGS.LOOP

set _SETTINGS.SECTION=SYSTEM

set _SETTINGS.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c f
PIXELDRAW /dr 0 0 /rd 1490 784 /c f
PIXELDRAW /dr 0 0 /rd 1490 785 /c f
PIXELDRAW /dl /p 0 785 1490 785 /c 8

call insertphoto 730 330 40 Settings.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 2 > nul

:SETTINGS.LOOP
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c f
PIXELDRAW /dr 0 0 /rd 1490 784 /c f
PIXELDRAW /dr 0 0 /rd 1490 785 /c f
PIXELDRAW /dl /p 0 785 1490 785 /c 8
rem  PIXELDRAW /dl /p 0 35 1490 35 /c 8

rem  Theres no icon in the settings app
rem  call insertphoto 25 12 8 settings.bmp
call insertphoto 25 12 110 ui.left.bmp
call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp
CALL Text 8 0 %THEMEcolor% "Settings Beta" X _Button_Boxes _Button_Hover

call :SETTINGS.NAVIGATION
call :DESKTOP.TASKBAR
call :DESKTOP.ICON

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

IF %_SETTINGS.SECTION%==PERSONALIZATION.COLOR goto :SETTINGS.PERSONALIZATION.COLOR
IF %_SETTINGS.SECTION%==PERSONALIZATION.TASKBAR goto :SETTINGS.PERSONALIZATION.TASKBAR

IF %_SETTINGS.SECTION%==APPS goto :SETTINGS.APPS

IF %_SETTINGS.SECTION%==ACCOUNTS goto :SETTINGS.ACCOUNTS

IF %_SETTINGS.SECTION%==TIMELANGUAGE goto :SETTINGS.TIMELANGUAGE

IF %_SETTINGS.SECTION%==ACCESSIBILITY goto :SETTINGS.ACCESSIBILITY

IF %_SETTINGS.SECTION%==PRIVACYSECURITY goto :SETTINGS.SYSTEM.PRIVACYSECURITY

IF %_SETTINGS.SECTION%==UPDATE goto :SETTINGS.UPDATE

goto :SETTINGS.SYSTEM





:SETTINGS.SYSTEM
set _SETTINGS.SECTION=SYSTEM
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %THEMEcolor% "System" X _Button_Boxes _Button_Hover


PIXELDRAW /dr 399 99 /rd 196 124 /c f
call insertphoto 400 100 10 "%BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp"

call insertphoto 1040 126 150 settings-update-icon.bmp

CALL Text 152 8 %THEMEcolor% "winbatchOS Update" X _Button_Boxes _Button_Hover
CALL Text 152 9 %lightTHEMEcolor% "%_WBXCore-updatemessage%" X _Button_Boxes _Button_Hover


CALL Text 85 6 %THEMEcolor% "%_HOSTNAME-winbatchOS%" X _Button_Boxes _Button_Hover
CALL Text 85 8 %lightTHEMEcolor% "Reset PC (Soon)" X _Button_Boxes _Button_Hover
CALL Text 85 10 %blueTHEMEcolor% "Rename" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 400 230 /rd 800 40 /c 7
CALL Text 65 16 %THEMEcolor% "Display" X _Button_Boxes _Button_Hover
CALL Text 65 17 %lightTHEMEcolor% "Zoom Size, image display, system responsiveness" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 273 /rd 800 40 /c 7
CALL Text 65 19 %THEMEcolor% "Sound" X _Button_Boxes _Button_Hover
CALL Text 65 20 %lightTHEMEcolor% "Volume, troubleshooting" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 316 /rd 800 40 /c 7
CALL Text 65 22 %THEMEcolor% "Notifications" X _Button_Boxes _Button_Hover
CALL Text 65 23 %lightTHEMEcolor% "Alerts from your apps and pc" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 359 /rd 800 40 /c 7
CALL Text 65 25 %lightTHEMEcolor% "Focus" X _Button_Boxes _Button_Hover
CALL Text 65 26 %lightTHEMEcolor% "Notifications, user rules" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 402 /rd 800 40 /c 7
CALL Text 65 28 %THEMEcolor% "Power" X _Button_Boxes _Button_Hover
CALL Text 65 29 %lightTHEMEcolor% "Startup settings, Shutdown, Services" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 445 /rd 800 40 /c 7
CALL Text 65 31 %THEMEcolor% "Storage" X _Button_Boxes _Button_Hover
CALL Text 65 32 %lightTHEMEcolor% "Manage filesystem" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 488 /rd 800 40 /c 7
CALL Text 65 34 %THEMEcolor% "Single/Multi Window Settings" X _Button_Boxes _Button_Hover
CALL Text 65 35 %lightTHEMEcolor% "Side-to-side apps, full apps, windowed apps, desktops" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 531 /rd 800 40 /c 7
CALL Text 65 37 %lightTHEMEcolor% "Troubleshoot" X _Button_Boxes _Button_Hover
CALL Text 65 38 %lightTHEMEcolor% "Fix problems" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 574 /rd 800 40 /c 7
CALL Text 65 40 %THEMEcolor% "Recovery" X _Button_Boxes _Button_Hover
CALL Text 65 41 %lightTHEMEcolor% "Advanced Startup, Recovery Enviroment" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 617 /rd 800 40 /c 7
CALL Text 65 43 %lightTHEMEcolor% "Clipboard" X _Button_Boxes _Button_Hover
CALL Text 65 44 %lightTHEMEcolor% "Copy, Cut, Paste, Clear, History" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 660 /rd 800 40 /c 7
CALL Text 65 46 %THEMEcolor% "About" X _Button_Boxes _Button_Hover
CALL Text 65 47 %lightTHEMEcolor% "Device infomation, winbatchOS and windows version" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE





















:SETTINGS.SYSTEM.DISPLAY
set _SETTINGS.SECTION=SYSTEM.DISPLAY
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Display" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 450 124 /rd 500 20 /c 7
CALL Text 65 8 %THEMEcolor% "These settings apply only to the command line display." X _Button_Boxes _Button_Hover
CALL Text 122 8 3f " Ok " X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 180 /rd 800 40 /c 7
CALL Text 65 12 %blueTHEMEcolor% "Animation Effects" X _Button_Boxes _Button_Hover
CALL Text 159 13 %blueTHEMEcolor% "Off (Disabled)" X _Button_Boxes _Button_Hover
CALL Text 65 13 %THEMEcolor% "Try clearing up other apps on your Windows PC to see possible changes." X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 230 /rd 800 40 /c 7
CALL Text 65 16 %blueTHEMEcolor% "Display Resolution" X _Button_Boxes _Button_Hover
CALL Text 150 17 %blueTHEMEcolor% "1920x1080 (recommended)" X _Button_Boxes _Button_Hover
CALL Text 65 17 %lightTHEMEcolor% "Scale of winbatchOS based on your screen resolution" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE



















:SETTINGS.SYSTEM.SOUND
set _SETTINGS.SECTION=SYSTEM.SOUND
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Sound" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL Text 65 10 %blueTHEMEcolor% "Volume" X _Button_Boxes _Button_Hover
CALL Text 130 11 %blueTHEMEcolor% "               Unavailable                " X _Button_Boxes _Button_Hover
CALL Text 65 11 %THEMEcolor% "This feature is unavailable on winbatchOS 18." X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 205 /rd 800 120 /c 7
CALL Text 65 14 %lightTHEMEcolor% "Sounds enabled:" X _Button_Boxes _Button_Hover
CALL Text 65 15 %lightTHEMEcolor% "Toggle these on or off" X _Button_Boxes _Button_Hover

CALL Text 65 17 %lightTHEMEcolor% "Windows Sound on startup" X _Button_Boxes _Button_Hover
CALL Text 65 19 %lightTHEMEcolor% "Notification Sounds" X _Button_Boxes _Button_Hover
CALL Text 65 21 %lightTHEMEcolor% "User account control sounds" X _Button_Boxes _Button_Hover

CALL Text 65 40 %THEMEcolor% "For more audio/sound settings, open Windows Settings to configure them." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE
















:SETTINGS.SYSTEM.NOTIFICATION
set _SETTINGS.SECTION=SYSTEM.NOTIFICATION
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Notifications" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL Text 65 10 %THEMEcolor% "Notifications" X _Button_Boxes _Button_Hover
CALL Text 65 11 %lightTHEMEcolor% "Updates from external apps on winbatchOS" X _Button_Boxes _Button_Hover

IF %NOTIFICATIONS%==0 CALL Text 170 11 %blueTHEMEcolor% "No  " X _Button_Boxes _Button_Hover
IF %NOTIFICATIONS%==1 CALL Text 170 11 %blueTHEMEcolor% "Yes " X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 205 /rd 800 40 /c 7
CALL Text 65 14 %THEMEcolor% "Do Not Disturb" X _Button_Boxes _Button_Hover
CALL Text 65 15 %lightTHEMEcolor% "Notifications will go to the notification center" X _Button_Boxes _Button_Hover
CALL Text 161 15 %lightTHEMEcolor% "Unavailable" X _Button_Boxes _Button_Hover


PIXELDRAW /dr 450 255 /rd 800 320 /c 7
CALL Text 65 18 %THEMEcolor% "Notifications from apps or scripts" X _Button_Boxes _Button_Hover
CALL Text 65 19 %lightTHEMEcolor% "Based on all current or past app senders" X _Button_Boxes _Button_Hover

CALL Text 160 19 %blueTHEMEcolor% "Not available" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE
















:SETTINGS.SYSTEM.POWER
set _SETTINGS.SECTION=SYSTEM.POWER
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Power" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL Text 65 10 %blueTHEMEcolor% "Startup" X _Button_Boxes _Button_Hover
CALL Text 65 11 %THEMEcolor% "winbatchOS 18 does not have a recovery environment." X _Button_Boxes _Button_Hover
CALL Text 160 11 %THEMEcolor% "0 seconds" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE













:SETTINGS.SYSTEM.STORAGE
set _SETTINGS.SECTION=SYSTEM.STORAGE
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Storage" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 100 /rd 800 300 /c 7
CALL Text 57 7 %lightTHEMEcolor% "winbatchOS File System" 80 7 %blueTHEMEcolor% "BETA" X _Button_Boxes _Button_Hover

CALL Text 60 12 %lightTHEMEcolor% "winbatchOS 19 is currently supporting an expermential file system named WBXFS (winbatchOS FileSystem). It is" X _Button_Boxes _Button_Hover
CALL Text 60 13 %lightTHEMEcolor% "expermential and some features are incomplete. Report bugs to winbatchOS's wiki page." X _Button_Boxes _Button_Hover
CALL Text 60 15 %lightTHEMEcolor% "There is no way to use it on winbatchOS graphically right now." X _Button_Boxes _Button_Hover


CALL Text 60 22 %THEMEcolor% "winbatchOS Disk 1" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE









:SETTINGS.SYSTEM.MULTITASKING
set _SETTINGS.SECTION=SYSTEM.MULTITASKING
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Window Settings" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL Text 65 10 %blueTHEMEcolor% "Windowed Mode on all apps is not set up in this build of winbatchOS." X _Button_Boxes _Button_Hover
CALL Text 65 11 %lightTHEMEcolor% "It is still in beta." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE















:SETTINGS.SYSTEM.TROUBLESHOOT
set _SETTINGS.SECTION=SYSTEM.TROUBLESHOOT
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Troubleshoot" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL Text 65 10 %blueTHEMEcolor% "Troubleshooting is not available on alpha builds of winbatchOS right now. Report a bug," X _Button_Boxes _Button_Hover
CALL Text 65 11 %blueTHEMEcolor% "or upgrade to the next build to see more changes or fixes." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE















:SETTINGS.SYSTEM.RECOVERY
set _SETTINGS.SECTION=SYSTEM.RECOVERY
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Recovery" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL Text 65 10 %lightTHEMEcolor% "Restart to the winbatchOS recovery enviroment" X _Button_Boxes _Button_Hover
CALL Text 65 11 %lightTHEMEcolor% "Unavailable" X _Button_Boxes _Button_Hover
CALL Text 160 11 %lightTHEMEcolor% "Get Started" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 205 /rd 800 40 /c 7
CALL Text 65 14 %blueTHEMEcolor% "Reset your winbatchOS Computer" X _Button_Boxes _Button_Hover
CALL Text 65 15 %blueTHEMEcolor% "Before trying this option, try troubleshooting the issue" X _Button_Boxes _Button_Hover
CALL Text 160 14 %blueTHEMEcolor% "Reset winbatchOS" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE






:SETTINGS.RECOVERY.RESET
set _SETTINGS.SECTION=SYSTEM.RECOVERY.RESET


rem  THIS IS A POP-UP
rem  Clear the center up
PIXELDRAW /dr 578 304 /rd 525 275 /c 8
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
rem  call insertphoto 1075 315 130 UI.context.close.bmp

CALL Text 83 22 %THEMEcolor% "Reset winbatchOS" X _Button_Boxes _Button_Hover
CALL Text 83 25 %THEMEcolor% "Are you sure you want to reset and powerwash?" X _Button_Boxes _Button_Hover

CALL Text 83 27 f4 "This feature is only on winbatchOS Build 1806 until later." X _Button_Boxes _Button_Hover
CALL Text 83 28 %blueTHEMEcolor% "Get winbatchOS Build 1806 in the alpha channel for reseting" X _Button_Boxes _Button_Hover

call insertphoto 650 450 40 UI.buttonblue.bmp
call insertphoto 649 451 40 UI.buttonblue.bmp
call insertphoto 651 454 40 UI.buttonblue.bmp

call insertphoto 920 450 40 UI.buttongray.bmp
call insertphoto 919 451 40 UI.buttongray.bmp
call insertphoto 921 454 40 UI.buttongray.bmp
CALL Text 93 32 38 "Reset" X _Button_Boxes _Button_Hover
CALL Text 133 32 %THEMEcolor% "Cancel" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE













:SETTINGS.SYSTEM.CLIPBOARD
set _SETTINGS.SECTION=SYSTEM.CLIPBOARD
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   Clipboard" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 150 /rd 800 40 /c 7
CALL Text 65 10 %blueTHEMEcolor% "Clipboard is still incomplete" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE














:SETTINGS.SYSTEM.ABOUT
set _SETTINGS.SECTION=SYSTEM.ABOUT

:: Find the Windows Version

For /f "tokens=1,2 delims=." %%A in ('ver') do (
	For /f "tokens=4" %%C in ("%%A") do (
		Set _Ver=%%C.%%B
	)
)

If /i "%_Ver%" == "4.0" (Set _winver-winbatchOS=NT 4.0)
If /i "%_Ver%" == "5.1" (Set _winver-winbatchOS=XP)
If /i "%_Ver%" == "6.0" (Set _winver-winbatchOS=Vista)
If /i "%_Ver%" == "6.1" (Set _winver-winbatchOS=7)
If /i "%_Ver%" == "6.2" (Set _winver-winbatchOS=8)
If /i "%_Ver%" == "6.3" (Set _winver-winbatchOS=8.1)
If /i "%_Ver%" == "10.0" (Set _winver-winbatchOS=10/11)

If /i "%_winver-winbatchOS%" == "" (Set _winver-winbatchOS=Unknown)

:: architecture of os
IF Not Defined ProgramFiles(x86) (Set _Type=x86) ELSE (Set _Type=x64)


call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

PIXELDRAW /dr 450 95 /rd 800 40 /c 7
CALL Text 55 4 %blueTHEMEcolor% "System" 61 4 %THEMEcolor% "   >   About" X _Button_Boxes _Button_Hover
CALL Text 65 6 %THEMEcolor% "%_HOSTNAME-winbatchOS%" 166 6 %blueTHEMEcolor% "Rename PC" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 450 140 /rd 800 120 /c 7
CALL Text 65 10 %blueTHEMEcolor% "Windows Infomation" 170 10 %lightTHEMEcolor% "Copy" X _Button_Boxes _Button_Hover

CALL Text 65 12 %THEMEcolor% "Windows" 80 12 %lightTHEMEcolor% "%_winver-winbatchOS%" X _Button_Boxes _Button_Hover
CALL Text 65 13 %THEMEcolor% "Architecture" 80 13 %lightTHEMEcolor% "%_Type%" X _Button_Boxes _Button_Hover

CALL Text 65 15 %lightTHEMEcolor% "The infomation above may not be accurate." X _Button_Boxes _Button_Hover



PIXELDRAW /dr 450 265 /rd 800 90 /c 7

call insertphoto 460 280 25 ui.wbxicon.bmp

CALL Text 75 20 %THEMEcolor% "winbatchOS" 100 20 %lightTHEMEcolor% "%_version%" X _Button_Boxes _Button_Hover
CALL Text 75 21 %THEMEcolor% "Build " 100 21 %lightTHEMEcolor% "%_build%" X _Button_Boxes _Button_Hover
CALL Text 75 22 %THEMEcolor% "Kernel Version" 100 22 %lightTHEMEcolor% "%_quantum-ver%" X _Button_Boxes _Button_Hover

CALL Text 65 2 %lightTHEMEcolor% " Microsoft Public License (Ms-PL)" X _Button_Boxes _Button_Hover
CALL Text 65 3 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 4 %lightTHEMEcolor% " This license governs use of the accompanying software. If you use the" X _Button_Boxes _Button_Hover
CALL Text 65 5 %lightTHEMEcolor% " software, you accept this license. If you do not accept the license, do not" X _Button_Boxes _Button_Hover
CALL Text 65 6 %lightTHEMEcolor% " use the software." X _Button_Boxes _Button_Hover
CALL Text 65 7 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 8 %lightTHEMEcolor% " 1.  Definitions" X _Button_Boxes _Button_Hover
CALL Text 65 9 %lightTHEMEcolor% " The terms 'reproduce,' 'reproduction,' 'derivative works,' and 'distribution'" X _Button_Boxes _Button_Hover
CALL Text 65 10 %lightTHEMEcolor% " have the same meaning here as under U.S. copyright law. A 'contribution' is" X _Button_Boxes _Button_Hover
CALL Text 65 11 %lightTHEMEcolor% " the original software, or any additions or changes to the software. A" X _Button_Boxes _Button_Hover
CALL Text 65 12 %lightTHEMEcolor% " 'contributor' is any person that distributes its contribution under this" X _Button_Boxes _Button_Hover
CALL Text 65 13 %lightTHEMEcolor% " license. 'Licensed patents' are a contributor's patent claims that read" X _Button_Boxes _Button_Hover
CALL Text 65 14 %lightTHEMEcolor% " directly on its contribution." X _Button_Boxes _Button_Hover
CALL Text 65 15 %lightTHEMEcolor% ". " X _Button_Boxes _Button_Hover
CALL Text 65 16 %lightTHEMEcolor% " 2.  Grant of Rights" X _Button_Boxes _Button_Hover
CALL Text 65 17 %lightTHEMEcolor% "      (A) Copyright Grant- Subject to the terms of this license, including the" X _Button_Boxes _Button_Hover
CALL Text 65 18 %lightTHEMEcolor% "      license conditions and limitations in section 3, each contributor grants" X _Button_Boxes _Button_Hover
CALL Text 65 19 %lightTHEMEcolor% "      you a non-exclusive, worldwide, royalty-free copyright license to" X _Button_Boxes _Button_Hover
CALL Text 65 20 %lightTHEMEcolor% "      reproduce its contribution, prepare derivative works of its contribution," X _Button_Boxes _Button_Hover
CALL Text 65 21 %lightTHEMEcolor% "      and distribute its contribution or any derivative works that you create." X _Button_Boxes _Button_Hover
CALL Text 65 22 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 23 %lightTHEMEcolor% "      (B) Patent Grant- Subject to the terms of this license, including the" X _Button_Boxes _Button_Hover
CALL Text 65 24 %lightTHEMEcolor% "      license conditions and limitations in section 3, each contributor grants" X _Button_Boxes _Button_Hover
CALL Text 65 25 %lightTHEMEcolor% "      you a non-exclusive, worldwide, royalty-free license under its licensed" X _Button_Boxes _Button_Hover
CALL Text 65 26 %lightTHEMEcolor% "      patents to make, have made, use, sell, offer for sale, import, and/or" X _Button_Boxes _Button_Hover
CALL Text 65 27 %lightTHEMEcolor% "      otherwise dispose of its contribution in the software or derivative works" X _Button_Boxes _Button_Hover
CALL Text 65 28 %lightTHEMEcolor% "      of the contribution in the software." X _Button_Boxes _Button_Hover
CALL Text 65 29 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 30 %lightTHEMEcolor% " 3.  Conditions and Limitations" X _Button_Boxes _Button_Hover
CALL Text 65 31 %lightTHEMEcolor% "      (A) No Trademark License- This license does not grant you rights to use" X _Button_Boxes _Button_Hover
CALL Text 65 32 %lightTHEMEcolor% "      any contributors' name, logo, or trademarks." X _Button_Boxes _Button_Hover
CALL Text 65 33 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 34 %lightTHEMEcolor% "      (B) If you bring a patent claim against any contributor over patents that" X _Button_Boxes _Button_Hover
CALL Text 65 35 %lightTHEMEcolor% "      you claim are infringed by the software, your patent license from such" X _Button_Boxes _Button_Hover
CALL Text 65 36 %lightTHEMEcolor% "      contributor to the software ends automatically." X _Button_Boxes _Button_Hover
CALL Text 65 37 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 38 %lightTHEMEcolor% "      (C) If you distribute any portion of the software, you must retain all" X _Button_Boxes _Button_Hover
CALL Text 65 39 %lightTHEMEcolor% "      copyright, patent, trademark, and attribution notices that are present in" X _Button_Boxes _Button_Hover
CALL Text 65 40 %lightTHEMEcolor% "      the software." X _Button_Boxes _Button_Hover
CALL Text 65 41 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 42 %lightTHEMEcolor% "      (D) If you distribute any portion of the software in source code form," X _Button_Boxes _Button_Hover
CALL Text 65 43 %lightTHEMEcolor% "      you may do so only under this license by including a complete copy of" X _Button_Boxes _Button_Hover
CALL Text 65 44 %lightTHEMEcolor% "      this license with your distribution. If you distribute any portion of the" X _Button_Boxes _Button_Hover
CALL Text 65 45 %lightTHEMEcolor% "      software in compiled or object code form, you may only do so under a" X _Button_Boxes _Button_Hover
CALL Text 65 46 %lightTHEMEcolor% "      license that complies with this license." X _Button_Boxes _Button_Hover
CALL Text 65 47 %lightTHEMEcolor% "." X _Button_Boxes _Button_Hover
CALL Text 65 48 %lightTHEMEcolor% "      (E) The software is licensed 'as-is.' You bear the risk of using it. The" X _Button_Boxes _Button_Hover
CALL Text 65 49 %lightTHEMEcolor% "      contributors give no express warranties, guarantees, or conditions. You" X _Button_Boxes _Button_Hover
CALL Text 65 50 %lightTHEMEcolor% "      may have additional consumer rights under your local laws which this" X _Button_Boxes _Button_Hover
CALL Text 65 51 %lightTHEMEcolor% "      license cannot change. To the extent permitted under your local laws, the" X _Button_Boxes _Button_Hover
CALL Text 65 52 %lightTHEMEcolor% "      contributors exclude the implied warranties of merchantability, fitness" X _Button_Boxes _Button_Hover
CALL Text 65 53 %lightTHEMEcolor% "      for a particular purpose and non-infringement." X _Button_Boxes _Button_Hover





rem Bug check to prevent wrong errors at next startup of the settings page
rem also part of privacy of a computer

set _Ver=0.0
set _Type=x00
set _winver-winbatchOS=0

goto :KERNEL.EXE















:SETTINGS.PERSONALIZATION
set _SETTINGS.SECTION=PERSONALIZATION
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp

CALL Text 55 4 %THEMEcolor% "Personalization" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 399 99 /rd 386 242 /c 8
call insertphoto 400 100 20 "%BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp"

CALL Text 112 6 %THEMEcolor% "Select a theme to apply" X _Button_Boxes _Button_Hover
	
CALL Text 125 14 %lightTHEMEcolor% "Unavailable." X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 400 385 /rd 800 40 /c 7
CALL Text 65 27 %lightTHEMEcolor% "Background" X _Button_Boxes _Button_Hover
CALL Text 65 28 %lightTHEMEcolor% "Default Image, Solid color" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 428 /rd 800 40 /c 7
CALL Text 65 30 %THEMEcolor% "Color" X _Button_Boxes _Button_Hover
CALL Text 65 31 %lightTHEMEcolor% "Accent color, transparency effects, light/dark theme" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 471 /rd 800 40 /c 7
CALL Text 65 33 %lightTHEMEcolor% "Themes" X _Button_Boxes _Button_Hover
CALL Text 65 34 %lightTHEMEcolor% "Create, manage" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 514 /rd 800 40 /c 7
CALL Text 65 36 %lightTHEMEcolor% "Lock screen" X _Button_Boxes _Button_Hover
CALL Text 65 37 %lightTHEMEcolor% "Default image, app Notifications" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 557 /rd 800 40 /c 7
CALL Text 65 39 %lightTHEMEcolor% "Touch Keyboard" X _Button_Boxes _Button_Hover
CALL Text 65 40 %lightTHEMEcolor% "Themes, size, " X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 600 /rd 800 40 /c 7
CALL Text 65 42 %lightTHEMEcolor% "Start" X _Button_Boxes _Button_Hover
CALL Text 65 43 %lightTHEMEcolor% "Pinned, Recomended, Folders" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 643 /rd 800 40 /c 7
CALL Text 65 45 %THEMEcolor% "Taskbar" X _Button_Boxes _Button_Hover
CALL Text 65 46 %lightTHEMEcolor% "Taskbar alignment, hide/show taskbar" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE










:SETTINGS.PERSONALIZATION.COLOR
set _SETTINGS.SECTION=PERSONALIZATION.COLOR
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "Personalization" 70 4 %THEMEcolor% "   >   Color" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 399 99 /rd 386 242 /c 8
call insertphoto 400 100 20 "%BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp"

PIXELDRAW /dr 400 370 /rd 800 180 /c 7
CALL Text 65 26 %blueTHEMEcolor% "Choose your mode" X _Button_Boxes _Button_Hover
CALL Text 65 27 %lightTHEMEcolor% "Change the colors that appear in winbatchOS and built-in apps" X _Button_Boxes _Button_Hover

IF %THEME%==dark CALL Text 140 27 %blueTHEMEcolor% "Dark" X _Button_Boxes _Button_Hover
IF %THEME%==light CALL Text 140 27 %blueTHEMEcolor% "Light" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE



:SETTINGS.PERSONALIZATION.TASKBAR
set _SETTINGS.SECTION=PERSONALIZATION.TASKBAR
call :SETTINGS.NAVIGATION

call :SETTINGS.CLEARPAGE

CALL Text 55 4 %blueTHEMEcolor% "Personalization" 70 4 %THEMEcolor% "   >   Taskbar" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 140 /rd 800 180 /c 7
CALL Text 65 10 %blueTHEMEcolor% "Taskbar Items" X _Button_Boxes _Button_Hover
CALL Text 65 11 %lightTHEMEcolor% "Show certain icons on the taskbar" X _Button_Boxes _Button_Hover

CALL Text 65 13 fc "The settings below are not available yet on winbatchOS." X _Button_Boxes _Button_Hover
CALL Text 65 14 %lightTHEMEcolor% "Search" X _Button_Boxes _Button_Hover
CALL Text 65 16 %lightTHEMEcolor% "Task View" X _Button_Boxes _Button_Hover
CALL Text 65 18 %lightTHEMEcolor% "Widgets" X _Button_Boxes _Button_Hover
CALL Text 65 20 %lightTHEMEcolor% "Taskbar Overflow" X _Button_Boxes _Button_Hover

IF %_TASKBAR.ALIGNMENT%==0 CALL Text 120 24 %blueTHEMEcolor% "Center" X _Button_Boxes _Button_Hover
IF %_TASKBAR.ALIGNMENT%==1 CALL Text 120 24 %blueTHEMEcolor% "Left" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 330 /rd 800 40 /c 7
CALL Text 65 23 %blueTHEMEcolor% "Taskbar Alignment" X _Button_Boxes _Button_Hover
CALL Text 65 24 %lightTHEMEcolor% "Toggle the Text on the right." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE













:SETTINGS.APPS
set _SETTINGS.SECTION=APPS
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp

CALL Text 55 4 %THEMEcolor% "Apps" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 400 90 /rd 800 40 /c 7
CALL Text 65 6 %lightTHEMEcolor% "Installed Apps" X _Button_Boxes _Button_Hover
CALL Text 65 7 %lightTHEMEcolor% "Manage apps on winbatchOS" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 133 /rd 800 40 /c 7
CALL Text 65 9 %lightTHEMEcolor% "Advanced App Settings" X _Button_Boxes _Button_Hover
CALL Text 65 10 %lightTHEMEcolor% "Choose where apps are coming from, uninstall updates" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 176 /rd 800 40 /c 7
CALL Text 65 12 %lightTHEMEcolor% "Default apps" X _Button_Boxes _Button_Hover
CALL Text 65 13 %lightTHEMEcolor% "Default app opening for files" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 219 /rd 800 40 /c 7
CALL Text 65 15 %lightTHEMEcolor% "Optional features" X _Button_Boxes _Button_Hover
CALL Text 65 16 %lightTHEMEcolor% "Extra functionality for winbatchOS" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 262 /rd 800 40 /c 7
CALL Text 65 18 %lightTHEMEcolor% "Apps for websites" X _Button_Boxes _Button_Hover
CALL Text 65 19 %lightTHEMEcolor% "Websites that can run in an app instead of a browser" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 305 /rd 800 40 /c 7
CALL Text 65 21 %lightTHEMEcolor% "Startup" X _Button_Boxes _Button_Hover
CALL Text 65 22 %lightTHEMEcolor% "Apps auto-start when you start winbatchOS" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE











:SETTINGS.ACCOUNTS
set _SETTINGS.SECTION=ACCOUNTS
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp

CALL Text 55 4 %THEMEcolor% "Accounts" X _Button_Boxes _Button_Hover

call insertphoto 400 115 20 profile-icon.bmp

CALL Text 65 8 %THEMEcolor% "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover
CALL Text 65 9 %THEMEcolor% "Local Account" X _Button_Boxes _Button_Hover


CALL Text 55 15 %THEMEcolor% "Account Settings" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 245 /rd 800 40 /c 7
CALL Text 65 17 %blueTHEMEcolor% "Your info" X _Button_Boxes _Button_Hover
CALL Text 65 18 %blueTHEMEcolor% "Change username, profile photo" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 288 /rd 800 40 /c 7
CALL Text 65 20 %blueTHEMEcolor% "Sign-in Options" X _Button_Boxes _Button_Hover
CALL Text 65 21 %blueTHEMEcolor% "Change password" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 331 /rd 800 40 /c 7
CALL Text 65 23 %lightTHEMEcolor% "Other users" X _Button_Boxes _Button_Hover
CALL Text 65 24 %lightTHEMEcolor% "Currently disabled" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE


:SETTINGS.ACCOUNTS.PROFILE
set _SETTINGS.SECTION=ACCOUNTS.PROFILE
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp

CALL Text 55 4 %blueTHEMEcolor% "Accounts" 63 4 %THEMEcolor% "   >   Profile photo" X _Button_Boxes _Button_Hover

CALL Text 65 8 %THEMEcolor% "%_USERNAME-winbatchOS%" X _Button_Boxes _Button_Hover
CALL Text 65 9 %THEMEcolor% "Local Account" X _Button_Boxes _Button_Hover


CALL Text 65 15 %THEMEcolor% "Edit your profile photo" X _Button_Boxes _Button_Hover

CALL Text 65 17 %THEMEcolor% "Edit using paint" X _Button_Boxes _Button_Hover
CALL Text 65 18 %lightTHEMEcolor% "Use paint to edit your profile photo" X _Button_Boxes _Button_Hover

CALL Text 65 20 %THEMEcolor% "Manually edit your photo" X _Button_Boxes _Button_Hover
CALL Text 65 21 %THEMEcolor% "Use your favorite paint app and edit 'profile-icon.bmp' inside /NI/BMP/. " X _Button_Boxes _Button_Hover
goto :KERNEL.EXE

:SETTINGS.ACCOUNTS.SIGNIN
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN

rem  THIS IS A POP-UP
rem  Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 8
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

CALL Text 83 22 %THEMEcolor% "Change password" X _Button_Boxes _Button_Hover
CALL Text 83 25 %THEMEcolor% "Are you sure you want to change your password?" X _Button_Boxes _Button_Hover

call insertphoto 650 450 40 UI.buttonblue.bmp
call insertphoto 649 451 40 UI.buttonblue.bmp
call insertphoto 651 454 40 UI.buttonblue.bmp

call insertphoto 920 450 40 UI.buttongray.bmp
call insertphoto 919 451 40 UI.buttongray.bmp
call insertphoto 921 454 40 UI.buttongray.bmp
CALL Text 93 32 3f "Yes" X _Button_Boxes _Button_Hover
CALL Text 133 32 %THEMEcolor% "No" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE

:SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN.CHANGEPASSWORD
rem  THIS IS A POP-UP
rem  Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 8

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


CALL Text 83 22 %THEMEcolor% "Change password" X _Button_Boxes _Button_Hover

CALL Text 90 25 %THEMEcolor% "Type your password here. Press ENTER to continue." X _Button_Boxes _Button_Hover
CALL Text 90 26 %THEMEcolor% "Type 'NONE' in caps to not set a password." X _Button_Boxes _Button_Hover


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

SET _WBX_SETPASSWD=1
IF %_WBX_PASSWORD%==NONE SET _WBX_SETPASSWD=0

(
  echo SET _WBX_USERNAME=%_WBX_USERNAME%
  echo SET _WBX_SETPASSWD=%_WBX_SETPASSWD%
  echo SET _WBX_PASSWORD=%_WBX_PASSWORD%
) > data-user.bat

:SETTINGS.ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE
set _SETTINGS.SECTION=ACCOUNTS.SIGNIN.CHANGEPASSWORD.DONE
rem  THIS IS A POP-UP
rem  Clear the center of the accounts
PIXELDRAW /dr 578 304 /rd 525 275 /c 8

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

CALL Text 90 25 %THEMEcolor% "Your password has been changed." X _Button_Boxes _Button_Hover
CALL Text 90 25 %THEMEcolor% "Please use your new password to login next time." X _Button_Boxes _Button_Hover


call insertphoto 920 450 40 UI.buttongray.bmp
call insertphoto 919 451 40 UI.buttongray.bmp
call insertphoto 921 454 40 UI.buttongray.bmp
CALL Text 133 32 %THEMEcolor% "Okay" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE


:SETTINGS.TIMELANGUAGE
set _SETTINGS.SECTION=TIMELANGUAGE
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp
CALL Text 55 4 %THEMEcolor% "Time & Language" X _Button_Boxes _Button_Hover

CALL Text 55 10 %THEMEcolor% "%_WBX-TASKBAR-TIME%" X _Button_Boxes _Button_Hover
CALL Text 55 11 %THEMEcolor% "%DATE:~-10%" X _Button_Boxes _Button_Hover

CALL Text 55 15 %THEMEcolor% "To change your time settings, go to Windows Settings." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE















:SETTINGS.ACCESSIBILITY
set _SETTINGS.SECTION=ACCESSIBILITY
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp
CALL Text 55 4 %THEMEcolor% "Accessibility" X _Button_Boxes _Button_Hover
CALL Text 55 7 %blueTHEMEcolor% "Accessibility will not be a main feature on winbatchOS 18." X _Button_Boxes _Button_Hover
goto :KERNEL.EXE

















:SETTINGS.PRIVACYSECURITY
set _SETTINGS.SECTION=PRIVACYSECURITY
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp
CALL Text 55 4 %THEMEcolor% "Privacy & Security" X _Button_Boxes _Button_Hover


CALL Text 55 7 %lightTHEMEcolor% "Security" X _Button_Boxes _Button_Hover

rem magic number: 43

PIXELDRAW /dr 400 143 /rd 800 40 /c 7

CALL Text 65 10 %THEMEcolor% "winbatchOS Security" X _Button_Boxes _Button_Hover
CALL Text 65 11 %lightTHEMEcolor% "Batch App Signing, linux container protection, and auto-fix currupt files for this OS" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 186 /rd 800 40 /c 7

CALL Text 65 13 %THEMEcolor% "Windows Security" X _Button_Boxes _Button_Hover
CALL Text 65 14 %lightTHEMEcolor% "Preform Antivirus scans, firewall checks, and networks for your device" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 229 /rd 800 40 /c 7

CALL Text 65 16 %THEMEcolor% "For developers" X _Button_Boxes _Button_Hover
CALL Text 65 17 %lightTHEMEcolor% "These settings are intended for development use only for winbatchOS" X _Button_Boxes _Button_Hover







CALL Text 55 20 %lightTHEMEcolor% "winbatchOS permissions" X _Button_Boxes _Button_Hover

CALL Text 65 24 %THEMEcolor% "Loading.." X _Button_Boxes _Button_Hover

CALL Text 65 24 %THEMEcolor% "unavailable" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE




















:SETTINGS.UPDATE
set _SETTINGS.SECTION=UPDATE
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp

call insertphoto 400 100 110 settings.ui.update.%THEME%.bmp

CALL Text 55 4 %THEMEcolor% "winbatchOS Update" X _Button_Boxes _Button_Hover

CALL Text 70 7 %THEMEcolor% "%_WBXCore-updatemessage%" X _Button_Boxes _Button_Hover
CALL Text 70 9 %lightTHEMEcolor% "%_WbOS% %_version%" X _Button_Boxes _Button_Hover
CALL Text 70 10 %lightTHEMEcolor% "Version 2303_Beta1" X _Button_Boxes _Button_Hover
CALL Text 70 11 %lightTHEMEcolor% "OS Build %_build%" X _Button_Boxes _Button_Hover

call insertphoto 1070 125 40 UI.buttonblue.bmp
call insertphoto 1069 126 41 UI.buttonblue.bmp
call insertphoto 1071 129 40 UI.buttonblue.bmp
call insertphoto 1100 125 40 UI.buttonblue.bmp
call insertphoto 1099 126 41 UI.buttonblue.bmp
call insertphoto 1101 129 40 UI.buttonblue.bmp
CALL Text 152 9 3f "Check for updates" X _Button_Boxes _Button_Hover


CALL Text 55 15 %THEMEcolor% "More Options" X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 400 250 /rd 800 40 /c 7

CALL Text 65 17 %lightTHEMEcolor% "Pause updates" X _Button_Boxes _Button_Hover
CALL Text 65 18 %lightTHEMEcolor% "Disabled" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 293 /rd 800 40 /c 7

CALL Text 65 20 %lightTHEMEcolor% "Update history" X _Button_Boxes _Button_Hover
CALL Text 65 21 %lightTHEMEcolor% "" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 336 /rd 800 40 /c 7

CALL Text 65 23 %lightTHEMEcolor% "Advanced Options" X _Button_Boxes _Button_Hover
CALL Text 65 24 %lightTHEMEcolor% "Optional Updates, System Servers" X _Button_Boxes _Button_Hover

PIXELDRAW /dr 400 379 /rd 800 40 /c 7

CALL Text 65 26 %THEMEcolor% "winbatchOS Preview Builds" X _Button_Boxes _Button_Hover
CALL Text 65 27 %lightTHEMEcolor% "Download and preview canary builds of winbatchOS" X _Button_Boxes _Button_Hover

rem  note stuff

rem  call insertphoto 380 600 100 UI.buttongray.bmp
rem  call insertphoto 379 601 100 UI.buttongray.bmp
rem  call insertphoto 381 604 100 UI.buttongray.bmp

rem  call insertphoto 580 600 100 UI.buttongray.bmp
rem  call insertphoto 579 601 100 UI.buttongray.bmp
rem  call insertphoto 581 604 100 UI.buttongray.bmp

rem  call insertphoto 780 600 100 UI.buttongray.bmp
rem  call insertphoto 779 601 100 UI.buttongray.bmp
rem  call insertphoto 781 604 100 UI.buttongray.bmp

rem  call insertphoto 980 600 100 UI.buttongray.bmp
rem  call insertphoto 979 601 100 UI.buttongray.bmp
rem  call insertphoto 981 604 100 UI.buttongray.bmp


CALL Text 60 43 %lightTHEMEcolor% "Get Help" X _Button_Boxes _Button_Hover
CALL Text 60 44 %lightTHEMEcolor% "Give Feedback" X _Button_Boxes _Button_Hover
goto :KERNEL.EXE






:SETTINGS.UPDATE.BUILDS
set _SETTINGS.SECTION=UPDATE.BUILDS
call :SETTINGS.NAVIGATION

rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp

CALL Text 55 4 %blueTHEMEcolor% "Update " 62 4 %THEMEcolor% "   >   Development Builds" X _Button_Boxes _Button_Hover


CALL Text 70 7 %blueTHEMEcolor% "%_WBXCore-updatealert%" X _Button_Boxes _Button_Hover
CALL Text 70 8 %THEMEcolor% "%_WbOS% %_version%" X _Button_Boxes _Button_Hover
CALL Text 70 9 %THEMEcolor% "Installed build:  %_build%" X _Button_Boxes _Button_Hover



CALL Text 70 19 %THEMEcolor% "Choose the targeted development branch" X _Button_Boxes _Button_Hover
CALL Text 70 20 %blueTHEMEcolor% "--->" X _Button_Boxes _Button_Hover
CALL Text 75 20 %blueTHEMEcolor% "Canary Branch" X _Button_Boxes _Button_Hover
CALL Text 76 21 %lightTHEMEcolor% "These builds are ideal for the next-release of winbatchOS development." X _Button_Boxes _Button_Hover
CALL Text 76 22 %lightTHEMEcolor% "These builds are more stable than the Windows Canary Channel because." X _Button_Boxes _Button_Hover
CALL Text 76 23 %lightTHEMEcolor% "developers are constantly working on the code realtime. Issues may " X _Button_Boxes _Button_Hover
CALL Text 76 24 %lightTHEMEcolor% "still arrise." X _Button_Boxes _Button_Hover
CALL Text 75 26 %lightTHEMEcolor% "General Branch" X _Button_Boxes _Button_Hover
CALL Text 76 27 %lightTHEMEcolor% "These builds are almost completely stable and have little to no bugs" X _Button_Boxes _Button_Hover
CALL Text 76 28 %lightTHEMEcolor% "in the code. This branch holds the current released version of winbatchOS." X _Button_Boxes _Button_Hover

CALL Text 75 35 %THEMEcolor% "In order to go back into the general releases builds, you must reset your" X _Button_Boxes _Button_Hover
CALL Text 75 36 %THEMEcolor% "build back via System > Troubleshoot. It'll automatically push you back to" X _Button_Boxes _Button_Hover
CALL Text 75 37 %THEMEcolor% "the latest, available general release." X _Button_Boxes _Button_Hover

rem magic number: 43
PIXELDRAW /dr 400 100 /rd 800 470 /c 7


goto :KERNEL.EXE






:SETTINGS.UPDATE.WGET
rem  Update Manager - wget

rem  Set Variable for _link= (Universal)
SET "_Link=https://github.com/bes-ptah/winbatchOS/archive/refs/heads/main.zip"

rem  download it quietly using -q. It won't spam the command line.
wget -q "%_Link%" > nul

rem  Unpack it (This is why Windows 1809 and higher is recommended, or use tar yourself)
tar -xf main.zip

rem  Enter the directory (always this name)
cd winbatchOS-main

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
rmdir winbatchOS-main > nul

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

  echo SET _HOSTNAME-winbatchOS=%_HOSTNAME-winbatchOS%
) > CoreData\data-settings.bat
exit /b










:SETTINGS.NAVIGATION
rem  Load left app stuff here
call insertphoto 30 60 20 profile-icon.bmp
CALL Text 12 4 %blueTHEMEcolor% "%_WBX_USERNAME%" X _Button_Boxes _Button_Hover
CALL Text 12 5 %THEMEcolor% "Local Account" X _Button_Boxes _Button_Hover

rem Load icons first!
call insertphoto 40 180 120 settings-system-icon.bmp


call insertphoto 40 220 120 settings-personalization-icon.bmp


call insertphoto 40 262 120 settings-apps-icon.bmp


call insertphoto 40 304 120 settings-account-icon.bmp


call insertphoto 40 346 120 settings-timelanguage-icon.bmp


call insertphoto 40 388 120 settings-accessibility-icon.bmp


call insertphoto 40 430 120 settings-security-icon.bmp


call insertphoto 40 473 120 settings-update-icon.bmp



rem Load names

rem Top:
PIXELDRAW /dl /p 25 134 242 134 /c 7

rem Left:
PIXELDRAW /dl /p 23 136 23 160 /c 7

rem Right:
PIXELDRAW /dl /p 244 136 244 160 /c 7

rem Bottom:
PIXELDRAW /dl /p 25 162 242 162 /c 9

call insertphoto 20 177 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==SYSTEM call insertphoto 20 177 120 settings-side-navigation-icon-%THEME%.bmp
call insertphoto 20 220 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==PERSONALIZATION call insertphoto 20 220 120 settings-side-navigation-icon-%THEME%.bmp
call insertphoto 20 260 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==APPS call insertphoto 20 260 120 settings-side-navigation-icon-%THEME%.bmp
call insertphoto 20 299 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==ACCOUNTS call insertphoto 20 299 120 settings-side-navigation-icon-%THEME%.bmp
call insertphoto 20 344 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==TIMELANGUAGE call insertphoto 20 344 120 settings-side-navigation-icon-%THEME%.bmp
call insertphoto 20 386 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==ACCESSIBILITY call insertphoto 20 386 120 settings-side-navigation-icon-%THEME%.bmp
call insertphoto 20 427 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==PRIVACYSECURITY call insertphoto 20 427 120 settings-side-navigation-icon-%THEME%.bmp
call insertphoto 20 472 120 settings-blank-navigation-icon-%THEME%.bmp
IF %_SETTINGS.SECTION%==UPDATE call insertphoto 20 472 120 settings-side-navigation-icon-%THEME%.bmp


call insertphoto 220 138 110 taskbar-searchbar-top.bmp


CALL Text 2 9 %lightTHEMEcolor% "Find a setting" X _Button_Boxes _Button_Hover


CALL Text 9 12 %THEMEcolor% "System" X _Button_Boxes _Button_Hover
CALL Text 9 15 %THEMEcolor% "Personalization" X _Button_Boxes _Button_Hover
CALL Text 9 18 %THEMEcolor% "Apps" X _Button_Boxes _Button_Hover
CALL Text 9 21 %THEMEcolor% "Accounts" X _Button_Boxes _Button_Hover
CALL Text 9 24 %THEMEcolor% "Time & Lauguage" X _Button_Boxes _Button_Hover
CALL Text 9 27 %THEMEcolor% "Accessibility" X _Button_Boxes _Button_Hover
CALL Text 9 30 %THEMEcolor% "Privacy & Security" X _Button_Boxes _Button_Hover
CALL Text 9 33 %THEMEcolor% "winbatchOS Update" X _Button_Boxes _Button_Hover

exit /b





rem documenting everything more in api-like standards..

:SETTINGS.CLEARPAGE


rem  Clear ONLY the stuff from earlier, dont clear the sidebar
call insertphoto 380 50 110 blankloadapp.%THEME%.bmp 
call insertphoto 380 210 110 blankloadapp.%THEME%.bmp 
exit /b











rem  winbatchOS Edge - There is no official license yet. 
rem  Respectivly is 'outbranched' from Microsoft Edge.
:EDGE.EXE
set _APP.EXE=1
IF %_EDGE.EXE%==1 goto :EDGE.LOOP
set _ACTIVEAPPLABEL=edge
set _ACTIVEAPPIMAGE=edge
SET _ACTIVEAPPTITLE=Edge
call :KERNEL.API.BUILTIN.APPSTART

set _EDGE.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 edge.%THEME%.bmp
 
call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul

rem  call insertphoto 0 0 %BACKGROUND-SIZE% %background%.bmp


:EDGE.LOOP

call insertphoto 0 38 147 blankloadapp.white.bmp &call insertphoto 0 38 147 blankloadapp.white.bmp &call insertphoto 7 38 147 blankloadapp.white.bmp &call insertphoto 7 38 147 blankloadapp.white.bmp



call insertphoto 40 15 41 UI.buttonbrightwhite.bmp
call insertphoto 60 15 41 UI.buttonbrightwhite.bmp
call insertphoto 80 15 41 UI.buttonbrightwhite.bmp
call insertphoto 100 15 41 UI.buttonbrightwhite.bmp
call insertphoto 120 15 41 UI.buttonbrightwhite.bmp

call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=edge.exe

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp


Call insertphoto 16 20 120 edge.tabs.bmp

Call insertphoto 57 20 120 edge.newtab.bmp
Call insertphoto 180 26 120 UI.context.close.explorer.bmp
CALL Text 10 1 %THEMEcolor% "New Tab" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 100 1490 100 /c 0




PIXELDRAW /dl /p 0 100 1490 100 /c 7

call :DESKTOP.TASKBAR
call :DESKTOP.ICON



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
call :KERNEL.API.BUILTIN.APPSTART

set _EXPLORER.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 explorer.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul
:EXPLORER.LOOP
call insertphoto 0 35 147 blankloadapp.white.bmp &call insertphoto 0 35 147 blankloadapp.white.bmp &call insertphoto 7 35 147 blankloadapp.white.bmp &call insertphoto 7 35 147 blankloadapp.white.bmp



call insertphoto 20 15 41 UI.buttonbrightwhite.bmp
call insertphoto 40 15 41 UI.buttonbrightwhite.bmp
call insertphoto 60 15 41 UI.buttonbrightwhite.bmp
call insertphoto 80 15 41 UI.buttonbrightwhite.bmp
call insertphoto 100 15 41 UI.buttonbrightwhite.bmp

call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=explorer.exe

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

Call insertphoto 35 20 80 explorer.home.bmp
Call insertphoto 180 26 120 UI.context.close.explorer.bmp
CALL Text 8 1 %THEMEcolor% "Home" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 100 1490 100 /c 0

rem  Command Bar
Call insertphoto 20 67 120 explorer.top.new.bmp
CALL Text 5 4 %THEMEcolor% "New" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 90 60 90 90 /c 7
Call insertphoto 120 67 120 explorer.top.cut.bmp
Call insertphoto 180 67 120 explorer.top.copy.bmp
Call insertphoto 240 67 120 explorer.top.paste.bmp
Call insertphoto 300 67 120 explorer.top.rename.bmp
Call insertphoto 360 67 120 explorer.top.share.bmp
Call insertphoto 420 67 120 explorer.top.trash.bmp

PIXELDRAW /dl /p 480 60 480 90 /c 7

CALL Text 72 4 %THEMEcolor% "Sort" X _Button_Boxes _Button_Hover

CALL Text 82 4 %THEMEcolor% "View" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 630 60 630 90 /c 7

Call insertphoto 640 55 100 taskbar-overflow-off-light.bmp





PIXELDRAW /dl /p 0 100 1490 100 /c 7

rem  Navigation Pane
PIXELDRAW /dl /p 300 100 300 783 /c 7

Call insertphoto 35 145 80 explorer.home.bmp
CALL Text 9 10 %THEMEcolor% "Home" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 20 180 280 180 /c 7

Call insertphoto 35 190 100 explorer.desktop.nav.bmp
CALL Text 9 13 %THEMEcolor% "Desktop" X _Button_Boxes _Button_Hover

Call insertphoto 35 233 100 explorer.documents.nav.bmp
CALL Text 9 16 %THEMEcolor% "Documents" X _Button_Boxes _Button_Hover

Call insertphoto 35 275 100 explorer.downloads.nav.bmp
CALL Text 9 19 %THEMEcolor% "Downloads" X _Button_Boxes _Button_Hover

Call insertphoto 35 317 100 explorer.music.nav.bmp
CALL Text 9 22 %THEMEcolor% "Music" X _Button_Boxes _Button_Hover

Call insertphoto 35 358 100 explorer.pictures.nav.bmp
CALL Text 9 25 %THEMEcolor% "Pictures" X _Button_Boxes _Button_Hover

Call insertphoto 35 400 100 explorer.videos.nav.bmp
CALL Text 9 28 %THEMEcolor% "Videos" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 20 432 280 432 /c 7

CALL Text 9 32 %THEMEcolor% "Disk 0" X _Button_Boxes _Button_Hover

rem  Displayed Part

CALL Text 44 10 %THEMEcolor% "Quick Access" X _Button_Boxes _Button_Hover

Call insertphoto 320 180 100 explorer.desktop.folder.bmp
CALL Text 45 16 %THEMEcolor% "Desktop" X _Button_Boxes _Button_Hover

Call insertphoto 420 180 100 explorer.documents.folder.bmp
CALL Text 59 16 %THEMEcolor% "Documents" X _Button_Boxes _Button_Hover

Call insertphoto 520 180 100 explorer.downloads.folder.bmp
CALL Text 73 16 %THEMEcolor% "Downloads" X _Button_Boxes _Button_Hover

Call insertphoto 620 180 100 explorer.music.folder.bmp
CALL Text 89 16 %THEMEcolor% "Music" X _Button_Boxes _Button_Hover

Call insertphoto 720 180 100 explorer.pictures.folder.bmp
CALL Text 102 16 %THEMEcolor% "Pictures" X _Button_Boxes _Button_Hover

Call insertphoto 820 180 100 explorer.videos.folder.bmp
CALL Text 117 16 %THEMEcolor% "Videos" X _Button_Boxes _Button_Hover

call :DESKTOP.TASKBAR
call :DESKTOP.ICON

goto :KERNEL.EXE
goto :EXPLORER.EXE











































rem  Security

:SECURITY.EXE
set _APP.EXE=1
IF %_SECURITY.EXE%==1 goto :SECURITY.LOOP
set _ACTIVEAPPLABEL=security.exe
set _ACTIVEAPPIMAGE=security
SET "_ACTIVEAPPTITLE=winbatchOS Security"
call :KERNEL.API.BUILTIN.APPSTART

set _SECURITY.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 security.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul
:SECURITY.LOOP
call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=security.exe
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

rem  call insertphoto 1452 38 115 UI.setting.bmp

Call insertphoto 20 10 8 security.%THEME%.bmp
CALL Text 6 0 %THEMEcolor% "winbatchOS Security" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c 0

call :DESKTOP.TASKBAR
call :DESKTOP.ICON
CALL Text 14 3 %blueTHEMEcolor% "Scan your system to make sure your computer is up-to-date with alerts." X _Button_Boxes _Button_Hover
CALL Text 14 4 %THEMEcolor% "This uses the Windows Security Command Line tool to scan winbatchOS." X _Button_Boxes _Button_Hover

call insertphoto 100 100 40 UI.buttonblue.bmp
call insertphoto 99 101 41 UI.buttonblue.bmp
call insertphoto 101 104 40 UI.buttonblue.bmp

CALL Text 14 7 3f "Scan Now" X _Button_Boxes _Button_Hover


CALL Text 14 12 %THEMEcolor% "Windows will tell you if your operating system has encountered an issue." X _Button_Boxes _Button_Hover



goto :KERNEL.EXE
goto :SECURITY.LOOP




:SECURITY.SCAN
rem  9.1.
set "CD_winbatchOS=%CD%"
cd C:\Program Files\Windows Defender
MpCmdRun -Scan -ScanType 3 -File %CD_winbatchOS% > nul
rem  The 3rd flag tells it as a custom scan.
rem  Change directory back to WBX-17.
cd "%CD_winbatchOS%"
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
call :DESKTOP.TASKBAR
call :DESKTOP.ICON

set M=0
set WIN2=0


:CALCULATOR.GUI
set M=0
IF %I%==m IF %M% EQU 0 IF %X% GTR 0 IF %Y% GTR 0 IF %X% LSS 200 IF %Y% LSS 50 set WIN2=n

rem changed it for a possible bug fix!
call :COMPOSE.EXE

rem  THIS DOES NOT REALLY WORK YET
rem  CALL BOX %_CALCULATOR.X% %_CALCULATOR.Y% 35 66 - - %THEMEcolor%  1

CALL BOX %_CALCULATOR.X% %_CALCULATOR.Y% 15 36 - - %blueTHEMEcolor%  1

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






rem Control Text (Close only)
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





CALL Text %_CALCULATOR.X1% %_CALCULATOR.Y1% %blueTHEMEcolor% " Calculator " %_CALCULATOR.X5% %_CALCULATOR.Y5% %blueTHEMEcolor% " X " X _Button_Boxes _Button_Hover


rem  SET "_CALCULATOR.DIGIT1=0"
rem  SET "_CALCULATOR.DIGIT2=0"
rem  SET "_CALCULATOR.OPERAT=+"


CALL Text %_CALCULATOR.X6% %_CALCULATOR.Y6% %blueTHEMEcolor% "Result:  " %_CALCULATOR.X6A% %_CALCULATOR.Y6A% %THEMEcolor% "%_CALCULATOR.FINAL%" X _Button_Boxes _Button_Hover
CALL Text %_CALCULATOR.X7% %_CALCULATOR.Y7% %lightTHEMEcolor% "X:  %_CALCULATOR.DIGIT1%" X _Button_Boxes _Button_Hover
CALL Text %_CALCULATOR.X8% %_CALCULATOR.Y8% %lightTHEMEcolor% "Y:  %_CALCULATOR.DIGIT2%" X _Button_Boxes _Button_Hover
CALL Text %_CALCULATOR.X9% %_CALCULATOR.Y9% %lightTHEMEcolor% "Operator:  %_CALCULATOR.OPERAT%" X _Button_Boxes _Button_Hover


rem  CALL Text %_CALCULATOR.X8% %_CALCULATOR.Y8% %THEMEcolor% " Ok " X _Button_Boxes _Button_Hover

CALL Text %_CALCULATOR.X10% %_CALCULATOR.Y10% %lightTHEMEcolor% "  7 |  8 |  9 |     -" X _Button_Boxes _Button_Hover
CALL Text %_CALCULATOR.X11% %_CALCULATOR.Y11% %lightTHEMEcolor% "  4 |  5 |  6 |     +" X _Button_Boxes _Button_Hover
CALL Text %_CALCULATOR.X12% %_CALCULATOR.Y12% %lightTHEMEcolor% "  1 |  2 |  3 |     =" X _Button_Boxes _Button_Hover




	rem test
	call insertphoto 118 224 100 UI.buttongray.bmp
	CALL Text 15 15 %THEMEcolor% "Test" X _Button_Boxes _Button_Hover

	call insertphoto 328 644 100 UI.buttongray.bmp
	CALL Text 45 45 %THEMEcolor% "Test" X _Button_Boxes _Button_Hover
	
	call insertphoto 72 132 100 UI.buttongray.bmp
	CALL Text 9 9 %THEMEcolor% "Test" X _Button_Boxes _Button_Hover

goto :KERNEL.EXE







rem  Calendar App
rem  (The calculating day thing is imported from 16.0)


:CALENDAR.EXE
set _APP.EXE=1
IF %_CALENDAR.EXE%==1 goto :CALENDAR.LOOP
set _ACTIVEAPPLABEL=calendar.exe
set _ACTIVEAPPIMAGE=calendar
SET _ACTIVEAPPTITLE=Calendar
call :KERNEL.API.BUILTIN.APPSTART

set _CALENDAR.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 calendar.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul
:CALENDAR.LOOP
call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=calendar.exe
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

rem  call insertphoto 1452 38 115 UI.setting.bmp

Call insertphoto 20 10 8 calendar.%THEME%.bmp
CALL Text 6 0 %THEMEcolor% "Calendar - %year%" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c 0

call :DESKTOP.TASKBAR
call :DESKTOP.ICON

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




Call Text 12 10 %THEMEcolor% "January" X _Button_Boxes _Button_Hover
Call Text 8 12 %THEMEcolor% "%JAN:~0,20%" X _Button_Boxes _Button_Hover
Call Text 8 14 %THEMEcolor% "%JAN:~21,20%" X _Button_Boxes _Button_Hover
Call Text 8 16 %THEMEcolor% "%JAN:~42,20%" X _Button_Boxes _Button_Hover
Call Text 8 18 %THEMEcolor% "%JAN:~63,20%" X _Button_Boxes _Button_Hover
Call Text 8 20 %THEMEcolor% "%JAN:~84,20%" X _Button_Boxes _Button_Hover
Call Text 8 22 %THEMEcolor% "%JAN:~105%" X _Button_Boxes _Button_Hover

Call Text 42 10 %THEMEcolor% "February" X _Button_Boxes _Button_Hover
Call Text 38 12 %THEMEcolor% "%FEB:~0,20%" X _Button_Boxes _Button_Hover
Call Text 38 14 %THEMEcolor% "%FEB:~21,20%" X _Button_Boxes _Button_Hover
Call Text 38 16 %THEMEcolor% "%FEB:~42,20%" X _Button_Boxes _Button_Hover
Call Text 38 18 %THEMEcolor% "%FEB:~63,20%" X _Button_Boxes _Button_Hover
Call Text 38 20 %THEMEcolor% "%FEB:~84,20%" X _Button_Boxes _Button_Hover
Call Text 38 22 %THEMEcolor% "%FEB:~105%" X _Button_Boxes _Button_Hover

Call Text 72 10 %THEMEcolor% "March" X _Button_Boxes _Button_Hover
Call Text 68 12 %THEMEcolor% "%MAR:~0,20%" X _Button_Boxes _Button_Hover
Call Text 68 14 %THEMEcolor% "%MAR:~21,20%" X _Button_Boxes _Button_Hover
Call Text 68 16 %THEMEcolor% "%MAR:~42,20%" X _Button_Boxes _Button_Hover
Call Text 68 18 %THEMEcolor% "%MAR:~63,20%" X _Button_Boxes _Button_Hover
Call Text 68 20 %THEMEcolor% "%MAR:~84,20%" X _Button_Boxes _Button_Hover
Call Text 68 22 %THEMEcolor% "%MAR:~105%" X _Button_Boxes _Button_Hover

Call Text 102 10 %THEMEcolor% "April" X _Button_Boxes _Button_Hover
Call Text 98 12 %THEMEcolor% "%APR:~0,20%" X _Button_Boxes _Button_Hover
Call Text 98 14 %THEMEcolor% "%APR:~21,20%" X _Button_Boxes _Button_Hover
Call Text 98 16 %THEMEcolor% "%APR:~42,20%" X _Button_Boxes _Button_Hover
Call Text 98 18 %THEMEcolor% "%APR:~63,20%" X _Button_Boxes _Button_Hover
Call Text 98 20 %THEMEcolor% "%APR:~84,20%" X _Button_Boxes _Button_Hover
Call Text 98 22 %THEMEcolor% "%APR:~105%" X _Button_Boxes _Button_Hover

Call Text 132 10 %THEMEcolor% "May" X _Button_Boxes _Button_Hover
Call Text 128 12 %THEMEcolor% "%MAY:~0,20%" X _Button_Boxes _Button_Hover
Call Text 128 14 %THEMEcolor% "%MAY:~21,20%" X _Button_Boxes _Button_Hover
Call Text 128 16 %THEMEcolor% "%MAY:~42,20%" X _Button_Boxes _Button_Hover
Call Text 128 18 %THEMEcolor% "%MAY:~63,20%" X _Button_Boxes _Button_Hover
Call Text 128 20 %THEMEcolor% "%MAY:~84,20%" X _Button_Boxes _Button_Hover
Call Text 128 22 %THEMEcolor% "%MAY:~105%" X _Button_Boxes _Button_Hover

Call Text 162 10 %THEMEcolor% "June" X _Button_Boxes _Button_Hover
Call Text 158 12 %THEMEcolor% "%JUN:~0,20%" X _Button_Boxes _Button_Hover
Call Text 158 14 %THEMEcolor% "%JUN:~21,20%" X _Button_Boxes _Button_Hover
Call Text 158 16 %THEMEcolor% "%JUN:~42,20%" X _Button_Boxes _Button_Hover
Call Text 158 18 %THEMEcolor% "%JUN:~63,20%" X _Button_Boxes _Button_Hover
Call Text 158 20 %THEMEcolor% "%JUN:~84,20%" X _Button_Boxes _Button_Hover
Call Text 158 22 %THEMEcolor% "%JUN:~105%" X _Button_Boxes _Button_Hover

Call Text 12 30 %THEMEcolor% "July" X _Button_Boxes _Button_Hover
Call Text 8 32 %THEMEcolor% "%JUL:~0,20%" X _Button_Boxes _Button_Hover
Call Text 8 34 %THEMEcolor% "%JUL:~21,20%" X _Button_Boxes _Button_Hover
Call Text 8 36 %THEMEcolor% "%JUL:~42,20%" X _Button_Boxes _Button_Hover
Call Text 8 38 %THEMEcolor% "%JUL:~63,20%" X _Button_Boxes _Button_Hover
Call Text 8 40 %THEMEcolor% "%JUL:~84,20%" X _Button_Boxes _Button_Hover
Call Text 8 42 %THEMEcolor% "%JUL:~105%" X _Button_Boxes _Button_Hover

Call Text 42 30 %THEMEcolor% "August" X _Button_Boxes _Button_Hover
Call Text 38 32 %THEMEcolor% "%AUG:~0,20%" X _Button_Boxes _Button_Hover
Call Text 38 34 %THEMEcolor% "%AUG:~21,20%" X _Button_Boxes _Button_Hover
Call Text 38 36 %THEMEcolor% "%AUG:~42,20%" X _Button_Boxes _Button_Hover
Call Text 38 38 %THEMEcolor% "%AUG:~63,20%" X _Button_Boxes _Button_Hover
Call Text 38 40 %THEMEcolor% "%AUG:~84,20%" X _Button_Boxes _Button_Hover
Call Text 38 42 %THEMEcolor% "%AUG:~105%" X _Button_Boxes _Button_Hover

Call Text 72 30 %THEMEcolor% "September" X _Button_Boxes _Button_Hover
Call Text 68 32 %THEMEcolor% "%SEP:~0,20%" X _Button_Boxes _Button_Hover
Call Text 68 34 %THEMEcolor% "%SEP:~21,20%" X _Button_Boxes _Button_Hover
Call Text 68 36 %THEMEcolor% "%SEP:~42,20%" X _Button_Boxes _Button_Hover
Call Text 68 38 %THEMEcolor% "%SEP:~63,20%" X _Button_Boxes _Button_Hover
Call Text 68 40 %THEMEcolor% "%SEP:~84,20%" X _Button_Boxes _Button_Hover
Call Text 68 42 %THEMEcolor% "%SEP:~105%" X _Button_Boxes _Button_Hover

Call Text 102 30 %THEMEcolor% "October" X _Button_Boxes _Button_Hover
Call Text 98 32 %THEMEcolor% "%OCT:~0,20%" X _Button_Boxes _Button_Hover
Call Text 98 34 %THEMEcolor% "%OCT:~21,20%" X _Button_Boxes _Button_Hover
Call Text 98 36 %THEMEcolor% "%OCT:~42,20%" X _Button_Boxes _Button_Hover
Call Text 98 38 %THEMEcolor% "%OCT:~63,20%" X _Button_Boxes _Button_Hover
Call Text 98 40 %THEMEcolor% "%OCT:~84,20%" X _Button_Boxes _Button_Hover
Call Text 98 42 %THEMEcolor% "%OCT:~105%" X _Button_Boxes _Button_Hover

Call Text 132 30 %THEMEcolor% "November" X _Button_Boxes _Button_Hover
Call Text 128 32 %THEMEcolor% "%NOV:~0,20%" X _Button_Boxes _Button_Hover
Call Text 128 34 %THEMEcolor% "%NOV:~21,20%" X _Button_Boxes _Button_Hover
Call Text 128 36 %THEMEcolor% "%NOV:~42,20%" X _Button_Boxes _Button_Hover
Call Text 128 38 %THEMEcolor% "%NOV:~63,20%" X _Button_Boxes _Button_Hover
Call Text 128 40 %THEMEcolor% "%NOV:~84,20%" X _Button_Boxes _Button_Hover
Call Text 128 42 %THEMEcolor% "%NOV:~105%" X _Button_Boxes _Button_Hover

Call Text 162 30 %THEMEcolor% "December" X _Button_Boxes _Button_Hover
Call Text 158 32 %THEMEcolor% "%DEC:~0,20%" X _Button_Boxes _Button_Hover
Call Text 158 34 %THEMEcolor% "%DEC:~21,20%" X _Button_Boxes _Button_Hover
Call Text 158 36 %THEMEcolor% "%DEC:~42,20%" X _Button_Boxes _Button_Hover
Call Text 158 38 %THEMEcolor% "%DEC:~63,20%" X _Button_Boxes _Button_Hover
Call Text 158 40 %THEMEcolor% "%DEC:~84,20%" X _Button_Boxes _Button_Hover
Call Text 158 42 %THEMEcolor% "%DEC:~105%" X _Button_Boxes _Button_Hover


goto :KERNEL.EXE
goto :CALENDAR.LOOP












:CLOCK.EXE
call :KERNEL.API.BUILTIN.APPSTART
goto :DESKTOP.EXE

















rem  Task Manager App
:TASKMGR.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=taskmgr.exe
set _ACTIVEAPPIMAGE=taskmgr
SET _ACTIVEAPPTITLE=Task Manager
call :KERNEL.API.BUILTIN.APPSTART


IF %_TASKMGR.EXE%==1 goto :TASKMGR.LOOP
set _ACTIVEAPPLABEL=taskmgr.exe
set _ACTIVEAPPIMAGE=taskmgr
SET _ACTIVEAPPTITLE=Task Manager

set _TASKMGR.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 taskmgr.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul
:TASKMGR.LOOP
call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=taskmgr.exe
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

rem  call insertphoto 1452 38 115 UI.setting.bmp


Call insertphoto 60 10 8 taskmgr.%THEME%.bmp
CALL Text 12 0 %THEMEcolor% "Task Manager" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 57 35 1490 35 /c 7


rem  Navigation Pane
PIXELDRAW /dl /p 55 37 55 783 /c 7
Call insertphoto 20 15 100 UI.lines.bmp
Call insertphoto 20 45 100 ui.appbox.bmp
Call insertphoto 19 75 100 ui.performance.bmp
Call insertphoto 20 755 100 ui.setting.bmp



rem Search on top:
call insertphoto 487 10 100 taskbar-searchbar-top.bmp
CALL Text 72 0 %lightTHEMEcolor% "Search" X _Button_Boxes _Button_Hover

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
CALL Text 10 3 %THEMEcolor% "Processes (7)" X _Button_Boxes _Button_Hover
CALL Text 90 3 %THEMEcolor% "Executables listed below are not in order." X _Button_Boxes _Button_Hover

CALL Text 193 3 %THEMEcolor% "+ Start New Task" X _Button_Boxes _Button_Hover
PIXELDRAW /dl /p 55 85 1491 85 /c 7

CALL Text 10 7 %THEMEcolor% " Name                                          Status             Size" X _Button_Boxes _Button_Hover
PIXELDRAW /dl /p 60 125 1485 125 /c 7
CALL Text 10 9 %THEMEcolor% "Apps (1)" X _Button_Boxes _Button_Hover


rem Task Manager - running! :D
CALL insertphoto 95 165 8 %_ACTIVEAPPIMAGE%.%THEME%.bmp
rem Current running app (use the 'api' rather than saying task manager)
CALL Text 16 11 %THEMEcolor% "%_ACTIVEAPPTITLE%" X _Button_Boxes _Button_Hover
rem say the app is currently running, 'active' being shown on the screen
CALL Text 57 11 %THEMEcolor% "Active" X _Button_Boxes _Button_Hover
rem now variables
CALL Text 77 11 %THEMEcolor% "2G" X _Button_Boxes _Button_Hover


call :DESKTOP.TASKBAR
call :DESKTOP.ICON

goto :KERNEL.EXE







rem  Photos App
:PHOTOS.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=photos.exe
set _ACTIVEAPPIMAGE=photos
SET _ACTIVEAPPTITLE=Photos
call :KERNEL.API.BUILTIN.APPSTART

IF %_PHOTOS.EXE%==1 goto :PHOTOS.LOOP
set _ACTIVEAPPLABEL=photos.exe
set _ACTIVEAPPIMAGE=photos
SET _ACTIVEAPPTITLE=Photos

set _PHOTOS.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 photos.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul
:PHOTOS.LOOP
call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=photos.exe
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp



Call insertphoto 20 10 8 photos.%THEME%.bmp
CALL Text 6 0 %THEMEcolor% "Photos" X _Button_Boxes _Button_Hover




call insertphoto 445 10 100 taskbar-searchbar-top.bmp
CALL Text 66 0 %lightTHEMEcolor% "Search" X _Button_Boxes _Button_Hover

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
CALL Text 175 0 %lightTHEMEcolor% "Import" X _Button_Boxes _Button_Hover


call insertphoto 1330 10 115 UI.setting.bmp




PIXELDRAW /dl /p 0 35 1490 35 /c 0


rem  Navigation Pane
PIXELDRAW /dl /p 55 35 55 783 /c 0
Call insertphoto 20 45 100 UI.lines.bmp
Call insertphoto 18 75 100 ui.photos.all.bmp

rem  Main Window
Call insertphoto 80 50 130 ui.photos.all.bmp
CALL Text 15 3 %THEMEcolor% "All Photos" X _Button_Boxes _Button_Hover

CALL Text 15 7 %THEMEcolor% "To show a photo, click on the top-right Text named 'Import'. " X _Button_Boxes _Button_Hover

CALL Text 15 9 %THEMEcolor% "%_PHOTOS.SOURCE%" X _Button_Boxes _Button_Hover

call :DESKTOP.TASKBAR
call :DESKTOP.ICON

goto :KERNEL.EXE




:PHOTOS.SAVEFILEDIALOG
Set _PHOTOS.SOURCE=0
For /f "Tokens=1,2,3,4* delims=:" %%A in ('savefiledialog "winbatchOS Photos: Find image.." "" "Images (*.*)"') Do (
	Set _PHOTOS.SOURCE=%%A
	title winbatchOS 18 [Source: %%A ]
)
exit /b




































































rem Terminal App
:TERMINAL.EXE
set _APP.EXE=1
set _ACTIVEAPPLABEL=terminal.exe
set _ACTIVEAPPIMAGE=terminal
SET _ACTIVEAPPTITLE=Terminal
call :KERNEL.API.BUILTIN.APPSTART

IF %_TERMINAL.EXE%==1 goto :TERMINAL.LOOP
set _ACTIVEAPPLABEL=terminal.exe
set _ACTIVEAPPIMAGE=terminal
SET _ACTIVEAPPTITLE=Terminal

set _TERMINAL.EXE=1
call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp &call insertphoto 40 40 100 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 terminal.%THEME%.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul
:TERMINAL.LOOP
cls
rem for command line to focus back into the desktop
CALL Text 8 -1 0f "Terminal" 17 -1 03 "BETA" X _Button_Boxes _Button_Hover

call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=terminal.exe
call insertphoto 0 0 147 blankloadapp.dark.bmp &call insertphoto 0 35 147 blankloadapp.dark.bmp &call insertphoto 7 0 147 blankloadapp.dark.bmp &call insertphoto 7 35 147 blankloadapp.dark.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c f

call insertphoto 25 12 8 Terminal.dark.bmp

call insertphoto 1200 40 100 WindowedButtons.%THEME%.bmp



CALL Text 8 0 0f "Terminal" 17 0 03 "BETA" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 35 1490 35 /c f

call :DESKTOP.TASKBAR
call :DESKTOP.ICON

CALL Text 90 30 0f "Open Terminal" X _Button_Boxes _Button_Hover


CALL Text 60 25 0f "You will not be able to use any of the GUI features while opening Terminal." X _Button_Boxes _Button_Hover
CALL Text 60 26 0f "To exit, type 'exit' during the login process, OR type exit on the prompt." X _Button_Boxes _Button_Hover

goto :KERNEL.EXE











:TERMINAL.START
CALL Text 0 2 0f "Opening winbatchOS Terminal" X _Button_Boxes _Button_Hover
echo.
echo winbatchOS %_version%, Build %_build%
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
set /p WBXprompt=%_WBX_USERNAME%@%_HOSTNAME-winbatchOS%: 
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
	echo The terminal app is finished. winbatchOS will try to start the desktop again.
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
	echo winbatchOS %_version%, Build %_build%
	echo Kernel Version %_quantum-ver%
	echo.
	goto :TERMINAL.SYSTEMLOOP

	:TERMINAL.WBXINSTALL 
	echo.
	echo This feature is not enabled or is imcomplete.
	echo.
	goto :TERMINAL.SYSTEMLOOP







:ERROR.EXE
cls
:ERROR.LOOP
rem Set a clock up to 10
IF %_ERROR.EXE%==100 set _ERROR.EXE=1 &goto :SYSTEM.EXE

color 3f
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo    ==[WBXERROR]==================================================================[-  []  X]=
echo    =                                                                                       =
echo    =  winbatchOS ran into a problem and needs to restart. We're going to try to recover     =
echo    =  the state it is in right now as much as possible, then we'll restart for you.        =
echo    =                                                                                       =
echo    =  [Restarting in a few moments]                                                        =
echo    =  [Error Code: Unknown]                                                                =
echo    =  [winbatchOS SDK 16 Window]                                                            =
echo    =                                                                                       =
echo    =========================================================================================
set /A _ERROR.EXE=%_ERROR.EXE%+1
goto :ERROR.LOOP





rem END OF winbatchOS CODE
rem winbatchOS.
rem WinBatchX 20 Installer - (Rev1)
rem This software is licensed under the Microsoft Public License (Ms-PL).
rem ==
rem This is a stand-alone batch installer 
rem that requires an internet connection.
rem Requires Windows 10 or higher to
rem install and reinstall WinBatchOS.
rem ==

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


:BOOT.EXE
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
call Text 83 38 0f "Please Wait for winbatchOS to start" X _Button_Boxes _Button_Hover

PIXELDRAW /refresh 3f
call insertphoto 0 0 77 bootimage.bmp

rem 1
rem Set General Variables
SET "_WbOS=WinBatchOS"
SET "_version=11 Beta 1"
SET "_build=11.0.10010.100"
SET "_quantum-ver=1.0rc2"
SET "_ni-ver=11.0"
SET "_ni-SDK=11"


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

rem diskA-
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
rem  | Multiprocessing               | Unavailable       |
rem  | Graphics                      | Unavailable       |
rem  | Linux Envirnoment             | Unavailable       |
rem  | OS Name                       | winbatchOS Core   |
rem  | OS Release                    | 11.0              |
rem  | Channel                       | Canary            |
rem  | Flags                         | Unreleased        |
rem  | NI Kernel Version             | 23.0              |
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
call insertphoto 0 0 147 blankloadapp.%THEME%.bmp &call insertphoto 0 35 147 blankloadapp.%THEME%.bmp &call insertphoto 7 0 147 blankloadapp.%THEME%.bmp &call insertphoto 7 35 147 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 terminal.%THEME%.bmp

call insertphoto 1350 9 100 WindowedButtons.%THEME%.bmp

timeout /NOBREAK /T 0 > nul
:TERMINAL.LOOP
cls
rem for command line to focus back into the desktop
CALL Text 8 -1 0f "Terminal" 17 -1 03 "BETA" X _Button_Boxes _Button_Hover

call :DESKTOP.TASKBAR
call :DESKTOP.ICON
set _ACTIVEAPPLABEL=terminal.exe
call insertphoto 0 0 147 blankloadapp.dark.bmp &call insertphoto 0 35 147 blankloadapp.dark.bmp &call insertphoto 7 0 147 blankloadapp.dark.bmp &call insertphoto 7 35 147 blankloadapp.dark.bmp

call insertphoto 1350 9 100 WindowedButtons.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c f

call insertphoto 25 12 8 Terminal.dark.bmp

call insertphoto 1350 9 100 WindowedButtons.%THEME%.bmp



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

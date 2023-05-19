
rem WinBatchOS Server 23 (Rev2Final) - Build 1212 Q1.1TRIM NI11.9
rem This software is NOW licensed under the Microsoft Public License (Ms-PL).


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




rem  +++
rem  |-------------------------------|-------------------|
rem  | OS Specifics:                 |                   |
rem  |-------------------------------|-------------------|
rem  | Virtual Disk Version          | Unavailable       |
rem  | Stacks                        | Unavailable       |
rem  | Graphics                      | Unavailable       |
rem  | Java Envirnoment              | Unavailable       |
rem  | Linux Envirnoment             | Unavailable       |
rem  | OS Name                       | winbatchOS Server |
rem  | OS Release                    | 11.S              |
rem  | Channel                       | Stable            |
rem  | Flags                         | RTM-Rev2          |
rem  | Quantum Kernel Version        | 1.1beta1          |
rem  | NI Kernel Version             | 11.Sbeta1         |
rem  | Build Release                 | 1212.100          |
rem  | Installed Updates:            | 0                 |
rem  | Last Security Update Patch    | None              |
rem  |-------------------------------|-------------------|
rem  +++







rem This build will NOT overwrite any changes in the current Qkernel version before 1.1 but it is stable!



@Echo off
IF "%~1" == "" start WinBatchOS start &&endlocal &&exit /b
IF "%~1" == "start" goto :boot.exe
IF "%~1" == "startre" call winbatchos/RECOVERY.BAT


:BOOT.EXE
cls
cd System

FOR %%A In (batbox.exe Getlen.bat Box.bat GetInput.exe cmdmenusel.exe ) DO (IF Not Exist "%%A" (goto HALT-error))

setlocal disableDelayedExpansion

set q=^"
echo(
echo(

echo.

PROMPT $G
mode 50,10
timeout /T 1 /NOBREAK > nul
mode 240,60
Title WinBatchOS Operating System

set ver-win=18.S
set quantum_ver=v1.1TRIM
set ni_ver=11.8
set "_build=1212"
set "_version=2023S"
set "_OS=WinBatchX"


set CMD.EXE=OFF
set DESKTOP.EXE=off
set EXPLORER.EXE=off
set EDGE.EXE=off
set NOTEPAD.EXE=off
set SECURITY.EXE=off 
set SETTINGS.EXE=off

set DESKTOP=DESKTOP1
set DESKTOP1=desktop.exe
set DESKTOP2=desktop.exe
set DESKTOP3=desktop.exe
set DESKTOP4=desktop.exe
set DESKTOP5=desktop.exe
set DESKTOP6=desktop.exe
set DESKTOP7=desktop.exe
set DESKTOP8=desktop.exe
set DESKTOP9=desktop.exe
set DESKTOP10=desktop.exe

set USER=Guest
set PASSWORD=bes

set ACTIVEAPP=DESKTOP.EXE

cls
call :c 03 "WinBatchOS is starting.." /n
echo [SYSTEM] WinBatchOS is starting Server Core..



:: 5. Update Manager - wget v1.0beta2

	:: Set Variable for _link=
	SET "_Link=https://github.com/bes-ptah/WinBatchX/archive/refs/heads/main.zip"

	:: download it quietly using -q
	wget -q "%_Link%" > nul

	:: Unpack it
	tar -xf main.zip

	:: Enter the directory (always this name)
	cd winbatchx-main

	:: Enter the update directory

	cd update

	:: CALL the program, not go into it
	call update.bat

	:: Then remove the old files.
	del update.bat
	cd ..
	rmdir update > nul
	del LICENSE
	del README.md
	del config.yml

	:: go back into the system directory.
	cd ..

	:: remove the folder.
	rmdir winbatchx-main > nul

	:: delete the zip file downloaded.
	del main.zip


 


:: 6. Security 
set CD_winbatchx=%CD%
cd C:\Program Files\Windows Defender
MpCmdRun -Scan -ScanType 3 -File %CD_winbatchx% > nul
cd %CD_winbatchx%


timeout /T 5 /NOBREAK > nul






:USERS.EXE
cls
set pass-login=wrong
goto login

:login
color f0
cls
call :c f3 "%USER%        " /n
echo.& set /p pass-login= Password: 

goto pass-check

:pass-check
IF %PASS-login%==%PASSWORD% goto DESKTOP.EXE
goto login

rem internal kernel TRIM for v1.1
rem some code methods by me were not open-sourced but are now ported to be open-sourced
:KERNEL.EXE

goto :KERNEL.EXE



:DESKTOP.EXE
cls
title WinBatchX %ver-win%

color 30

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo Build 1210: %_WBXCore-updatemessage%
echo.
echo.
echo.
echo.
echo.
echo WinBatchX 18.S (Minimal Version)
echo Packed with Quantum Kernel 0.6 (Also Minimal Version)
echo.
call :c 33 "                                                                                                                                                                                                               " /n 
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n

:DESKTOP.EXE-LOOP

Call Button 88 55 f0 "Start" 97 55 f0 "Search" 107 55 f0 "Desk" 115 55 f0 "%ACTIVEAPP%" 193 55 f0 "%TIME%" X _Button_Boxes _Button_Hover

GetInput /M %_BOx% %_Button_Boxes% /H 80
Set _Selection=%Errorlevel%


Set /A _Selection-=6

if %Errorlevel%==1 goto start.exe
if %Errorlevel%==2 goto search.exe
if %Errorlevel%==3 goto desk.exe
if %Errorlevel%==4 goto %ACTIVEAPP%
if %Errorlevel%==5 goto timemenu.exe

timeout /T 1 /NOBREAK > nul
goto crash



:timemenu.exe
title WinBatchX %ver-win%

color 30

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
call :c 33 "                                                                                                                                                                                                               " /n 
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n

:TIMEMENU-LOOP

Call Button 88 55 f0 "Start" 97 55 f0 "Search" 107 55 f0 "Desk" 115 55 f0 "%ACTIVEAPP%" 193 55 f0 "%TIME%" 193 46 f0 "Power" 187 50 f0 "Action Center" X _Button_Boxes _Button_Hover

GetInput /M %_BOx% %_Button_Boxes% /H 80
Set _Selection=%Errorlevel%


Set /A _Selection-=6

if %Errorlevel%==1 goto start.exe
if %Errorlevel%==2 goto search.exe
if %Errorlevel%==3 goto desk.exe
if %Errorlevel%==4 goto %ACTIVEAPP%
if %Errorlevel%==5 goto timemenu.exe
if %Errorlevel%==6 goto power.exe
if %Errorlevel%==7 goto action.exe
timeout /T 1 /NOBREAK > nul
goto :crash


:power.exe
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
cmdmenusel f8%f0 "Shutdown" "Restart" "Logout" "Cancel"
if %ERRORLEVEL% == 1 goto shutdown.exe
if %ERRORLEVEL% == 2 goto boot
if %ERRORLEVEL% == 3 goto login
if %ERRORLEVEL% == 4 goto goto DESKTOP.EXE



:start.exe
cls

REM START-MENU_EXPLORER.EXE
title WinBatchX %ver-win%

color 3f

cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
call :c 33 "                                                                                                                                                                                                               " /n 
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n


:START.EXE-LOOP
Call Button 88 55 f0 "Start" 97 55 f0 "Search" 107 55 f0 "Desk" 115 55 f0 "%ACTIVEAPP%" 193 55 f0 "%TIME%" 63 10 70 "Command Line" 63 20 70 "WinBatchX Explorer" 125 20 70 "Microsoft Edge" 94 10 70 "Notepad" 94 20 70 "WinBatchX Security" 125 10 70 "Settings" X _Button_Boxes _Button_Hover

GetInput /M %_BOx% %_Button_Boxes% /H 80
Set _Selection=%Errorlevel%


Set /A _Selection-=6

if %Errorlevel%==1 goto start.exe
if %Errorlevel%==2 goto search.exe
if %Errorlevel%==3 goto desk.exe
if %Errorlevel%==4 goto %ACTIVEAPP%
if %Errorlevel%==5 goto timemenu.exe
if %Errorlevel%==6 goto cmd.exe
if %Errorlevel%==7 goto explorer.exe
if %Errorlevel%==8 goto edge.exe
if %Errorlevel%==9 goto notepad.exe
if %Errorlevel%==10 goto security.exe
if %Errorlevel%==11 goto settings.exe
timeout /T 1 /NOBREAK > nul
goto :crash






:desk.exe
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo WinBatchX 18.S (Minimal Version)
echo Packed with Quantum Kernel 0.6 (Also Minimal Version)
echo.
call :c 33 "                                                                                                                                                                                                               " /n 
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n
call :c f3 "                                                                                                                                                                                                               " /n

:taskloop

Call Button 88 55 f0 "Start" 97 55 f0 "Search" 107 55 f0 "Desk" 115 55 f0 "%ACTIVEAPP%" 193 55 f0 "%TIME%" 36 10 0f "Desktop 1" X _Button_Boxes _Button_Hover

GetInput /M %_BOx% %_Button_Boxes% /H 80
Set _Selection=%Errorlevel%


Set /A _Selection-=6

if %Errorlevel%==1 goto start.exe
if %Errorlevel%==2 goto search.exe
if %Errorlevel%==3 goto desk.exe
if %Errorlevel%==4 goto %ACTIVEAPP%
if %Errorlevel%==5 goto timemenu.exe
if %Errorlevel%==6 goto timemenu.exe

timeout /T 1 /NOBREAK > nul
goto crash







call :c 88 "                                                                                                                                                              " /n
call :c 88 " About WinBatchX Windows                                                                                                                                  " /n
call :c 88 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "  "&call :c 79 "      "&call :c bb "     "&call :c 79 "   "&call :c bb "     "&call :c 79 "                                           " /n
call :c 77 "  "&call :c 79 "      "&call :c bb "     "&call :c 79 "   "&call :c bb "     "&call :c 79 "                                           " /n
call :c 77 "                        Mircosoft Windows (WinBatchX Windows)                                                                                                  " /n
call :c 77 "  "&call :c 79 "      "&call :c bb "     "&call :c 79 "   "&call :c bb "     " /n
call :c 77 "  "&call :c 79 "      "&call :c bb "     "&call :c 79 "   "&call :c bb "     " /n
call :c 70 "         WinBatchX                                                                                                                                        " /n
call :c 70 "         Version %ver-win%                                                                                                                                         " /n
call :c 70 "                                                                                                                                                              " /n
call :c 70 "                                                                                                                                                              " /n
call :c 70 "                                                                                                                                                              " /n
call :c 70 "        This product can be edited even if it is closed-source.                                                                                               " /n
call :c 70 "        It is highly configuable since it is made by batch languages from .bat files.                                                                         " /n

call :c 70 "        Read the README section of WinBatchX inside your default Windows 10.                                                                                   " /n





:CMD.EXE
cls
echo SUPPEND WinBatchX Kernel
echo [ WinBatchX KERNEL ] HALT
echo Start WinBatchX-DOS... done 
echo.
echo Type EXIT to go back into WinBatchX. The kernel has been halted (suppended).
goto os 

:os
set SELECTION=0
set /p selection= %user%@MSDOS:
IF %SELECTION%==cls cls &goto os
IF %SELECTION%==help goto help-dos
IF %SELECTION%==dir echo. &dir &echo. &goto OS
IF %SELECTION%==logoff goto login
IF %SELECTION%==exit goto DESKTOP.EXE
IF %SELECTION%==logout goto login
IF %SELECTION%==ver echo MS-DOS %DOS_ver% &echo. &goto os
IF %SELECTION%==exit goto os
IF %SELECTION%==0 goto os
echo The command "%SELECTION%" does not exist.
goto os

:help-dos
echo.
echo CLS         Clears the command line.
echo DIR         Shows directories and files in the current directory.
echo LOGOFF      Loggoff the computer.
echo VER         Shows version of MS-DOS.
echo RESTART     Restarts the computer.
echo SHUTDOWN    Shuts down the computer.
echo.
goto os







:SETTINGS.EXE
cls

call :c 33 "                                                                                                                                                                                                               " /n

Call Button 3 10 f0 "SYSTEM AND SECURITY" 3 15 f0 "Computer Status" 3 20 f0 "Send a bug report" 3 25 f0 "Network" 3 30 f0 "Status with Edge" 3 35 f0 "Update" 3 40 f0 "Apperence, Background and Personalization" 61 0 f0 "X"  X _Button_Boxes _Button_Hover


REM Enabling Mouse Interaction with Cmd.. using 'GetInput'
GetInput /M %_BOx% %_Button_Boxes% /H 70
Set _Selection=%Errorlevel%





Set /A _Selection-=6

IF /I "%_Selection%" == "1" (Title Button 1 Clicked)
IF /I "%_Selection%" == "2" (Title Button 2 Clicked)
IF /I "%_Selection%" == "3" (Title Button 3 Clicked)
IF /I "%_Selection%" == "4" (Title Button 4 Clicked)
IF /I "%_Selection%" == "5" (Title Button 5 Clicked)
IF /I "%_Selection%" == "6" (Title Button 6 Clicked)
IF /I "%_Selection%" == "7" (Title Button 7 Clicked)
IF /I "%_Selection%" == "8" (Title Button 8 Clicked)

if %Errorlevel%==1 goto CONTROL.EXE-SYSTEM
if %Errorlevel%==2 goto CONTROL.EXE-STATUS
if %Errorlevel%==3 goto CONTROL.EXE-REPORT
if %Errorlevel%==4 goto CONTROL.EXE-EDGE
if %Errorlevel%==5 goto CONTROL.EXE-EDGE
if %Errorlevel%==6 goto UPDATE.EXE
if %Errorlevel%==7 goto CONTROL.EXE-PERSON
if %Errorlevel%==8 goto close-process-control
goto CONTROL.EXE







:EXPLORER.EXE
title WinBatchX

cls
echo EXPLORER.EXE VERSION 1.50
echo CMD MODE
echo [ SYSTEM-B ] There is no User Interface for Explorer.exe right now.
echo [ SYSTEM-B ] Reported to system.
echo starting.....................................................-
timeout /T 1 /NOBREAK > nul

:this-pc
cls
echo This PC
cmdmenusel f8%f0 "Drive C" "EXIT"
if %ERRORLEVEL% == 1 goto c-
if %ERRORLEVEL% == 1 goto DESKTOP.EXE



:c-
cls
cmdmenusel f8%f0 "back" "exit" "boot" "temp" "usr" "win" "win.old"
if %ERRORLEVEL% == 1 goto this-pc
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-boot-
if %ERRORLEVEL% == 4 goto c-temp-
if %ERRORLEVEL% == 5 goto c-usr-
if %ERRORLEVEL% == 6 goto c-win-
if %ERRORLEVEL% == 7 goto c-win.old-



:c-boot-
cls
cmdmenusel f8%f0 "back" "exit" "BIOS" "EFI" "GUI"
if %ERRORLEVEL% == 1 goto c-
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-boot-bios-
if %ERRORLEVEL% == 4 goto c-boot-efi-
if %ERRORLEVEL% == 5 goto c-boot-GUI-

:c-boot-bios-
cls
cmdmenusel f8%f0 "back" "exit" "boot32.bios"
if %ERRORLEVEL% == 1 goto c-boot- 
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 echo no access &pause &goto c-boot-BIOS

:c-boot-EFI-
cls
cmdmenusel f8%f0 "back" "exit" "boot32_64_Gen2_Gen1.efi" 
if %ERRORLEVEL% == 1 goto c-boot- 
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 echo no access &pause &goto c-boot-EFI



:c-boot-GUI-
cls
cmdmenusel f8%f0 "back" "exit" "Getinput.exe" "Getlen.bat" "cmdmenusel.exe" "button.bat" "box.bat" "batbox.exe"
if %ERRORLEVEL% == 1 goto c-boot- 
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 echo no access &pause &goto c-boot-GUI
if %ERRORLEVEL% == 4 echo no access &pause &goto c-boot-GUI
if %ERRORLEVEL% == 5 echo no access &pause &goto c-boot-GUI
if %ERRORLEVEL% == 6 echo no access &pause &goto c-boot-GUI
if %ERRORLEVEL% == 7 echo no access &pause &goto c-boot-GUI
if %ERRORLEVEL% == 8 echo no access &pause &goto c-boot-GUI




:c-temp-
cls
cmdmenusel f8%f0 "back" "exit" "Nothing is in this folder."
if %ERRORLEVEL% == 1 goto c-
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-temp-


:c-usr-
cls
cmdmenusel f8%f0 "back" "exit" "User1" "root"
if %ERRORLEVEL% == 1 goto c-
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-usr-user1
if %ERRORLEVEL% == 4 echo no access &pause &goto c-usr-

:c-usr-user1
cls
cmdmenusel f8%f0 "back" "exit" "Documents" "Downloads"
if %ERRORLEVEL% == 1 goto c-usr
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-usr-user1-Documents-
if %ERRORLEVEL% == 4 goto c-usr-user1-Downloads-

:c-usr-user1-Documents-
cls
cmdmenusel f8%f0 "back" "exit" "User1" "No items OR folders shown."
if %ERRORLEVEL% == 1 goto c-usr-user1-
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-usr-user1

:c-usr-user1-Downloads-
cls
cmdmenusel f8%f0 "back" "exit" "User1" "No items OR folders shown."
if %ERRORLEVEL% == 1 goto c-usr-user1-
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-usr-user1



:c-win-
cls
cmdmenusel f8%f0 "back" "exit" "WinBatchX.bat"
if %ERRORLEVEL% == 1 goto c-
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 echo This process is running right now.  &pause &goto c-boot-GUI


:c-win.old-
cls
cmdmenusel f8%f0 "back" "exit" "No items OR folders shown."
if %ERRORLEVEL% == 1 goto c-
if %ERRORLEVEL% == 2 goto DESKTOP.EXE
if %ERRORLEVEL% == 3 goto c-win.old-









:explorer.exe-recycle
cls
echo Nothing is in trash.
pause
goto DESKTOP.EXE



:EDGE.EXE
cls

color 70

call :c 88 "                                                                                                                                                              " /n
call :c 88 " Mircosoft Edge                   WinBatchX BUILD 1.9.23                                                                                                       " /n
call :c 88 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "   Start typing your website, example- google.com. When you press ENTER, it will use you 'default' browser inside your Operating System.                      " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "   Supported- Windows Vista/7/8/8.1/10.                                                                                                                       " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                                                                                                                                                              " /n
call :c 77 "                      Mircosoft Edge Accounts and Favorites are not supported in WinBatchX.                                                                    " /n
call :c 88 "                                                                                                                                                              " /n
call :c 77 "                                      "set /p web=
start %web%
goto DESKTOP.EXE







:NOTEPAD.EXE 
title  WinBatchX %ver-win%
color f0
cls
call :c 88 "                                                                                                                                                              " /n
call :c 88 " Notepad                                            v1.5.0                                                                                                    " /n
call :c 88 "               To make a document, start writing NOW. When done, press ENTER. To exit, press ENTER NOW.                                                       " /n
call :c 33 "                                                                                                                                                              " /n

set /p WRITE=
echo Choose what to do. Type "EXIT" to exit, "OPEN" to open a file, "DEL" to delete a file, or press ENTER to continue. 
set notepad-choice=011
call :c 88 "                                          " &set /p notepad-choice= 
IF %NOTEPAD-CHOICE%==EXIT goto DESKTOP.EXE
IF %NOTEPAD-CHOICE%==OPEN goto DESKTOP.EXE
IF %NOTEPAD-CHOICE%==DEL goto DESKTOP.EXE
IF %NOTEPAD-CHOICE%==011 goto NOTEPADWRITETODISK

:notepadwritetodisk
echo.
echo Write the name for this document.
call :c 88 "                                          " &SET /p N= Document Name:
echo.
echo Save it as a text document or any other format you would like. 
echo For starters, type "txt" and press ENTER. 
echo HINT- Do not add the symbol "." in front of your file format.
echo.
call :c 88 "                                          " &set /p FORMAT= Save as:
echo.
echo %WRITE% > %N%.%format%
echo You have successfully created a document using Notepad Version 1.5.0.
echo Click a key to continue to WinBatchX. (DESTINATION- DESKTOP.EXE)
pause > nul
goto DESKTOP.EXE









:OPEN
cls
title  WinBatchX %ver-win%

color 70



set /p file=
FOR /F "tokens=*" %%i IN (%file%) DO @ECHO %%i
echo.

echo EXIT YOUR DOCUMENT WHEN YOU PRESS A KEY.
echo You will go to the WinBatchX NI Desktop.

echo Editing files has not been possible with WinBatchX.
echo This filesystem-typed can write to the windows disk. You can only read files after you edit them.
echo Going to NOTEPAD.EXE after clicking a key to continue.
pause > nul
goto NOTEPAD.EXE




:DEL
cls
echo Type the name of the file you want to delete.

echo Here Are All Of The Files Within This Operating System's Drive.
echo.
echo.

dir

set /p delete=
del %delete%
pause
goto NOTEPAD.EXE












:RUN.EXE
title Mircosoft WinBatchX
echo Type the program you want to start up. Example- DESKTOP.EXE to go back to desktop.
set /p runup=
goto %runup%
cls
echo.
echo.
echo This excutable file is not available.
pause
goto DESKTOP.EXE





:SECURITY.EXE

pause
goto DESKTOP.EXE

:SHUTOFF.EXE
cls
color b0
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                                                Shutting Down...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
call :c b0 "                                                              %logo%                                                                       " /n
call :c b0 "                                                                                                                                                              " /n
timeout /T 1 /NOBREAK > nul
exit











:ERROR.SYS
goto crash



:crash
cls
echo.
echo ERROR
echo.
echo.
echo.
echo  WinBatchX HAS STOPPED AFTER AN FATAL ERROR. 
echo.
echo  Report to WinBatchX an error has occured.
timeout /T 1 /NOBREAK > nul
goto boot
























:HALT-error
Color 30 
Cls 
Echo FUNCTION ERROR -  MISSING FILES
echo Check in the directory IF there is "batbox.exe Getlen.bat Box.bat GetInput.exe cmdmenusel.exe". All required.
echo Download WinBatchX again. If it still does not work, contact the adminstrators (as a bug report).
echo. HALT KERNEL 
pause 
goto HALT-error
exit








:: example: call :c 02 "hi "&call :c 0E "welcome "&call :c aa "                  " /n

echo(

exit /b

:c

setlocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b


:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b


:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt"
>nul subst ': /d
exit /b





rem TODO: Reset the Recovery Environment
:WBX-RECOVER.EXE
rem  (!) If you're wondering how to get to recovery, open a command prompt and type 'WinBatchX startre'

setlocal
chcp 437 > nul
cd WINBATCHX

cls 
PIXELDRAW /refresh 00
cmdwiz showcursor 0
Window GSize Max
color 0f

call insertphoto 0 0 85 bootimage.bmp

rem  start the boot screen
CALL BOX 66 17 10 55 - - f3  f
call Text 67 17 f0 "WinBatchX Recovery" X _Button_Boxes _Button_Hover
call Text 67 19 f8 "Loading Recovery." X _Button_Boxes _Button_Hover

rem  Create the progress bar
CALL BOX 70 18 5 0 - - 33  3


rem  Terminal cursor reset
call Text 0 0 f3 "WinBatchX Recovery" X _Button_Boxes _Button_Hover


rem  =========================================================================================
rem  Boot WinBatchX Recovery steps:
rem  =========================================================================================
rem  1. Set General Variables
rem  2. Set reason of recovery
rem  3. Start what needs to be started
rem  =========================================================================================

rem  IF anything goes wrong from here it will enter a crash state with a description where it crashed.

rem  1.

SET "_version=0"
SET "_build=23.0.10000"
SET "_OS-WBX=WinBatchX Recovery"
Title WinBatchX Recovery Enviroment - %_version%

rem  Update the progress bar
timeout /T 3 /NOBREAK > nul
CALL BOX 71 18 5 0 - - 33  3
CALL BOX 72 18 5 0 - - 33  3
CALL BOX 73 18 5 0 - - 33  3
CALL BOX 74 18 5 0 - - 33  3



rem  2.
SET "_RECOVERY-REASON=WinBatchX Recovery."
rem  this variable above can be changed later on.

rem  tell the system to go down; no goto
SET "_RECOVERY-GOTO=NONEXECUTABLE"


rem  Update the progress bar
timeout /T 2 /NOBREAK > nul
CALL BOX 75 18 5 0 - - 33  3
CALL BOX 76 18 5 0 - - 33  3

rem  Update what's happening to the screen
call Text 67 19 f8 "Loading %_RECOVERY-REASON%." X _Button_Boxes _Button_Hover

rem  Terminal cursor update
call Text 0 0 ff "             " X _Button_Boxes _Button_Hover


rem  3.




rem  Update the progress bar
timeout /T 2 /NOBREAK > nul
CALL BOX 77 18 5 0 - - 33  3
CALL BOX 78 18 5 0 - - 33  3
CALL BOX 79 18 5 0 - - 33  3
CALL BOX 80 18 5 0 - - 33  3

rem  Update what's happening to the screen
call Text 67 19 f8 "Loading into memory" X _Button_Boxes _Button_Hover
call Text 67 20 f8 "System may take a while." X _Button_Boxes _Button_Hover




rem  Update the progress bar
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

rem  Update what's happening to the screen
call Text 67 19 f8 "Please Wait..                " X _Button_Boxes _Button_Hover
rem  note- erase earlier
call Text 67 20 ff "                             " X _Button_Boxes _Button_Hover

timeout /T 1 /NOBREAK > nul
cls

call Text 67 19 0f "There are are no options to" X _Button_Boxes _Button_Hover
call Text 67 20 0f "recovery right now." X _Button_Boxes _Button_Hover
call Text 67 25 04 "Press a key to exit" X _Button_Boxes _Button_Hover

pause > nul
exit /b

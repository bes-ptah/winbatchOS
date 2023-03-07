



rem  winbatchOS Edge - There is no official license yet. 
rem  Respectivly is 'outbranched' from Microsoft Edge.
:EDGE.EXE
set _APP.EXE=1
IF %_EDGE.EXE%==1 goto :EDGE.LOOP
set _ACTIVEAPPLABEL=edge
set _ACTIVEAPPIMAGE=edge
SET _ACTIVEAPPTITLE=Edge
call :KERNEL.API.APPSTART

set _EDGE.EXE=1
set _EDGE.VERSION=13
set _EDGE.OS=WbOS

call insertphoto 0 0 147 blankloadapp.%THEME%.bmp &call insertphoto 0 35 147 blankloadapp.%THEME%.bmp &call insertphoto 7 0 147 blankloadapp.%THEME%.bmp &call insertphoto 7 35 147 blankloadapp.%THEME%.bmp

PIXELDRAW /dr 0 0 /rd 1490 783 /c 0

call insertphoto 730 330 40 edge.light.bmp
 
call insertphoto 1350 9 100 WindowedButtons.%THEME%.bmp

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

call insertphoto 1350 9 100 WindowedButtons.%THEME%.bmp


Call insertphoto 16 20 120 edge.tabs.bmp

Call insertphoto 57 20 120 edge.newtab.bmp
Call insertphoto 180 26 120 UI.context.close.explorer.bmp
CALL Text 10 1 %THEMEcolor% "New Tab" X _Button_Boxes _Button_Hover

PIXELDRAW /dl /p 0 100 1490 100 /c 0

CALL Text 10 1 %THEMEcolor% "Edge Version 1.5" X _Button_Boxes _Button_Hover



PIXELDRAW /dl /p 0 100 1490 100 /c 7

call :DESKTOP.TASKBAR
call :DESKTOP.ICON



goto :KERNEL.EXE



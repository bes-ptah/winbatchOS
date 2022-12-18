@echo off

Window GSize Max

set L_PATH=.
if not "%~1" == "" set L_PATH=%1

set DIM_MOD=0
cmdwiz getconsoledim sw
set L_W=%ERRORLEVEL%
set L_OLDW=%L_W%
::set L_W=80&set DIM_MOD=1
if %L_W% lss 80 set L_W=80&set DIM_MOD=1
if not "%~2" == "" set L_W=%~2&set DIM_MOD=1

for %%p in ( "%PATH:;=" "%" ) do if "%%~p\." == "%~dp0." goto :no_set_path
set "Path=%Path%;%~dp0"
:no_set_path

cmdwiz getconsoledim h
set L_OLDBH=%ERRORLEVEL%

cmdwiz getconsoledim sh
set L_H=%ERRORLEVEL%
set L_OLDH=%L_H%
::set L_H=50&set DIM_MOD=1
if %L_H% lss 50 set L_H=50&set DIM_MOD=1
if not "%~3" == "" set L_H=%~3&set DIM_MOD=1

set /a L_COLUMNS=%L_W%/20
if %L_COLUMNS% lss 1 set L_COLUMNS=1
if %L_COLUMNS% gtr 9 set L_COLUMNS=9
set /A L_COLUMNS=-%L_COLUMNS%
::set L_COLUMNS=4
if not "%~4" == "" set L_COLUMNS=%~4

set L_MOUSE=Y
if not "%~5" == "" set L_MOUSE=





CALL BOX 75 20 15 80 - - f0 1

Call Button 82 25 f0 "To exit EXPLORER.EXE (listc), press ESC." X _Button_Boxes _Button_Hover
CALL Button 132 30 f0 "  Okay  " X _Button_Boxes _Button_Hover

GetInput /M %_BOX% %_Button_Boxes% /h 0f
SET _SELECTION=%Errorlevel%

SET /A _SELECTION-=6

IF /I "%_SELECTION%" == "1" (Title Button 1 Clicked)

IF %Errorlevel%==1 GOTO continued


:continued

echo Initialization...
call listc.bat 0 145 55 2 "%~dp0extendlistc.bat" %L_MOUSE%


if %DIM_MOD%==1 mode con cols=%L_OLDW% lines=%L_OLDH%&cls&cmdwiz setbuffersize %L_OLDW% %L_OLDBH%
if %DIM_MOD%==0 cmdwiz setbuffersize %L_W% %L_OLDBH%

set L_W=&set L_H=&set L_COLUMNS=&set L_MOUSE=&set L_PATH=&set L_OLDBH=&set DIM_MOD=&set L_OLDW=&set L_OLDH=
endlocal
exit /b
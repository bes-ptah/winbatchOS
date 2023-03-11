@echo off
setlocal enabledelayedexpansion
rem This is the function to print typographic text on the cmd console...
rem Created by kvc
rem :: www.thebateam.org

rem [%~1] : Font file to load...[Learn to create font files at www.thebateam.org]
REM [%~2] : x_POS of text...
rem [%~3] : y_POS of text...
rem [%~4] : color code [hexadecimal] e.g. f0
rem [%~5] : text to print on console...

rem ::---- checking if the variables are defined or not... ----
if /i "%~1" == "" (exit /b 1)
if /i "%~1" == "/?" (goto :Help)
if /i "%~1" == "-h" (goto :Help)
if /i "%~1" == "/h" (goto :Help)
if /i "%~1" == "Help" (goto :Help)
if /i "%~1" == "Ver" (Echo.Q0.5&&Exit /b 0)

if /i "%~2" == "" (exit /b 1)
if /i "%~3" == "" (exit /b 1)
if /i "%~4" == "" (exit /b 1)
if /i "%~5" == "" (exit /b 1)

call :chk_window_size Lines Columns
set /a columns-=6

If "%~1" NEQ "-" (
:Load_Font_file
for /f "eol=# tokens=1,2 delims==" %%A in (%~1) do (
	FOR /f "tokens=1,2,3 delims=x" %%a in ("%%B") do (
		set "_%%A_X=%%a"
		set "_%%A_Y=%%b"
		set "_%%A=%%c"
		)
	)
:Load_Database_file
for /f "eol=#" %%A in (ASCII.DB) do (Set "%%A")
)

set _X=%~2
set _Y=%~3
set color=%~4
set _final=

:loopy
if /i "%~5" == "" (goto end)
set "char=%~5"
Set Int=

getlen "!char!"
set /a len=!errorlevel!-1

For /l %%A in (0,1,!len!) do (
	For /l %%B in (1,1,254) do (
		IF "!Char:~%%A,1!" == "!%%B!" (Set "int=!int!%%B ")
	)
)

for %%A in (!int!) do (
set "_final=!_final!/o !_X! !_Y! !_%%A! "
set /a _X+=!_%%A_X!
if !_X! GEQ !columns! (set /a _Y+=13 && set _X=1)
)

set "_final=!_final!/o !_X! !_Y! !_32! "
set /a _X+=!_32_X!

shift /5
goto loopy

:end
batbox /c 0x!color! !_final! /c 0x07
exit /b 0


:Help
Echo.
Echo.This is the typography function created by Kvc for making batch programs
Echo.awesome. Program Ver.1.0, Final Release Date: 22-Dec-2015
Echo.
Echo.Syntax: Call Typo [ Font ^| '-' ] [X] [Y] [Color] [Text]
Echo.Syntax: Call Typo [/^? ^| Help ^| -H ^| /H]
Echo. 
Echo.Where:-
Echo. [Font ^| - ]	: Relative / Full path or name of the Font file, It is not
Echo.		  the regular 'ttf' File, It is the specially created file for
Echo.		  the typo function using 'Bpaints' by kvc. Font file contain
Echo.		  code executable by 'Batbox.exe' Plugin of Batch. Or you can 
Echo.		  simply specify '-' instead of Font file, If You've already 
Echo.		  loaded the 'font file' ^& 'ASCII.DB' file via using 'Load.bat'
Echo.		  utility provided within the typography function Folder. Font 
Echo.		  file must have the extension 'FO', in order to load into the
Echo.		  Cmd environment.
Echo. [X]		: The X position from where Typographic text will start.
Echo. [Y]		: The Y position from where Typographic text will start.
Echo. [Color]	: The color code [Hex] for the text to be printed. E.g. ff,f0..
Echo. [Text]		: The text to be printed on the console.
Echo.
Echo. Example : Call Typo Pixcel.Fo 1 5 ff Typo function test 1...
Echo. Example : Call Typo - 5 5 a0 Typo function Test 2... [If used load.bat earlier]
Echo.
Echo. As this is ver.1.0, it may contain some flaws or bugs, If you find anyone, 
Echo. Please do inform us at following link. or you can also contribute. Thanks ...
Echo.
Echo. For more, visit: www.thebateam.org
Echo. #TheBATeam
Echo.
Exit /b 0

rem ::-------------Extra functions by kvc --------------

:chk_window_size
mode con | find "%~1">"%temp%\%~1.tmp"
mode con | find "%~2">"%temp%\%~2.tmp"
set /p q=<"%temp%\%~1.tmp"
set /p w=<"%temp%\%~2.tmp"
set /a %~1=%q:~-6%
set /a %~2=%w:~-6%
goto :eof

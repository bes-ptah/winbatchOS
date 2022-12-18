@echo off
setlocal enabledelayedexpansion

REM This circle Algorithm is not created by kvc, but function is created [not completely] and modified by Kvc for making it more simple and
REM Easy to use, and making it more efficient for printing at once using batbox.exe plugin.

REM Created and Modified by Kvc, at 12:15 AM, 23.2.2016
REM For more, visit: www.thebateam.org
REM #TheBATeam

REM Checking for various parameters of the function...
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "-help" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "ver" (echo.Q0.5&&goto :End)
If /i "%~1" == "" (goto :help)
If /i "%~2" == "" (goto :help)
If /i "%~3" == "" (goto :help)

:Main
set x0=%1
set y0=%2
set Radius=%3
If /i "%~4" == "" (Set _Char=/a 111) Else (
	Set _Temp_Char=%~40123456789
	For /l %%A in (0,1,9) do (Set _Temp_Char=!_Temp_Char:%%A=!)
	IF /i "!_Temp_Char!" == "" (Set _Char=/a %~4) Else (Set _Char=/d %~4)
)
If /i "%~5" == "" (Set _Color=07) Else (Set _Color=%~5)

set X=!radius!
set Y=0
set /a decisionOver2 = 1 - !x!
Set _Circle=

:circle_loop
if !x! geq !y! (
	set /a "hor=x + x0","ver=y + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "
	set /a "hor=y + x0","ver=x + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "
	set /a "hor=-x + x0","ver=y + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "
	set /a "hor=-y + x0","ver=x + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "
	set /a "hor=-x + x0","ver=-y + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "
	set /a "hor=-y + x0","ver=-x + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "
	set /a "hor=x + x0","ver=-y + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "
	set /a "hor=y + x0","ver=-x + y0"
	set "_Circle=!_Circle!/g !hor! !ver! !_Char! "

	set /a y+=1
	if !decisionOver2! leq 0 (
		set /a "decisionOver2 = !decisionOver2! + (2 * y^) + 1"
	) else (
		set /a x-=1
		set /a "decisionOver2 = !decisionOver2! + 2 * (y - x^) + 1"
	)
	goto circle_loop
)
If /i "%~6" == "" (batbox /c 0x%_Color% %_Circle% /c 0x07) Else (Endlocal && Set "%~6=/c 0x%_Color% %_Circle% /c 0x07")
goto :End

Call Circle 15 15 5 111 ff

:End
goto :EOF

:Help
Echo.
Echo. This function will simply print a GUI circle on console window.
echo. It will help in making batch files little more advanced and effective.
Echo. This file uses 'batbox.exe' plugin for printing circles fastly on console.
echo.
echo. Syntax: call Circle [X] [Y] [Radius] [Character ^| Character Code] [color] [Result]
echo. Syntax: call Circle [help ^| /^? ^| -h ^| -help]
echo. Syntax: call Circle ver
echo.
echo. Where:-
echo.
echo. X			: It is the X Co-ordinate of the center of the circle.
Echo. Y			: It is the Y Co-ordinate of the center of the circle.
Echo. Radius			: The radius value of the required circle.
Echo. Char ^| Char_Code	: It maybe either Directly the character or the ASCII
Echo.			  Value of the Character.
Echo. Color			: The color of the circle.
Echo. Result			: No need of always specifying this parameter, it is a 
Echo.			  special case parameter.In any case, if you needed the
Echo.			  code of the circle instead of directly printing it on
Echo.			  console, then you can specify this parameter, and the
Echo.			  respective code for the circle will be saved into the
Echo.			  variable named in this parameter...
Echo.
Echo. Example: Call Circle 15 15 5 111 0a
Echo. Example: Call Circle 15 15 5 o 0a
Echo. Example: Call Circle 15 15 5 111 0a _Result
Echo. 
Echo. Now, you can execute the code saved in '_Result' variable, using 'Batbox.exe'
Echo. file...
Echo. www.thebateam.org
Echo. #TheBATeam
goto :End
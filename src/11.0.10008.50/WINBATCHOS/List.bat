@Echo off


Set _Ver=Q0.5


If /i "%~1" == "" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "-help" (goto :help)

If /i "%~1" == "ver" (echo.%_Ver%&&goto :eof)


If /i "%~2" == "" (goto :help)
If /i "%~3" == "" (goto :help)
If /i "%~4" == "" (goto :help)


:List
Setlocal Enabledelayedexpansion
Set _List_Count=1
Set _List_Width=1
Set _Final=
Set _Return_code=0

set x_val=%~1
set y_val=%~2
set color=%~3
if /i "!color!" == "-" (set color=07) Else (set "color=%~3")

Set /a y_val_old=!y_val! + 1


:List_Loop

Set "Item_!_List_Count!=%~4"


Call Getlen "%~4"
Set _Temp_width=!ErrorLevel!
IF !_Temp_width! GTR !_List_Width! (Set _List_Width=!_Temp_width!)

Set Item_!_List_Count!_Width=%_Temp_width%


Shift /4
IF /I "%~4" == "" (Goto :Next)
Set /A _List_Count+=1
Goto :List_Loop

:Next

Set /A _List_Width=!_List_Width!+4
Set /A _List_Height=!_List_Count!+2
Set /A _Max_Width=!x_val! + !_List_Width! - 2
Set /A _Max_Height=!y_val_old! + !_List_Count! - 1
Set _Box=
Set _List_Space=


Call GetDim _Rows _Columns
Set /A _Rows-=2
Set /A _Columns-=1

IF %_Max_Width% GTR %_Columns% (
	Set /A _List_Width-=4
	Set /A x_val-=%_List_Width%
	Goto :Next
	)
IF %_Max_Height% GTR %_Rows% (
	Set /A y_val-=%_List_Height%
	Set /a y_val_old=!y_val! + 1
	Goto :Next
	)


Set _Special_X=%_Max_Width%
Set _Special_Y=%y_val%
Set "_Special_Area= %_Special_X% %_Special_Y% %_Special_X% %_Special_Y%"
Set _Final=/c 0x%Color:~0,1%C /g %_Special_X% %_Special_Y% /d " " /c 0x%color%


Call Box %x_val% %y_val% %_List_Height% %_List_Width% - - %Color% 0


Set /A x_val+=2
Set y_val=!y_val_old!

For /l %%A In (1,1,!_List_Count!) DO (
	set "_final=!_final! /g !x_val! !y_val! /d "!Item_%%A!" "
	set /a y_val+=1
)


batbox.exe %_final% /c 0x07


Set y_val=!y_val_old!
Set /a x_val-=1
Set _Invert_color=%color:~1,1%%Color:~0,1%
Set _Hover=


For /l %%A In (1,1,!_List_Count!) DO (
	Set "_Box=!_Box!!x_val! !y_val! !_Max_Width! !y_val! "
	Set /A y_val+=1
	Set "_Hover=!_Invert_color!!_Hover! "
	)


Set _Box=%_Box:~0,-1%
rem  %_Special_Area%
Set _Hover=%_Hover% C%Color:~1,1%

:: To test List:
:: echo %_Box%

Set /A _List_Count+=1

:User_Input

Set _Result=
GetInput /M %_Box% /H f8
Set _Result=%Errorlevel%

IF %_Result% == 27 (Set _Return_code=0 && Goto :End)
IF %_Result% == %_List_Count% (Set _Return_code=0 && Goto :End)

If %_Result% GTR %_List_Count% (Goto :User_Input)

Set _Return_code=%_Result%

:End
Exit /b !_Return_code!


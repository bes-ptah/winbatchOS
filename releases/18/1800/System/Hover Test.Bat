@Echo off
cls


color 08
Echo. 
Echo. Hello, I'm a Text, Please Hover me...

:Top
For /f "Tokens=1,2,3,4* delims=:" %%A in ('Input.exe F') Do (
	Set _Input_Type=%%A
	Set _Parameter_1=%%B
	Set _Parameter_2=%%C
	Set _Parameter_3=%%D
	title WinBatchX [%%A] [%%B] [%%C] [%%D]
	)

REM Assuring Mouse Input...
IF /I "%_Input_Type%" == "m" (
	REM Assuring No Clicking, only Hover...
	IF /I "%_Parameter_1%" == "0" (
		If %_Parameter_2% Gtr 1 If %_Parameter_2% Lss 42 If %_Parameter_3% EQU 1 (CALL Button 0 0 0f "Hello, I'm a Text, Please Hover me..." X _Button_Boxes _Button_Hover) ELSE (CALL Button 0 0 f0 "Hello, I'm a Text, Please Hover me..." X _Button_Boxes _Button_Hover)
		)
	)

Goto :Top

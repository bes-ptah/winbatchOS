	set /A "xt=x*7"
	set /A "yt=y*14"

	PIXELDRAW /dr %xt% %yt% /rd 707 400 /c f

	set xtopwindow=%xt%
	set /A "ytopwindow=%yt%+43"
	call insertphoto %xt% %yt% 70 blankloadapp.%THEME%.bmp
	call insertphoto %xtopwindow% %ytopwindow% 70 blankloadapp.%THEME%.bmp

	set /A "xIcon=xt+12"
	set /A "yIcon=yt+8"
	call insertphoto %xIcon% %yIcon% 12 batchinstaller-light.bmp

	set /A "xTitle=x+5"
	set /A "yTitle=y"

	CALL Text %xTitle% %yTitle% %THEMEcolor% "AppTest" X _Button_Boxes _Button_Hover


	set /A "xControlButtons=xt+580"
	set /A "yControlButtons=yt+12"
rem PIXELDRAW limit is 1500, wording is by 215ish

	call insertphoto %xControlButtons% %yControlButtons% 100 WindowedButtons.bmp



	set /A "xControlUI=xControlButtons/580"
	set /A "yControlUI=yControlButtons/12"

	set /A "xControlUIend=xControlButtons+4"
	set /A "yControlUIend=yControlButtons+2"

	IF %M% EQU 1 IF %X% GTR %xControlUI% IF %Y% GTR %yControlUI% IF %X% LSS %xControlUIend% IF %Y% LSS %yControlUIend% goto :DESKTOP.EXE

	rem set xt=0
	rem set yt=0
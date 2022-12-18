
:SETUP.EXE
cls
PIXELDRAW /refresh 00
echo Loading..
cls
call insertphoto 0 0 %BACKGROUND.DESKTOP.SIZE% %BACKGROUND.DESKTOP.IMAGE%.%THEME%.bmp

call insertphoto 330 200 320 UI.buttonmica.bmp
call insertphoto 329 201 321 UI.buttonmica.bmp
call insertphoto 331 204 320 UI.buttonmica.bmp
call insertphoto 330 290 320 UI.buttonmica.bmp
call insertphoto 329 291 321 UI.buttonmica.bmp
call insertphoto 331 294 320 UI.buttonmica.bmp




CALL ButtonHeight0 70 20 %THEMEcolor% "Try upgrading WinBatchX to 18.1 for a automatic setup experience." X _Button_Boxes _Button_Hover

CALL ButtonHeight0 70 25 %THEMEcolor% "Click and hold anywhere to continue back to WinBatchX 18." X _Button_Boxes _Button_Hover
















Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f
Input /f



exit /b
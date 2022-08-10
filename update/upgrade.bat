CALL Button 40 16 f0 "WinBatchX 17.0, NI Version 11" X _Button_Boxes _Button_Hover
CALL Button 40 13 f0 "Do you want to install a new version?" X _Button_Boxes _Button_Hover
CALL Button 50 13 f3 "Yes" 55 13 fr "No" X _Button_Boxes _Button_Hover

GetInput /M %_BOX% %_Button_Boxes%
SET _SELECTION=%Errorlevel%

IF %Errorlevel%==1 GOTO :UPGRADECORE
IF %Errorlevel%==2 exit /b



:UPGRADECORE
wget -q "https://github.com/bes-ptah/WinBatchX/releases/download/1640/WinBatchXBuild1640.zip" > nul

move WinBatchXr17.0.zip ../




:: still in development, is not used yet

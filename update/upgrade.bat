:UPGRADECORE
wget -q "https://github.com/bes-ptah/WinBatchX/releases/download/1640/WinBatchXBuild1640.zip" > nul

move WinBatchXr17.0.zip ../



:WBX-UPGRADE
cd ..
cd ..
CALL Button 40 17 7f "WinBatchX 17.0, NI Version 11" X _Button_Boxes _Button_Hover
CALL Button 40 13 f0 "Do you want to install a new version?" X _Button_Boxes _Button_Hover
CALL Button 100 13 f3 "Yes" 115 13 f4 "No" X _Button_Boxes _Button_Hover

GetInput /M %_BOX% %_Button_Boxes%
SET _SELECTION=%Errorlevel%

IF %Errorlevel%==1 upgrade.bat
IF %Errorlevel%==2 cd WinBatchX-main &cd update &set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &del readme.md &del upgrade.bat &exit /b
cd WinBatchX-main &cd update &set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &del readme.md &del upgrade.bat &exit /b



:: still in development, is not used yet

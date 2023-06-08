ECHO OFF

rem Exit codes: (for 17.0ER- dev)
rem _WBXCore-update = (0 = up to date) (1 = not up to date) (2 = need to update, out of support) (3 = unknown error)
rem _WBXCore-updatemessage = (message for the latest release, or build)
rem _WBXCore-updatealert = (message for anything - major bug problems etc)


IF %_build%==23.0.10008.100 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You're on the latest build for winbatchOS Canary." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==23.0.10010.100 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You're on the latest build for winbatchOS Canary." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b

IF %_build%==24.0.10050.100 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You're on the latest build for winbatchOS Canary." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b



set "_WBXCore-update=1"
set "_WBXCore-updatemessage=Your build may not be up-to-date."
set "_WBXCore-updatealert=Check WinBatchX's github for more infomation. Your build could not recieve updates."
call news.bat
del news.bat
del upgrade.bat
del readme.md
exit /b

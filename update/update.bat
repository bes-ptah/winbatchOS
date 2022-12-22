ECHO OFF

rem Exit codes: (for pre15.5 - 16.0 preview builds)
rem 0x00 Supported.
rem 0x01 Not latest release.
rem 0x02 Unsupported.
rem 0x03 Unknown Error.

rem Exit codes: (for 17.0ER- dev)
rem _WBXCore-update = (0 = up to date) (1 = not up to date) (2 = need to update, out of support) (3 = unknown error)
rem _WBXCore-updatemessage = (message for the latest release, or build)
rem _WBXCore-updatealert = (message for anything - major bug problems etc)


rem 15.6 release - EoR January 2023
IF %_build%==1582 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b

rem 16.0 release - Check the EoR (End of Release) in wiki page.
IF %_build%==1600 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &del readme.md &del upgrade.bat &exit /b

rem 17.0 release - Check the EoR (End of Release) in wiki page.
IF %_build%==1640 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=Upgrade available" &set "_WBXCore-updatealert=For more infomation, open widgets." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b


rem 18.0 release - Check the EoR (End of Release) in wiki page.
IF %_build%==1800 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=You're on WinBatchX's latest release!" &set "_WBXCore-updatealert=For more infomation, open widgets." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b



rem WinBatchX 19 preview builds
IF %_build%==1802.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=A newer build is available" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1804.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1806.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1808.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b

rem Unreleased
IF %_build%==1810.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1812.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1814.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1816.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1818.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b

rem 18.1 Release - Check the EoR (End of Release) in wiki page.
IF %_build%==1820.1000 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=You're up to date" &set "_WBXCore-updatealert=You are on a developer build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b




rem 18.S Preview Builds
IF %_build%==1210 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=Your build is up to date. More info at https://github.com/bes-ptah/winbatchx" &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1702 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=Notreleased. More info at https://github.com/bes-ptah/winbatchx" &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1704 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=Notreleased. More info at https://github.com/bes-ptah/winbatchx" &del news.bat &del readme.md &del upgrade.bat &exit /b






SET update.exe=0x02
SET update-status-action.exe=0x02
set "_WBXCore-update=1"
set "_WBXCore-updatemessage=Newer Builds are in github!"
call news.bat
del news.bat
del upgrade.bat
del readme.md
exit /b

ECHO OFF

rem Exit codes: (for pre15.5 - 16.0)
rem 0x00 Supported.
rem 0x01 Not latest release.
rem 0x02 Unsupported.
rem 0x03 Unknown Error.

rem Build 1558+ are 16.0 beta/pre-release builds.

rem Beta testing: Web-only WinBatchX?
IF %_build%==1 call upgrade.bat &del upgrade.bat &exit /b

IF %_build% GTR 1558 IF %_build% LSS 1570 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &del upgrade.bat &exit /b

rem 15.5 Update - Check the EoR (End of Release) in wiki page.
IF %_build%==1572 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &del readme.md &del upgrade.bat &exit /b

:: Build 1574+ "release testing" stage for 16.0 releases
IF %_build%==1574 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1576 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1578 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &del upgrade.bat &exit /b

rem 16.0 release - Check the EoR (End of Release) in wiki page.
IF %_build%==1600 set update.exe=0x01 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b


rem 16.1 release beta builds:
IF %_build%==1600.1000 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1600.1500 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1600.2525 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1600.6000 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1600.7575 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b


rem Build 1600.10000 is the initial 16.1 release (and only)
IF %_build%==1600.10000 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &del upgrade.bat &exit /b

rem Builds 1601+ are 16.0 updates/fixes + will be added to WBX 16.1
rem Builds 1615+ are prerelease WBX-17 Builds
IF %_build% GTR 1601 IF %_build% LSS 1632 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b

IF %_build%==1633 set update.exe=0x00 &set update-status-action.exe=0x00 &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b








rem Builds 1634+ are beta WBX-17 Builds
rem (!) Note the way updates are recieved are now changed.

rem _WBXCore-update = (0 = up to date) (1 = not up to date) (2 = need to update, out of support) (3 = unknown error)
rem _WBXCore-updatemessage = (message for the latest release, or build)
rem _WBXCore-updatealert = (message for anything - major bug problems etc)
IF %_build%==1634 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=A newer build is in github" &set "_WBXCore-updatealert=This is not the latest build. The latest build is 1636." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1635 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=A newer build is in github" &set "_WBXCore-updatealert=This is not the latest build. The latest build is 1636." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1636 set "_WBXCore-update=1" &set "_WBXCore-updatemessage=A newer build is in github" &set "_WBXCore-updatealert=This is not the latest build. The latest build is 1636." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
rem 1637 is not a build

rem 17.0 Developer Builds, major changes
IF %_build%==1638 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=You're up to date!" &set "_WBXCore-updatealert=You are on the beta channel. Note- you may get unstable experiences with this build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b
IF %_build%==1639 set "_WBXCore-update=0" &set "_WBXCore-updatemessage=You're up to date!" &set "_WBXCore-updatealert=You are on the beta channel. Note- you may get unstable experiences with this build." &call news.bat &del news.bat &del readme.md &del upgrade.bat &exit /b

rem Builds 1670+ are "release testing" WBX-17 builds
rem Build  1700 is 17.0's release


rem 18.0... Build 2000






SET update.exe=0x03
SET update-status-action.exe=0x03
del news.bat
del upgrade.bat
del readme.md
exit /b









ECHO OFF

rem Exit codes:
rem 0x00 Supported.
rem 0x01 Not latest release.
rem 0x02 Unsupported.
rem 0x03 Unknown Error.

rem Build 1558+ are 16.0 beta/pre-release builds.
IF %_build% GTR 1558 IF %_build% LSS 1570 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &exit /b

rem 15.5 Update - Check the EoR (End of Release) in wiki page.
IF %_build%==1572 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &del readme.md &exit /b

:: Build 1574+ "release testing" stage for 16.0 releases
IF %_build%==1574 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &exit /b
IF %_build%==1576 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &exit /b
IF %_build%==1578 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &del readme.md &exit /b

rem 16.0 release - Check the EoR (End of Release) in wiki page.
IF %_build%==1600 set update.exe=0x01 &set update-status-action.exe=0x00 &del news.bat &del readme.md &exit /b


rem 16.1 release beta builds:
IF %_build%==1600.1000 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &exit /b
IF %_build%==1600.1500 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &exit /b
IF %_build%==1600.2525 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &exit /b
IF %_build%==1600.6000 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &exit /b
IF %_build%==1600.7575 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &exit /b


rem Build 1600.10000 is the initial 16.1 release (and only)
IF %_build%==1600.10000 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &del readme.md &exit /b

rem Builds 1601+ are 16.0 updates/fixes + will be added to WBX 16.1
rem Builds 1615+ are prerelease WBX-17 Builds
IF %_build% GTR 1601 IF %_build% LSS 1632 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &del readme.md &exit /b

rem Current build: 1633
IF %_build%==1633 set update.exe=0x00 &set update-status-action.exe=0x00 &call news.bat &del news.bat &del readme.md &exit /b

rem Builds 1634+ are beta WBX-17 Builds
rem Builds 1670+ are "release testing" WBX-17 builds
rem Build  1700 is 17.0's release


rem WBX-18 possibly? No. Just working on a GUI manager for now with a custom build! (I might even release this to beta)
rem Also aiming build 2000 for 18.0, going off the build system (16.0 = 1600, 17.0 = 1700, 18.0 = 2000- see the difference)
IF %_build%==1747 set update.exe=0x00 &set update-status-action.exe=0x00 &set update-newer-release-message="You are on the latest build." &call news.bat &del news.bat &exit /b







SET update.exe=0x03
SET update-status-action.exe=0x03
del news.bat
del readme.md
exit /b









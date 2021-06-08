ECHO OFF

rem Exit codes:
rem 0x00 Supported.
rem 0x01 Not latest release.
rem 0x02 Unsupported.
rem 0x03 Unknown Error.


IF %_build%==1558 set update.exe=0x01 &set update-status-action.exe=0x01 &exit /b
IF %_build%==1560 set update.exe=0x01 &set update-status-action.exe=0x01 &exit /b
IF %_build%==1562 set update.exe=0x01 &set update-status-action.exe=0x01 &exit /b
IF %_build%==1564 set update.exe=0x01 &set update-status-action.exe=0x01 &exit /b
IF %_build%==1566 set update.exe=0x01 &set update-status-action.exe=0x01 &exit /b
IF %_build%==1568 set update.exe=0x01 &set update-status-action.exe=0x01 &exit /b
IF %_build%==1570 set update.exe=0x01 &set update-status-action.exe=0x01 &exit /b

rem 15.5 Update - End of Release (EoR) is November 25 2021
IF %_build%==1572 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b

IF %_build%==1574 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1576 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1578 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b

rem 16.0 Release

rem 16.0 notes
rem 16.0 release - June      8 2021 - eor at September 21 2021
rem 16.1 release - September 3 2021 - eor at december 3 2021
rem 16.2 release - November 28 2021 - final eor at Febuary 15 2021
IF %_build%==1600 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b

IF %_build%==1601 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1602 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1603 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1604 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1605 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1606 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1607 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1608 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1609 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b
IF %_build%==1610 set update.exe=0x00 &set update-status-action.exe=0x00 &exit /b

SET update.exe=0x03
SET update-status-action.exe=0x03
exit /b









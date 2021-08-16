ECHO OFF

rem Exit codes:
rem 0x00 Supported.
rem 0x01 Not latest release.
rem 0x02 Unsupported.
rem 0x03 Unknown Error.


IF %_build%==1558 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1560 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1562 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1564 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1566 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1568 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1570 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b

rem 15.5 Update - Check the EoR (End of Release) in wiki page.
IF %_build%==1572 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &exit /b

IF %_build%==1574 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1576 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b
IF %_build%==1578 set update.exe=0x02 &set update-status-action.exe=0x02 &del news.bat &exit /b

rem 16.0 Release Notes

rem 16.0 notes
rem 16.0 release - Check the EoR (End of Release) in wiki page.
IF %_build%==1600 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &exit /b

IF %_build%==1601 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1602 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1603 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1604 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1605 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1606 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1607 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1608 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1609 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1610 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1611 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1612 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1613 set update.exe=0x01 &set update-status-action.exe=0x01 &del news.bat &exit /b
IF %_build%==1614 set update.exe=0x00 &set update-status-action.exe=0x00 &del news.bat &exit /b

rem Here: Builds 1615 and up will show the changelog about WinBatchX. 
IF %_build%==1615 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1616 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1617 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1618 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1619 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1620 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1621 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1622 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1623 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1624 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1625 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1626 set update.exe=0x01 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1627 set update.exe=0x00 &set update-status-action.exe=0x01 &call news.bat &del news.bat &exit /b
IF %_build%==1628 set update.exe=0x00 &set update-status-action.exe=0x00 &call news.bat &del news.bat &exit /b

SET update.exe=0x03
SET update-status-action.exe=0x03
del news.bat
exit /b









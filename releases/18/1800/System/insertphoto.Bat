@echo off

REM         Created by the WinBatchX Team
REM         This plugin is designed to make inserting images easy.
REM         .............................................................
REM         . Example: insertbmp /p:"TheBATeam.bmp" /x:607 /y:400 /z:15 .
REM         .............................................................
set _ver=Q0.6-ER5

Set _Xi=%~1
Set _Yi=%~2
set _Zi=%~3
set "_photoset=%~4"
Set "_cd-0-1=%~5"

:: Dont use 'cd' to fasten the image displaying stuff up
::cd BMP
insertbmp /p:"BMP/%_photoset%" /x:%_Xi% /y:%_Yi% /z:%_Zi%
::cd ..

exit /b
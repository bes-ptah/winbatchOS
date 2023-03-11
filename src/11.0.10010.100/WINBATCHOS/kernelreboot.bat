@echo off
If /i "%~1" == "reboot" (goto start)

goto :EOF


:start
cd ..
call WinBatchX.bat
exit
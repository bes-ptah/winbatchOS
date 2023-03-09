rem WBXUPDATE

rem  Wget - Retrieves data ONLY for WinBatchX Update.
rem  Call the 'WGET' service instad of the 'WBXUPDATE' service.
rem  (Also a copy of the WBXUPDATE service inside this WinBatchX build)

rem  Download it quietly with -q.
wget -q "https://github.com/bes-ptah/WinBatchOS/archive/refs/heads/main.zip" > nul

rem  Unpack it using tar.
tar -xf main.zip

rem  Enter the directory (always this name)
cd winbatchos-main

rem  Enter the update directory.
cd update

rem  Call the program!
call update.bat

rem  Then remove the old files without a request from user.
del update.bat > nul
cd ..
rmdir update > nul
del LICENSE
del README.md
del _config.yml

rem  Go back to the previous directory.
cd ..

rem  Remove the update folder
rmdir winbatchos-main > nul

rem  Also delete the downloaded compressed update file so the command line does not crash on the next update.
del main.zip
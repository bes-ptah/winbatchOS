@echo off
Setlocal EnableDelayedExpansion


Set ver=2.0

REM Setting up initial length...
set len=0

REM Checking for various inputs to the fucntion...
IF /i "%~1" == "" (Goto :End)
IF /i "%~1" == "/h" (Goto :Help)
IF /i "%~1" == "/?" (Goto :Help)
IF /i "%~1" == "-h" (Goto :Help)
IF /i "%~1" == "Help" (Goto :Help)
IF /i "%~1" == "" (Echo.%ver% && Goto :EOF)

:Main
set "s=%~1#"
for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!s:~%%P,1!" NEQ "" ( 
        set /a "len+=%%P"
        set "s=!s:~%%P!"
    )
)

:End
REM The Method Used below is called 'Tunnelling in batch'...
REM Using the variable of previous block in new block...
Endlocal && Exit /b %len%


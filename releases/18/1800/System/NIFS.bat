:: NIFS 2000
:: This software is based on the Unlicense License.

:: Unlicense License (also in ../LICENSE.txt)
:: - 
:: This is free and unencumbered software released into the public domain.
::
:: Anyone is free to copy, modify, publish, use, compile, sell, or
:: distribute this software, either in source code form or as a compiled
:: binary, for any purpose, commercial or non-commercial, and by any
:: means.
::
:: In jurisdictions that recognize copyright laws, the author or authors
:: of this software dedicate any and all copyright interest in the
:: software to the public domain. We make this dedication for the benefit
:: of the public at large and to the detriment of our heirs and
:: successors. We intend this dedication to be an overt act of
:: relinquishment in perpetuity of all present and future rights to this
:: software under copyright law.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
:: EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
:: MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
:: IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
:: OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
:: ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
:: OTHER DEALINGS IN THE SOFTWARE.
:: 
:: For more information, please refer to <https://unlicense.org>

:: NIFS: WinBatchX's New Interface File System
:: Note: This file system may contain bugs.
:: NIFS_Local (NIFS_SYSTEM.bat)
:: NIFS_Personal (NIFS_USER.bat)

@ECHO OFF
:: setlocal

:: Set NIFS Version

:: NI Version
set NIFS_VERSION=10.0

:: Set NIFS Build
set NIFS_BUILDVERSION=2000


:: Check: parameters of NIFS
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "-help" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "variables" (goto :help)
If /i "%~1" == "dir" (goto :help)
If /i "%~1" == "ver" (echo. &&echo New Interface Batch File System- NIFS &&echo Version %NIFS_VERSION%, Build %NIFS_BUILDVERSION%. NIFS is under the Unlicense License. &&echo. &&exit /b)
If /i "%~1" == "" (goto :help)
If /i "%~2" == "" (goto :help)
If /i "%~3" == "" (goto :help)

REM cordinates
:help

Set "_NIFSChoice1=%~1"
echo "%_NIFSChoice1%"
exit /b

:: stil in the works. NIFS arch:


:: To call NIFS:
:: All general variables will be set with this command:
:: =========================================================
:: call NIFS -variables

:: To call a file in the NIFS:
:: =========================================================
:: call NIFS -file "file.extension"

:: coming soon!







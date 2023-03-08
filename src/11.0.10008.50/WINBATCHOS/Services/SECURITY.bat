rem 17
rem  Using current updated update service.
rem  This may not work on older versions (Windows 7/8)
rem  or newer versions (Windows 11 Dev).
set "CD_winbatchx=%CD%"
cd C:\Program Files\Windows Defender
MpCmdRun -Scan -ScanType 3 -File %CD_winbatchx% > nul
rem  The 3rd flag tells it as a custom scan.
rem  Change directory back to WBX-17.
cd "%CD_winbatchx%"

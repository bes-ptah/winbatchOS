@Echo off
SetLocal EnabledelayedExpansion



If /i "%~1" == "" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "-help" (goto :help)

If /i "%~1" == "ver" (echo.Q0.5&&goto :eof)

If /i "%~2" == "" (goto :help)



Set _Parameter=1
For /f "Skip=3 tokens=2" %%A in ('mode con') do (Set "_!_Parameter!=%%A"&&Set /A _Parameter+=1)
Endlocal && Set "%~1=%_1%" && Set "%~2=%_2%"
Goto :EOF


@echo off

:Top
if /i "%~1" == "" (goto :eof)

If /i "%~x1" == ".FO" (
:Load_Font_file
for /f "eol=# tokens=1,2 delims==" %%A in (%~1) do (
	FOR /f "tokens=1,2,3 delims=x" %%a in ("%%B") do (
		set "_%%A_X=%%a"
		set "_%%A_Y=%%b"
		set "_%%A=%%c"
		)
	)
) ELSE (
:Load_Database_file
for /f "eol=#" %%A in (%~1) do (Set "%%A")
)
Shift /1
goto :Top

rem 11
rem Set Default Customizations Right Now
SET THEME=light
SET COLORMODE=0
SET ACCENT.COLOR=3
SET HIGHLIGHT.WINDOW.BORDERS=b
SET VOLUME=100
SET NOTIFICATIONS=0
SET DO-NOT-DISTURB=0

rem Default Set for background (lock screen)
SET BACKGROUND.LOCKSCREEN.IMAGE=background-lock
SET BACKGROUND.LOCKSCREEN.SIZE=77
SET _TASKBAR.ALIGNMENT=0

rem Default Set for background (desktop)
SET BACKGROUND.DESKTOP.IMAGE=background
SET BACKGROUND.DESKTOP.SIZE=100
SET _HOSTNAME-winbatchx=COMPUTER-0



rem 12
rem  Updated in WinBatchX Desktop 2023.
rem  Where'd it go? The file moved to the SystemData folder

call CoreData\data-system.bat

IF %START-STATUS%==1 Call Text 82 42 0f "Make sure you shut down your computer correctly. You did not shut down properly last time." X _Button_Boxes _Button_Hover
set START-STATUS=1
set RESTART-STATUS=0


rem write a new data-system.bat file
(
  echo SET START-STATUS=%START-STATUS%
  echo SET FLAG-RECOVERYRESTART=%FLAG-RECOVERYRESTART%
  echo SET HIBERNATE-STATUS=%HIBERNATE-STATUS%
  echo SET RESTART-STATUS=%RESTART-STATUS%
) > CoreData\data-system.bat



		rem 13
rem call data-settings.bat
call CoreData\data-settings.bat
rem Any conversions from data-settings.bat
IF %THEME%==light set THEMEcolor=f0
IF %THEME%==dark set THEMEcolor=0f

IF %THEME%==light set lightTHEMEcolor=f8
IF %THEME%==dark set lightTHEMEcolor=08

IF %THEME%==light set blueTHEMEcolor=f3
IF %THEME%==dark set blueTHEMEcolor=03



		rem 14
call CoreData\data-user.bat

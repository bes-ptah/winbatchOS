rem WinBatchX 20 Installer - (Rev1)
rem This software is licensed under the Microsoft Public License (Ms-PL).
rem ==
rem WARNING: 
rem This release cannot install winbatchx 20.
rem THIS IS A TEST BUILD
rem ==

rem Microsoft Public License (Ms-PL)
rem.
rem This license governs use of the accompanying software. If you use the
rem software, you accept this license. If you do not accept the license, do not
rem use the software.
rem.
rem 1.  Definitions
rem The terms "reproduce," "reproduction," "derivative works," and "distribution"
rem have the same meaning here as under U.S. copyright law. A "contribution" is
rem the original software, or any additions or changes to the software. A
rem "contributor" is any person that distributes its contribution under this
rem license. "Licensed patents" are a contributor's patent claims that read
rem directly on its contribution.
rem. 
rem 2.  Grant of Rights
rem      (A) Copyright Grant- Subject to the terms of this license, including the
rem      license conditions and limitations in section 3, each contributor grants
rem      you a non-exclusive, worldwide, royalty-free copyright license to
rem      reproduce its contribution, prepare derivative works of its contribution,
rem      and distribute its contribution or any derivative works that you create.
rem.
rem      (B) Patent Grant- Subject to the terms of this license, including the
rem      license conditions and limitations in section 3, each contributor grants
rem      you a non-exclusive, worldwide, royalty-free license under its licensed
rem      patents to make, have made, use, sell, offer for sale, import, and/or
rem      otherwise dispose of its contribution in the software or derivative works
rem      of the contribution in the software.
rem.
rem 3.  Conditions and Limitations
rem      (A) No Trademark License- This license does not grant you rights to use
rem      any contributors' name, logo, or trademarks.
rem.
rem      (B) If you bring a patent claim against any contributor over patents that
rem      you claim are infringed by the software, your patent license from such
rem      contributor to the software ends automatically.
rem.
rem      (C) If you distribute any portion of the software, you must retain all
rem      copyright, patent, trademark, and attribution notices that are present in
rem      the software.
rem.
rem      (D) If you distribute any portion of the software in source code form,
rem      you may do so only under this license by including a complete copy of
rem      this license with your distribution. If you distribute any portion of the
rem      software in compiled or object code form, you may only do so under a
rem      license that complies with this license.
rem.
rem      (E) The software is licensed "as-is." You bear the risk of using it. The
rem      contributors give no express warranties, guarantees, or conditions. You
rem      may have additional consumer rights under your local laws which this
rem      license cannot change. To the extent permitted under your local laws, the
rem      contributors exclude the implied warranties of merchantability, fitness
rem      for a particular purpose and non-infringement.



@Echo off
IF "%~1" == "" start WinBatchOS start &&endlocal &&exit /b
IF "%~1" == "start" goto :boot.exe


:BOOT.EXE
setlocal EnableExtensions EnableDelayedExpansion
mode 1000,1000
mode 211,60
chcp 437 > nul

cls
PIXELDRAW /refresh 3f

rem ==================================
rem Boot Load winbatchOS Desktop 2023:
rem More simpler now, as most are in
rem services, yay!
rem ==================================
rem 1. Set General Variables
rem 2. Start up 'OS Critical' Services
rem ==================================
cls

call Text 83 38 0f "Please Wait for winbatchOS to start" X _Button_Boxes _Button_Hover


rem load initial filesystem HERE into memory, use recovery filesystem


call Text 83 38 0f "                                   " X _Button_Boxes _Button_Hover






call Text 1 1 0f "[ DATA ] Installer for winbatchOS 23, Dual Kernel.                 " X _Button_Boxes _Button_Hover

rem 1
rem Set General Variables
SET "_WbOS=WinBatchOS"
SET "_version=23"OS_FILESYSTEM_ENDOFFILE.412
SET "_quantum-ver=1.0"
SET "_ni-ver=10.3"
set "_TERMINAL.EXE=0"

call Text 1 3 0f "[ PROG ] Waiting for the TimeDate Service to start                 " X _Button_Boxes _Button_Hover
CALL :WbOS/SERVICES/TIMEDATE.BAT
timeout /T 1 /NOBREAK > NUL
call Text 1 3 0f "[  OK  ] Started /WbOS/SERVICES/TIMEDATE.BAT.                 " X _Button_Boxes _Button_Hover



call Text 1 4 0f "[ PROG ] Waiting for the Update Service to start          " X _Button_Boxes _Button_Hover
rem meant to be an offline stand-alone installer, so no update service
call Text 1 4 0f "[  OK  ] Skipped /WbOS/SERVICES/UPDATE.BAT.          " X _Button_Boxes _Button_Hover


rem this is terminal.exe in case
call :WbOS/BIN/wbsh
timeout /T 1 /NOBREAK > NUL
call Text 1 5 0f "[  OK  ] Started /bin/terminal.         " X _Button_Boxes _Button_Hover

:LINE128

rem this is the installer
call :WbOS/BIN/init-cloud
timeout /T 1 /NOBREAK > NUL
call Text 1 6 0f "[  OK  ] Started /bin/init-cloud.         " X _Button_Boxes _Button_Hover

timeout /T 5 /NOBREAK > nul
call Text 1 7 0f "[  OK  ] Reached Target Shutdown.         " X _Button_Boxes _Button_Hover
timeout /T 5 /NOBREAK > NUL
echo exit()
exit /b



























rem Built-In File System for Disking
rem WinbatchOS File System v1


rem WinBatchOS File System (WbFS)
rem Directory Tree

rem diskA-
rem WbOS/
rem | SERVICES/ 
rem    | - WBXUPDATE.BAT
rem    | - TIMEDATE.BAT
rem | NIKERNEL/
rem    | - (old NI kernel dev)

rem | NIGUI/
rem    | - (old NI kernel dev)
rem | NI/
rem    | - (old NI kernel dev)






rem  +++
rem  |-------------------------------|-------------------|
rem  | OS Specifics:                 |                   |
rem  |-------------------------------|-------------------|
rem  | Virtual Disk Version          | 1.0               |
rem  | Multiprocessing               | Unavailable       |
rem  | Graphics                      | Unavailable       |
rem  | Linux Envirnoment             | Unavailable       |
rem  | OS Name                       | winbatchOS Core   |
rem  | OS Release                    | 11.0              |
rem  | Channel                       | Final RTM         |
rem  | Flags                         | Unreleased        |
rem  | NI Kernel Version             | 23.0              |
rem  | Quantum Kernel Graphics       | 1.0               |
rem  | Build Release                 | 10008.100         |
rem  | Installed Updates:            | 1                 |
rem  | Last Security Update Patch    | None              |
rem  |-------------------------------|-------------------|
rem  +++






:OS_FILESYSTEM_ENDOFFILE

























:WbOS/BIN/init-cloud
rem (program insert here)
goto :OS_FILESYSTEM_ENDOFFILE







:WbOS/BIN/Box.bat
@Echo off


REM Checking important files...
Set _Ver=Q0.5



If /i "%~1" == "" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "-help" (goto :help)

If /i "%~1" == "ver" (echo.NI_6.1alpha&&goto :eof)


If /i "%~2" == "" (goto :help)
If /i "%~3" == "" (goto :help)
If /i "%~4" == "" (goto :help)

:Box
setlocal Enabledelayedexpansion
set _string=
set "_SpaceWidth=/d ""
set _final=

set x_val=%~1
set y_val=%~2
set sepr=%~5
if /i "!sepr!" == "-" (set sepr=)
set char=%~6
if /i "!char!" == "-" (set char=)
if defined char (set char=!char:~0,1!) ELSE (set "char= ")
set color=%~7
if defined color (if /i "!color!" == "-" (set color=) Else (set "color=/c 0x%~7"))

Set Type=%~8
If not defined Type (Set Type=1)
If %Type% Gtr 4 (Set Type=1)

If /i "%Type%" == "0" (
	If /I "%~6" == "-" (
		set _Hor_line=/a 32
		set _Ver_line=/a 32
		set _Top_sepr=/a 32
		set _Base_sepr=/a 32
		set _Top_left=/a 32
		set _Top_right=/a 32
		set _Base_right=/a 32
		set _Base_left=/a 32
		) ELSE (
		set _Hor_line=/d "%char%"
		set _Ver_line=/d "%char%"
		set _Top_sepr=/d "%char%"
		set _Base_sepr=/d "%char%"
		set _Top_left=/d "%char%"
		set _Top_right=/d "%char%"
		set _Base_right=/d "%char%"
		set _Base_left=/d "%char%"
		)
)

If /i "%Type%" == "1" (
set _Hor_line=/a 196
set _Ver_line=/a 179
set _Top_sepr=/a 194
set _Base_sepr=/a 193
set _Top_left=/a 218
set _Top_right=/a 191
set _Base_right=/a 217
set _Base_left=/a 192
)

If /i "%Type%" == "2" (
set _Hor_line=/a 205
set _Ver_line=/a 186
set _Top_sepr=/a 203
set _Base_sepr=/a 202
set _Top_left=/a 201
set _Top_right=/a 187
set _Base_right=/a 188
set _Base_left=/a 200
)

If /i "%Type%" == "3" (
set _Hor_line=/a 205
set _Ver_line=/a 179
set _Top_sepr=/a 209
set _Base_sepr=/a 207
set _Top_left=/a 213
set _Top_right=/a 184
set _Base_right=/a 190
set _Base_left=/a 212
)

If /i "%Type%" == "4" (
set _Hor_line=/a 196
set _Ver_line=/a 186
set _Top_sepr=/a 210
set _Base_sepr=/a 208
set _Top_left=/a 214
set _Top_right=/a 183
set _Base_right=/a 189
set _Base_left=/a 211
)

set /a _char_width=%~4-2
set /a _box_height=%~3-2

for /l %%A in (1,1,!_char_width!) do (
	if /i "%%A" == "%~5" (
	set "_string=!_string! !_Top_sepr!"
	set "_SpaceWidth=!_SpaceWidth!" !_Ver_line! /d ""
	) ELSE (
	set "_string=!_string! !_Hor_line!"
	set "_SpaceWidth=!_SpaceWidth!!char!"
	)
)

set "_SpaceWidth=!_SpaceWidth!""
set "_final=/g !x_val! !y_val! !_Top_left! !_string! !_Top_right! !_final! "
set /a y_val+=1

for /l %%A in (1,1,!_box_height!) do (
set "_final=/g !x_val! !y_val! !_Ver_line! !_SpaceWidth! !_Ver_line! !_final! "
set /a y_val+=1
)


Set _To_Replace=!_Top_sepr:~-3!
Set _Replace_With=!_Base_sepr:~-3!

For %%A in ("!_To_Replace!") do For %%B in ("!_Replace_With!") do set "_final=/g !x_val! !y_val! !_Base_left! !_string:%%~A=%%~B! !_Base_right! !_final! "

IF /i "%~9" == "" (batbox %color% %_final% /c 0x07) ELSE (ENDLOCAL && Set "%~9=%color% %_final% /c 0x07")
goto :eof

:help
goto :eof


:WbOS/BIN/Text.bat
@echo off
Setlocal Enabledelayedexpansion
Set Button_height=1
FOR %%A In (batbox.exe Getlen.bat Box.bat) DO (IF Not Exist "%%A" (Echo. Button Function, Error... File [%%A] is Missing...))
Set _Hover=
Set _Box=
Set _Text=
set _ver=Q0.5

:Loop_of_button_fn
Set _X=%~1
Set _Y=%~2
set color=%~3
Set _Invert_Color=%Color:~1,1%%Color:~0,1%
set "Button_text=%~4"


if not defined _X (goto :EOF)
if /i "%_X%" == "X" (Goto :End)


Call Getlen "%button_text%"
set button_width=%errorlevel%


Set /A _X_Text=%_X% + 2
Set /A _Y_Text=%_Y% + 1
Set /A _X_End=%_X% + %button_width% - 1
Set /A _Y_End=%_Y% + %Button_height% - 1




Set "_Text=!_Text!/g !_X_Text! !_Y_Text! /c 0x!color! /d "!Button_text!" "
Set "_Hover=!_Hover!!_Invert_Color! "
Set "_Box=!_Box!!_X! !_Y! !_X_End! !_Y_End! "


For /L %%A In (1,1,4) Do (Shift /1)
Goto :Loop_of_button_fn

:End
Batbox %_Text% /c 0x07
Endlocal && set "%~2=%_Box%" && set "%~3=%_Hover%"
Goto :EOF










:WbOS/BIN/Getlen.bat
@echo off
Setlocal EnableDelayedExpansion


set _ver=Q0.5


set len=0


IF /i "%~1" == "" (Goto :End)
IF /i "%~1" == "/h" (Goto :Help)
IF /i "%~1" == "/?" (Goto :Help)
IF /i "%~1" == "-h" (Goto :Help)
IF /i "%~1" == "Help" (Goto :Help)
IF /i "%~1" == "/v" (Echo.%ver% && Goto :EOF)

:Main
set "s=%~1#"
for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!s:~%%P,1!" NEQ "" ( 
        set /a "len+=%%P"
        set "s=!s:~%%P!"
    )
)

:End

Endlocal && Exit /b %len%


:WbOS/BIN/GetInput.bat
MZ�       ��  �       @                                   �   � �	�!�L�!This program cannot be run in DOS mode.

$       V�����������������������Rich���                PE  L ��ZX        �                       @                      @                                       (   (                                                                                       (                           .text   t                          `.rdata  @          
              @  @.data       0                    @  �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        U���������\�����  �  �F���}  </uP�F<Tt<tu*��  �F�  f� 0@ ��  �F���K  </u�F<It<i��   �
0@ �  �F<"u@2�0@ ���F<"t
�t
<a|<z, f�GG��Ǎ�\���+���0@ �z  �F<"t�<0r<9w�  f�GG���׍�\���+���0@ </��   �F<Mt<m��   ��\����+  �F</t
�t��  f�GG��ύ�\���+����
0@ �~�/ui�F<Ht<hu^�
0@ ƅ��� ������
0@ ��  �&F
�t0��0��	v����v�� �F
�t,0<	v,<v, ��
Ī��g��G��j��  �E�j��  �E��E�P�u��  ��   P�u��  ǅ���    f�= 0@ �tj f�5 0@ �u��s  ��    ��  �E�Pj�E�P�u��B  f�}���   �}� t��E�f�tGf��	u
�E�   t��}f��zw�E�   u�0@ tef��a|_f�� �Yf� f= |Of�� �If�E�f��!�W���f��(~$f��-�G���f��.~f��p�7���f��{�-���f �E�   tf �
0@ f��  ��\����f�������0@ f+���  f�}�������E�
0@ �E�   ��   �0@ ������E�   �����f��������������   O����f;��\���r"f;��^���rf;��`���wf;��b�����   �����`���f+��\���fGf���b���f+��^���fF���\���f�����������E�PSW������u��  ��   fNu�ǅ���    �E�
0@ ��E�   u�̀��f���   �؋�����\���f;rf;_rf;Gwf;_v
���������0@ f+�f@�E�   ��   ;��������������H�����\����E�PSj�����P�u���   6��.���
�uf�����f����������`���f+��\���fGf���b���f+��^���f@f���E�PSW������u��   ��   fNu��
����؁M�   �u��u��~   S�T   f��f�
 �>F��0r��9wf���0f��f���N��Y   ���F<"u	�F<"u���F< t��u�NÊF< t�N���%  @ �% @ �% @ �% @ �% @ �% @ �% @ �% @ �%  @                                                                                                                                             x   �   �   �   �   �   �   
!   !      P           2!                          x   �   �   �   �   �   �   
!   !      � ExitProcess � FillConsoleOutputAttribute  � GetConsoleMode  jGetStdHandle  4ReadConsoleInputA 7ReadConsoleOutputAttribute  nSetConsoleMode  �WaitForSingleObject � GetCommandLineA kernel32.dll                                                                                                                                                                                                  ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              


:WbOS/BIN/insertbmp.exe
MZ�       ��  �       @                                   �   � �	�!�L�!This program cannot be run in DOS mode.

$       PE  L            �      :     �      0    @                     �     �I                                  `  �   �  �                                                  �                     |a                            .text   �                        ` P`.data   0    0      $              @ 0�.rdata      @      &              @ 0@.bss    �   P                      � `�.idata  �   `      .              @ 0�.CRT    4    p      6              @ 0�.tls         �      8              @ 0�.rsrc   �   �      :              @ 0�                                                                                                                                                                                                                                                                                                                                        �Í�&    ��'    ��1�f�=  @ MZ�(P@    �$P@    � P@    �0P@    th�P@ �4P@ ��tJ�$   �j  �$�����"  �8P@ ��S@ ��S@ �b@ ��F  �=0@ tm1���Í�&    �$   �   �f��< @ ��  @ PE  ��  @ u��Qf��t?f���j������   �]������   1������K����v �$@@ �$  1���Ãyt�,������   1���������f���,�<P@ �D$ P@ �D$P@ �D$P@ � P@ �@P@ �$P@ �D$�j  �P@ ��,Í�    ��'    U1���   WV�U�S�׃�|�0�  )čD$���� �����@�����@�����@�����@�����@�����@�����@���̃���54P@ ����  d�   1��X�=�a@ �9��  �$�  �׃������S@ ��uޡ�S@ 1ۃ���  ��S@ ���@  �P@    ��S@ ����  ���  ��C@ ��t�D$    �D$   �$    �Ѓ��  �$�@ ��a@ ���DP@ �$ @ �t  �o  �b@ ��S@   @ � ��tC1����    ��t0��t!�   ����� ~�˃���"D����t����� ~��S@ �4P@ ��t�UԸ
   �E�E£ 0@ �P@ �E��ƍ�   �E��$�  ���=P@ �E��O  1ۉ���&    ���$�  �x�<$�  �M��������|$�$�L$�~  ;]�uɋE����u��    �5P@ ��  ��a@ �P@ ��P@ �D$�P@ �D$�P@ �$��  �
P@ �ɣP@ ��   �P@ ��u
�  �P@ �e�[^_]Ív ��S@ �   �������$   ��  ��S@ �������D$p@ �$ p@ ��  ����S@    �������S@ �����f��$��a@ ���n�����S@    �D$p@ �$p@ �  ����1�������$f��{  �t& ��'    ���4P@    ��  ��������    ���4P@     ��  �������������,0@ ��tCU����$ @@ ��a@ �    ����t�D$@@ �$��a@ ����t	�$,0@ �����f�U��]Ð����������UWVS��,�\$H�$��  �ƍ@�D$��$�D$�v  ���D$�G  �D$�$�^  ���D$�#  �|$�D$$@@ �<$�~  �l$�D$(@@ �,$�j  �\$�<$�f  �\$�,$�Z  �|$@��   �D$���   ���D$�D$D�h�����;\$@t�E �$�  9���r�E t�L$f�<:uӋT$�t$�$�T$��  ��t�D$�t$�D$�E �$��  ��u�9|$sM�E 1ۿ����f�<p:u�\$�   ����&    1�1��D$�$�  �D$�$�  ��,����[^_]�1ۿ�����ӋD$�$�{  �$   �G  ��&    VS��$�5b@ �\$0�D$    �օ��     tM�D$�D$
   �D$�$�5  �L$f�9 �¸   t��$[^ÉT$�֋T$�8"����$��[^Ð�t& ��$1Ҹ   [^Ív U1���WVS��l�D�    ����r���a@ �����  �$��b@ �������  �$��a@ �����E��  �E�   �D$   �D$    �D$    �D$    �D$�$    ��b@ �����E��r  �MЉL$�D$   �$��a@ ������  �EԋM�}��ȉM��M��E���C@ ���f�M���C@ �����m��]��muą��|  �U؋M�ʉM��E������m��]��mMąɉM��c  �E��U��D$   �t$�D$�D$    �$��b@ ������   �U��D$�E��$��a@ �U�������   ����E���   �E��U��U��t$�D$   � �D$�E�T$�D$    �D$    �D$�E�$�D$�|a@ �M���$���$�
�a@ �����ƉM��ыM��U����M��$�ыM����E��$�у��E���b@ �<$�D$�U��ҋU����\$�<$�҉����e�[^_]Íe��   [��^_]þ   �
�a@ �f��   ��b@ 뿍v �   �
�a@ �x������؋u؉u��������U���������t& UWVS��,�\$@�t$D�D$,@@ �$�t$�-�����u)�D$xC@ �t$�$��������t$�   ��,[^_]Ð�$0@@ ��  ��,1�[^_]��D$|C@ �t$�$�����������   ���t��D$    �D$�C@ �t$�$����������   ���t��D$    �t$�D$�C@ �$�L$�z����L$�����|   ����T����d   �D
�D09��?����D$�T$�<$�D$�D$�D$�A����#����$�������T$�Z��������v �$�D$�����L$���T$�b���������$�w����L$���~�����������������D$$��t��t�   ��� ��t& �T$(�D$�D$ �T$�$��  �   ��� ��    ��'    S���=0@ �D$$t
�0@    ��t��t;���   [� �0p@ ��0p@ t�f����t�Ѓ���0p@ u���   [� ��D$(�D$   �D$�D$ �$�d  �f�1�Ð��������������a@ ������������D$Ít& ��'    �D$Ð����������S��(��S@ �$���������D$��   �$   �  ��S@ �$�����D$��S@ �$�����D$�D$�D$�D$�D$�D$0�$�x  �ËD$�$�z�����S@ �D$�$�i����$   ��S@ �P  ��(��[Ð�D$0�$�,b@ ��([Í�&    ��'    ���D$ �$�1�������������Ð��U��VS���]�� =�  �wB=�  ���   =  ���   �D$    �$   ��  ����   ��t �$   ���U=�  �t"=�  �th=�  �tS�DP@ ��t<�]�e�[^]��1��D$    �$   �y  ����   ��t��$   �и�����e�[^]� ��t& �   �=  �u��D$    �$   �.  ��t)��t��$   ����D$   �$   �  롍t& �D$   �$   ��  ��D$   �$   ��  ���k����Y  �a�������1�Ð��������������<�HP@ �D$H�D$P�D$X��t)�ʋT$@�\$�\$ �\$(�T$�T$D�T$�T$�$��������؃�<Ð�t& �D$�HP@ �Z  f���<�D$@��J���C@ ��w���D@ �@�\$ �@�\$�@�\$�@�T$�D$�C@ �D$�$b@ ��@�$�  1���<Ð����S���$b@ �D$   �\$$�D$   �$�D@ ��@�D$��
  �D$ �\$�D$�$b@ ��@�$��
  ��
  �
�������������U��WV��S��L�M��
PP@ �Uą���  �TP@ 1ۋB9�r�zG9���   ����9�u�4$�2
  ������  �[����TP@ �M��C�    ��
  �M��ỦU�G�C�TP@ �T$��a@ �D$   �D�$�ӋM��U������@  �E�����   �PP@ �D$   �T$�4$�Ӄ����A  �E���u2�E��4$�D$�EĉD$�  �e�[^_]Ít& �Ű�a@ 믐�t& ��@tɋE؍}ȋ�a@ �|$�D$@   �D$�Ẻ$�ӋE����D$�Eĉ4$�D$�  �E���@t���t��Eȉ|$�D$�E؉D$�Ẻ$�Ӄ��e�[^_]Ã�@�&����E�
TP@ �U��D$@   �D$�ẺL$�$��a@ �U������������a@ �$8E@ �D$������&    1��O����TP@ �D�D$�G�$E@ �D$�����t$�$�D@ �y����t$�D$   �$E@ �a�����LP@ ��tÍ�    U��WVS��L�LP@    �h  �@��   ����&
  �PP@     )čD$���TP@ � H@ -�G@ ����   ���e  ��G@ ����   ��G@ ����   �=�G@ ��G@ ���=  ��G@ �C���  ���� H@ sJ��{��  @ ��  @ �M��K���  �� ��  ���W  �L$�$�E@ �E�    �_����e�[^_]û�G@ �� H@ s�ẺEčt& �S�   ����  @ ��  @ S��ŰU��{����� H@ rӡPP@ 1ۅ�맍�    ��;PP@ }��TP@ �4[�<�    ����tދM��D$   �L$�@�$��a@ ������   �EȉD$�TP@ ���D$�E؉D$�Ẻ$��a@ ��덻�G@ �3���,����K�������������  @ ������  ��f��H��u�)׍Ḿ�  @ �MčU̹   ��u��������� H@ �{�������������� �����H��uā�  @ )׍M���MčU̹   �u��I���봋uā�  @ �M̉MĹ   )�0�Ủu��$���돋
TP@ ��A�D$�A�@�$E@ �D$�����D$�$`E@ �������������������Ð�������������0@ � ��t��f��С0@ �P�@�0@ ��u���Ít& S���p.@ ���t$��t��p.@ ���v u��$0%@ �������[�1���ÍC��p.@ ��u��ƍ�&    �XP@ ��t�Ð�t& �XP@    딐���U��WVS��,�$0@ �E�    �E�    =N�@�t�У(0@ �e�[^_]ÍE؉$��a@ �u؋}�1�����a@ ����a@ �E���a@ �EЍE��$��a@ 3u�3u�1�3uԃ�3uЁ�N�@�t���Љ5$0@ �(0@ �e�[^_]Ð���D�O�@����t& U���(�E�U�$Q@ �@S@ 	 ��DS@    �Q@ �LS@ �E�$    �Q@ �$0@ �E�(0@ �E���a@ ���$�E@ ��a@ ����a@ �D$	 ��$��a@ ���  ���������U��WVS���$�S@ ��a@ �=�S@ �5�a@ ����t0��&    ��$��a@ �����օ�u��t�G�$�Ћ��u��$�S@ ��a@ ���e�[^_]��
�������������U��V1�S����S@ ��u
�e���[^]Ít& �D$   �$   ��  ����tB�E�$�S@ ��E�C��a@ ��S@ ��S@ �C���$�S@ ��a@ �����e�[^]þ����됍�    ��'    U��S����S@ �]��u
1��]��Í�    �$�S@ ��a@ ��S@ ����t�9�u
�F�9�t �B��u��$�S@ ��a@ ��1��]��ËH�J�$��  �$�S@ ��a@ ���ًB��S@ ���ڍ�    ��    U����E��tFr��u	��S@ ��ud�   �á�S@ ��ub��S@ ��u���S@     �$�S@ ��a@ ���ʡ�S@ ��t��S@    �   ��f��$�S@ ��a@ ���������땍�&    ����뗐��������@<�8PE  t1��f�f�x����Ív �D$f�8MZt1��f��΍�&    ��'    VS�T$�\$R<�r�B���Dt1Ґ�H9�wH9�r����(9�r�1�[^Ív UWV1�S���|$0�<$�  ��wf�=  @ MZt����[^_]Ð�  @ �F�����t�< @ ��  @ �� @ �j�\��u��f�����(9�s&�D$   �|$�$�j  ��uރ��މ�[^_]�f���1�[��^_]Ít& S1ۃ�f�=  @ MZt����[ø  @ ������t�D$�$  @ -  @ �D$��������É�[Ð��&    S1�f�=  @ MZt��[ø  @ �t�����t�< @ �� @ ��[�V1�f�=  @ MZS�\$t��[^ø  @ �>�����t��< @ ��  @ �� @ �T�I��t�1��B' t��t������(9�r�1���[^É։�[^Ð�t& S1�f�=  @ MZt��[ø  @ ��������  @ E؉�[Í�    1�f�=  @ MZt�f����  @ ������t%�D$�$  @ -  @ �D$�������t�@$������Í�    1���    ��    W1�VS��f�=  @ MZ�\$t	����[^_ø  @ �6�����t�< @ ��� @ ��tډt$�$  @ �S�����tƁ�  @ ��u뺍v �����J��u�B��t���z��[^��  @ ��_Í�    ��1���[^_Ð����QP=   �L$r��   �	 -   =   w�)��	 XYÐ��% b@ ���%�a@ ��f�f���S@ Ív ��'    �D$��S@ Ð�����%Hb@ ���%Tb@ ���%Lb@ ���%b@ ���%b@ ���% b@ ���%8b@ ���%lb@ ���%hb@ ���%db@ ���%xb@ ���%@b@ ���%pb@ ���%tb@ ���%b@ ���%(b@ ���%�a@ ���%0b@ ���%Pb@ ���%b@ ���%<b@ ���%Db@ ���%`b@ ���%\b@ ���%4b@ ���%Xb@ ��U������0������D$,�D$�D$(�D$�D$$�D$�D$ �D$    �$�D$     �D$$    �D$(    �D$,    �F����   ��u�D$$�D$�D$ �$��������Ð��U��������$P@ ������Ð����������P.@     ����                                                                                                                                                                                                                                                                                                                                                                                                
   �   ���������.@    �����,@ �,@ N�@���D                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    libgcj-13.dll _Jv_RegisterClasses   -   /   ?   I n s e r t B m p   i n s e r t s   a   b i t m a p   p i c t u r e   i n t o   t h e   c o n s o l e   w i n d o w . 
 
 S y n t a x : 
 I n s e r t B m p   / p : P a t h   [ / x : R i g h t ]   [ / y : D o w n ]   [ / z : Z o o m ]   [ / ? ] 
 
     P a t h         F i l e   p a t h   o f   t h e   b i t m a p   ( o n l y   * . b m p   s u p p o r t e d ) . 
     R i g h t       D i s t a n c e   t o   t h e   l e f t   w i n d o w   b o r d e r   i n   p i x e l s .   ( d e f a u l t   0 ) 
     D o w n         D i s t a n c e   t o   t h e   t o p   w i n d o w   b o r d e r   i n   p i x e l s .   ( d e f a u l t   0 ) 
     Z o o m         Z o o m   p e r c e n t a g e   o f   t h e   i n s e r t e d   b i t m a p .   ( d e f a u l t   1 0 0 ) 
     / ?             D i s p l a y s   t h e   h e l p   m e s s a g e . 
 
   p   x   y   z     �B   ?�@ Unknown error   _matherr(): %s in %s(%g, %g)  (retval=%g)
  Argument domain error (DOMAIN) Argument singularity (SIGN)  Overflow range error (OVERFLOW) The result is too small to be represented (UNDERFLOW)   Total loss of significance (TLOSS)  Partial loss of significance (PLOSS)    �C@ �C@ D@ ,D@ dD@ �D@ Mingw-w64 runtime failure:
 Address %p has no image-section   VirtualQuery failed for %d bytes at address %p      VirtualProtect failed with code 0x%x    Unknown pseudo relocation protocol version %d.
     Unknown pseudo relocation bit size %d.
   @S@ `P@ h"  GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3    GCC: (GNU) 4.8.3                0  �      d`          xf  |a  |`          �f  �a  �`          xg  �a  ha          �g  �b                      �b  �b  �b  �b  �b      �b  �b  c  &c  :c  Pc  fc  vc  �c  �c  �c  �c  �c  �c  d  &d  Dd  Ld  `d  nd  �d  �d      �d  �d  �d  �d  �d  �d  e  e  (e  6e  @e  Je  Te  `e  he  pe  ze  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  f  f  f   f  *f      6f  Bf  Jf  Xf      �b  �b  �b  �b  �b      �b  �b  c  &c  :c  Pc  fc  vc  �c  �c  �c  �c  �c  �c  d  &d  Dd  Ld  `d  nd  �d  �d      �d  �d  �d  �d  �d  �d  e  e  (e  6e  @e  Je  Te  `e  he  pe  ze  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  �e  f  f  f   f  *f      6f  Bf  Jf  Xf       BitBlt  " CreateCompatibleDC  K DeleteObject  � GetObjectW  1SelectObject  � DeleteCriticalSection � EnterCriticalSection  �GetConsoleWindow  �GetCurrentProcess �GetCurrentProcessId �GetCurrentThreadId  GetLastError  GetModuleHandleA  EGetProcAddress  dGetStartupInfoA {GetSystemTimeAsFileTime �GetTickCount  �InitializeCriticalSection &LeaveCriticalSection  �QueryPerformanceCounter gSetUnhandledExceptionFilter tSleep �TerminateProcess  �TlsGetValue �UnhandledExceptionFilter  �VirtualProtect  �VirtualQuery  7 __dllonexit : __getmainargs ; __initenv D __lconv_init  h __set_app_type  k __setusermatherr  u __wgetmainargs  y _acmdln � _amsg_exit  � _cexit  � _errno  � _fmode  0_initterm 4_iob  �_lock 2_onexit �_unlock Ncalloc  Xexit  hfprintf ofree  zfwrite  �malloc  �memcpy  �signal  �strlen  �strncmp @abort ^vfprintf  lwcscat  qwcscpy  uwcslen  �wcstol  �wprintf �_wcsnicmp F CopyImage � GetDC �LoadImageW  �ReleaseDC  `   `   `   `   `  GDI32.dll   `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  `  KERNEL32.dll    (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  (`  msvcrt.dll  <`  <`  <`  <`  USER32.dll                                                                                                      0@         @ p@         �@ �@                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              �@ �@ ,P@  p@                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 �                  0  �               	  H   X�  �          �4   V S _ V E R S I O N _ I N F O     ���                 ?                        �   S t r i n g F i l e I n f o   �   0 4 0 9 0 4 E 4   2   B u i l d     S e p t e m b e r   2 0 1 4     ^ #  C o m m e n t s   I n s e r t   P i c t u r e   I n t o   C o n s o l e   W i n d o w     >   D e v e l o p e r     S t e f f e n   I l l h a r d t     n #  F i l e D e s c r i p t i o n     I n s e r t   P i c t u r e   I n t o   C o n s o l e   W i n d o w     0   F i l e V e r s i o n     1 . 0 . 0 . 0   4 
  I n t e r n a l N a m e   I N S E R T B M P   X   L e g a l C o p y r i g h t   ( C )   2 0 1 4   S t e f f e n   I l l h a r d t   D   O r i g i n a l F i l e n a m e   i n s e r t b m p . e x e   4 
  P r o d u c t N a m e     I N S E R T B M P   4   P r o d u c t V e r s i o n   1 . 0 . 0 . 0   D    V a r F i l e I n f o     $    T r a n s l a t i o n     	�                                











:WbOS/SERVICES/TIMEDATE.BAT
rem  3.
rem set variables

SET _WBX-TIMETEMP1=0
SET _WBX-TIMETEMP2=0
SET _WBX-TIMETEMP3=0

SET _WBX-DATETEMP1=%DATE:~-10,2%
SET _WBX-DATETEMP2=%DATE:~7,-5%
SET _WBX-DATETEMP3=%DATE:~-4%



rem This is here for the GUI on calendar and notification center
rem Most author's comments are untouched.

rem  Xp batch for generating calendars
rem  Chances look good for win 2000 and above(untested)
rem  By Judago, August 2009



rem  The current codepage is stored in variable %CodePage%,
rem  then changed to 850 to facilitate box drawing characters.....

SETLOCAL ENABLEDELAYEDEXPANSION

:loop-cal
FOR %%Z IN (jan feb mar apr may jun jul aug sep oct nov dec year day leap noleap length test) DO SET %%Z=

set "year=%DATE:~-4%"

IF NOT DEFINED year (

	CHCP %CodePage% >NUL 2>&1
	EXIT /B
)


SET test=!year!
FOR /l %%Z IN (0 1 9) DO IF DEFINED test SET "test=!test:%%Z=!"
IF DEFINED test CLS&GOTO loop-cal
:zero
IF NOT DEFINED year (
	:error-cal
	cls
	echo The year entered can not be accepted.
	echo.
	pause
	CLS
	GOTO loop-cal
)

IF "%year:~0,1%"=="0" SET year=%year:~1%&&GOTO zero


IF /I "!processor_architecture!"=="x86" (
	IF !year! gtr 1717986917 GOTO :error-cal
) else (
	IF NOT "!processor_architecture:64=!"=="!processor_architecture!" (
		IF !year! gtr 7378697629483820645 GOTO :error-cal
	)
)


SET /A day=(year + year / 4) - (year / 100 - year / 400)
SET /A leap=year %% 400
SET /A noleap=year %% 100
IF !leap! GTR 0 (
	IF !noleap! NEQ 0 SET /A leap=year %% 4
)
IF %leap%==0 SET /A day-=1
SET /A day%%=7


FOR %%U IN (jan feb mar apr may jun jul aug sep oct nov dec) DO (
	FOR %%V IN (jan mar may jul aug oct dec) DO IF /I %%U==%%V SET length=31
	FOR %%W IN (apr jun sep nov) DO IF /I %%U==%%W SET length=30
	IF /I %%U==feb (
		IF !leap!==0 (
			SET length=29
		) else (
			SET length=28
		)
	)
	FOR /l %%X IN (1 1 !day!) DO SET "%%U=!%%U!   "
	FOR /l %%Y IN (1 1 !length!) DO (
		IF %%Y lss 10 (
			SET "%%U=!%%U!%%Y  "
		) else (
			SET "%%U=!%%U!%%Y "
		)
	)
	FOR /l %%Z IN (!length! 1 54) DO IF "!%%U:~110!"=="" SET "%%U=!%%U! "
	SET /A day=^(day + length^) %% 7
)



rem  4.
rem set variables
SET _WBX-TIMETEMP1=0
SET _WBX-TIMETEMP2=0
SET _WBX-TIMETEMP3=0

rem do calculations
set _WBX-TIMETEMP1=%Time:~0,-9%
set _WBX-TIMETEMP2=%Time:~3,-6%

rem find the time, am or pm, via the _WBX-TIMETEMP1 (hours)
IF %_WBX-TIMETEMP1%==12 set _WBX-TIMETEMP1= 1&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==13 set _WBX-TIMETEMP1= 1&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==14 set _WBX-TIMETEMP1= 2&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==15 set _WBX-TIMETEMP1= 3&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==16 set _WBX-TIMETEMP1= 4&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==17 set _WBX-TIMETEMP1= 5&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==18 set _WBX-TIMETEMP1= 6&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==19 set _WBX-TIMETEMP1= 7&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==20 set _WBX-TIMETEMP1= 8&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==21 set _WBX-TIMETEMP1= 9&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==22 set _WBX-TIMETEMP1=10&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==23 set _WBX-TIMETEMP1=11&set _WBX-TIMETEMP3=PM &GOTO :CONTINUEBOOT
IF %_WBX-TIMETEMP1%==24 set _WBX-TIMETEMP1=12&set _WBX-TIMETEMP3=AM &GOTO :CONTINUEBOOT
set _WBX-TIMETEMP3=AM

:CONTINUEBOOT
rem set the variables
set "_WBX-TASKBAR-TIME=%_WBX-TIMETEMP1%:%_WBX-TIMETEMP2% %_WBX-TIMETEMP3%"
set "_WBX-TASKBAR-DATE=%_WBX-DATETEMP1%-%_WBX-DATETEMP2%-%DATE:~-7,2%"

rem reset temporary variables
SET _WBX-DATETEMP1=0
SET _WBX-DATETEMP2=0
SET _WBX-TIMETEMP1=0
SET _WBX-TIMETEMP2=0
SET _WBX-TIMETEMP3=0
goto :OS_FILESYSTEM_ENDOFFILE










rem Terminal App
rem Really cut-down terminal from traditional ones
:WbOS/BIN/wbsh
IF %_TERMINAL.EXE%==0 goto :LINE128

rem DO NOT REQUEST AN API STARTUP!!
rem Only this variable SHOULD be set;
set _TERMINAL.EXE=1

:TERMINAL.LOOP
cls
CALL Text 0 2 0f "Opening winbatchOS Terminal" X _Button_Boxes _Button_Hover
echo.
echo winbatchOS %_version%, Manual Build 1900.251
echo Kernel Version %_quantum-ver%
echo.

:TERMINAL.SYSTEMLOOP
set WBXprompt=0
set /p WBXprompt=%_WBX_USERNAME%@%_HOSTNAME-winbatchOS%: 
IF %WBXprompt%==0 goto :TERMINAL.SYSTEMLOOP
IF %WBXprompt%==cls goto :TERMINAL.CLS
IF %WBXprompt%==help goto :TERMINAL.HELP
IF %WBXprompt%==exit goto :TERMINAL.EXIT
IF %WBXprompt%==ver goto :TERMINAL.VER
IF %WBXprompt%==wbxinstall goto :TERMINAL.WBXINSTALL

echo.
echo The command '%WBXprompt%' does not exist.
echo.
goto :TERMINAL.SYSTEMLOOP


rem list of commands here
	:TERMINAL.CLS
	cls
	goto :TERMINAL.SYSTEMLOOP
	
	:TERMINAL.EXIT
	echo.
	echo.
	echo Return-to-installer()
	pause
	goto :WbOS/BIN/init-cloud


	:TERMINAL.HELP 
	echo.
	echo Help commands-
	echo Please note the capilization of the commands.
	echo.
	echo cls
	echo exit
	echo help
	echo ver
	echo wbxinstall
	echo.
	goto :TERMINAL.SYSTEMLOOP


	:TERMINAL.VER 
	echo.
	echo winbatchOS %_version%, Build %_build%
	echo Kernel Version %_quantum-ver%
	echo.
	goto :TERMINAL.SYSTEMLOOP

	:TERMINAL.WBXINSTALL 
	echo.
	echo This feature is not enabled or is imcomplete.
	echo.
	goto :TERMINAL.SYSTEMLOOP







:ERROR.EXE
cls
:ERROR.LOOP
rem Set a clock up to 10
IF %_ERROR.EXE%==100 set _ERROR.EXE=1 &goto :BOOT.EXE

color 3f
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo    ==[WBXERROR]=============================================================================
echo    =                                                                                       =
echo    =  winbatchOS ran into a problem and needs to restart. We're going to try to recover    =
echo    =  the state it is in right now as much as possible, then we'll restart for you.        =
echo    =                                                                                       =
echo    =  [Restarting in a few moments]                                                        =
echo    =  [Error Code: Unknown]                                                                =
echo    =  [winbatchOS SDK 16 Window]                                                           =
echo    =                                                                                       =
echo    =========================================================================================
set /A _ERROR.EXE=%_ERROR.EXE%+1
goto :ERROR.LOOP





rem END OF winbatchOS CODE
rem winbatchOS.

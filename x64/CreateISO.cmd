CLS
@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
COLOR 17
SET PWD=%~dp0
SET PWD=%PWD:~0,-1%
SET PWD_TOL=%PWD%\Tools
SET PWD_SRC=%PWD%\Sources
SET PWD_DRV=%PWD_SRC%\Drivers
SET PWD_SFT=%PWD_SRC%\Software
SET PWD_UPD=%PWD_SRC%\Updates
SET PWD_WIN=%PWD_SRC%\Windows
SET PWD_TMP=%PWD%\Temp
SET PWD_MNT=%PWD%\Temp\Mount

"%PWD_TOL%\OSCDIMG.EXE" -lGSP1RMCPRXFRER_DE_DVD -t"%DATE:~3,2%/%DATE:~0,2%/%DATE:~6,4%,%time:~0,8%" -m -u2 -b%PWD_WIN%\boot\etfsboot.com %PWD_WIN% %PWD%\GSP1RMCPRXFRER_DE_DVD.iso

PAUSE
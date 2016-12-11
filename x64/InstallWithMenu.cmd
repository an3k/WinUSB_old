MODE 100,50
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

ECHO  Please choose from the menu below:
ECHO.
ECHO  1. Install Windows onto an USB drive
ECHO  2. Use an USB drive as the Windows installation source
ECHO.
ECHO  ======================================================
ECHO.
SET TARGET=
SET /P TARGET= Enter: 

CLS
ECHO  Please choose the target architecture you want to create:
ECHO.
ECHO  1. 32-Bit only
ECHO  2. 64-Bit only
ECHO  3. 32-Bit and 64-Bit
ECHO.
ECHO  ======================================================
ECHO.
SET TARGET_ARCH=
SET /P TARGET_ARCH= Enter: 

CLS
ECHO  Please choose the Windows Edition you want to create:
ECHO.
ECHO  1. Home Basic
ECHO  2. Home Premium
ECHO  3. Professional
ECHO  4. Ultimate
ECHO  5. All-In-One
ECHO.
ECHO  ======================================================
ECHO.
SET TARGET_EDIT=
SET /P TARGET_EDIT= Enter: 

ECHO %TARGET%
ECHO %TARGET_ARCH%
ECHO %TARGET_EDIT%

PAUSE
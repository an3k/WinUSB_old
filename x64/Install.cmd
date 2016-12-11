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
SET PWD_TMP=%PWD%\Temp
SET PWD_WIN=%PWD%\Temp\Windows
SET PWD_MNT=%PWD%\Temp\Mount
SET PWD_OUT=%PWD%\Out

ECHO ***** Verzeichnisse *****

MKDIR "%PWD_TMP%"
MKDIR "%PWD_MNT%"
MKDIR "%PWD_OUT%"

ECHO ***** Dateiberechtigungen *****

XCOPY /S /E /H /I /Q /Y "%PWD_SRC%\Windows" "%PWD_WIN%"
ATTRIB -R "%PWD_DRV%" /S /D
ATTRIB -R "%PWD_SFT%" /S /D
ATTRIB -R "%PWD_UPD%" /S /D
"%PWD_TOL%\STREAMS.EXE" -s -d -nobanner "%PWD_DRV%"
"%PWD_TOL%\STREAMS.EXE" -s -d -nobanner "%PWD_SFT%"
"%PWD_TOL%\STREAMS.EXE" -s -d -nobanner "%PWD_UPD%"
REM "%PWD_TOL%\DISM.EXE" /Cleanup-WIM

ECHO ***** Updates *****

"%PWD_TOL%\DISM.EXE" /Mount-WIM /WimFile:"%PWD_WIN%\sources\install.wim" /index:3 /MountDir:"%PWD_MNT%"
"%PWD_TOL%\DISM.EXE" /Image:"%PWD_MNT%" /Add-Package /PackagePath:"%PWD_UPD%\windows6.1-kb3020369-x64.msu"
"%PWD_TOL%\DISM.EXE" /Image:"%PWD_MNT%" /Add-Package /PackagePath:"%PWD_UPD%\windows6.1-kb3125574-v4-x64.msu"
"%PWD_TOL%\DISM.EXE" /Image:"%PWD_MNT%" /Add-Package /PackagePath:"%PWD_UPD%\windows6.1-kb3172605-x64.msu"
"%PWD_TOL%\DISM.EXE" /Image:"%PWD_MNT%" /Add-Package /PackagePath:"%PWD_UPD%\windows6.1-kb3185911-x64.msu"
"%PWD_TOL%\DISM.EXE" /Image:"%PWD_MNT%" /Add-Package /PackagePath:"%PWD_UPD%\windows6.1-kb3197867-x64.msu"
"%PWD_TOL%\DISM.EXE" /Unmount-WIM /MountDir:"%PWD_MNT%" /Commit

ECHO ***** Treiber *****

REM ##### autorun.inf suchen und entfernen
"%PWD_TOL%\DISM.EXE" /Mount-WIM /WimFile:"%PWD_WIN%\sources\install.wim" /index:3 /MountDir:"%PWD_MNT%"
"%PWD_TOL%\DISM.EXE" /Image:"%PWD_MNT%" /Add-Driver:"%PWD_DRV%" /ForceUnsigned /Recurse
RMDIR /S /Q "%PWD_MNT%\PerfLogs"
"%PWD_TOL%\DISM.EXE" /Unmount-WIM /MountDir:"%PWD_MNT%" /Commit

ECHO ***** ISO erstellen *****

REM "%PWD_TOL%\OSCDIMG.EXE" -lGSP2RMCPRXFRER_DE_DVD -t"%DATE:~3,2%/%DATE:~0,2%/%DATE:~6,4%,%time:~0,8%" -m -u2 -b%PWD_WIN%\boot\etfsboot.com %PWD_WIN% %PWD_OUT%\GSP2RMCPRXFRER_DE_DVD.iso
"%PWD_TOL%\OSCDIMG.EXE" -lGSP2RMCPRXFRER_DE_DVD -t"%DATE:~3,2%/%DATE:~0,2%/%DATE:~6,4%,%time:~0,8%" -m -o -u2 -bootdata:2#p0,e,b%PWD_WIN%\boot\etfsboot.com#pEF,e,b%PWD_WIN%\efi\microsoft\boot\efisys.bin %PWD_WIN% %PWD_OUT%\GSP2RMCPRXFRER_DE_DVD.iso

ECHO ***** Cleanup *****

"%PWD_TOL%\DISM.EXE" /Cleanup-WIM
RMDIR /S /Q "%PWD_TMP%"

ECHO ***** Fertig *****

PAUSE
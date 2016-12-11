@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET PWD=%~dp0
SET PWD=%PWD:~0,-1%
CD /D %PWD%

ECHO.
ECHO Processing Prerequisites
MD "%PWD%\Temp\mount"
COPY /y "%PWD%\Sources\windows\x64\sources\install.wim" "%PWD%\Temp"
ATTRIB -R "%PWD%\Sources\drivers" /S /D
ATTRIB -R "%PWD%\Sources\updates" /S /D
"%PWD%\Tools\STREAMS.EXE" -s -d -nobanner "%PWD%\Sources\drivers"
"%PWD%\Tools\STREAMS.EXE" -s -d -nobanner "%PWD%\Sources\updates"
"%PWD%\Tools\DISM.EXE" /Cleanup-WIM /Quiet

PAUSE

ECHO.
ECHO  Implementing Updates to Windows Image
"%PWD%\Tools\DISM.EXE" /Mount-WIM /WimFile:"%PWD%\Temp\install.wim" /index:3 /MountDir:"%PWD%\Temp\mount" /Quiet
"%PWD%\Tools\DISM.EXE" /Image:"%PWD%\Temp\mount" /Add-Package /PackagePath:"%PWD%\Sources\updates\x64\windows6.1-kb3020369-x64.msu" /Quiet
"%PWD%\Tools\DISM.EXE" /Image:"%PWD%\Temp\mount" /Add-Package /PackagePath:"%PWD%\Sources\updates\x64\windows6.1-kb3125574-v4-x64.msu" /Quiet
"%PWD%\Tools\DISM.EXE" /Unmount-WIM /MountDir:"%PWD%\Temp\mount" /Commit /Quiet

PAUSE

ECHO.
ECHO  Adding Drivers to Windows Image
"%PWD%\Tools\DISM.EXE" /Mount-WIM /WimFile:"%PWD%\Temp\install.wim" /index:3 /MountDir:"%PWD%\Temp\mount" /Quiet
"%PWD%\Tools\DISM.EXE" /Image:"%PWD%\Temp\mount" /Add-Driver:"%PWD%\Sources\drivers\x64" /ForceUnsigned /Recurse /Quiet
"%PWD%\Tools\DISM.EXE" /Unmount-WIM /MountDir:"%PWD%\Temp\mount" /Commit /Quiet

PAUSE

ECHO.
ECHO  Extracting Windows Image
"%PWD%\Tools\IMAGEX.EXE" /APPLY "%PWD%\Temp\install.wim" 3 X:\
ECHO  BootManager
"%PWD%\Tools\BCDBOOT.EXE" X:\Windows /S X:\
"%PWD%\Tools\BOOTSECT.EXE" /nt60 X:

ECHO  Modifying Registry
REG LOAD HKLM\sys X:\Windows\System32\config\SYSTEM
REG IMPORT "%PWD%\Tools\UsbBootSupport.reg"
REG UNLOAD HKLM\sys

MD X:\UsbBootSupport
MD X:\WINDOWS\Setup\Scripts
COPY /y "%PWD%\Tools\DisableHibernate.cmd" X:\WINDOWS\Setup\Scripts\DisableHibernate.cmd

RD "%PWD%\Temp"

ECHO  Completely Finished

PAUSE
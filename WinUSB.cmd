@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET PWD=%~dp0
SET PWD=%PWD:~0,-1%

IF "%PROCESSOR_ARCHITECTURE%" == "AMD64" GOTO 64x64
REM ##### untere Zeile muss wohl vor oberer Zeile kommen, da sonst auch auf 32-Bit OS auf 64-Bit Hardware 64x64 ausgeführt wird
IF DEFINED PROCESSOR_ARCHITEW6432 GOTO 32x64
IF "%PROCESSOR_ARCHITECTURE%" == "x86" GOTO 32x32

:64x64
  %SYSTEMROOT%\System32\cmd.exe /C %PWD%\x64\Install.cmd
  %SYSTEMROOT%\SysWOW64\cmd.exe /C %PWD%\x86\Install.cmd
  GOTO END

:32x64
  %SYSTEMROOT%\SysNative\cmd.exe /C %PWD%\x64\Install.cmd
  %SYSTEMROOT%\System32\cmd.exe /C %PWD%\x86\Install.cmd
  GOTO END

:32x32
  %SYSTEMROOT%\System32\cmd.exe /C %PWD%\x86\Install.cmd
  GOTO END

:END
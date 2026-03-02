@echo off
setlocal

:: Restart minimized if not already
if "%1" neq "min" start /min "" "%~f0" min & exit /b

echo Cleaning System...

:: Batch Clean (Windows Temp, User Temp, Prefetch, Recent)
for %%p in ("%WINDIR%\Temp" "%temp%" "%WINDIR%\Prefetch" "%userprofile%\Recent") do (
    del /f /s /q "%%~p\*" >nul 2>&1
    for /d %%i in ("%%~p\*") do rd /s /q "%%i" >nul 2>&1
)

:: Update Cache (Requires Admin for 'net stop')
net stop wuauserv >nul 2>&1
del /f /s /q "%WINDIR%\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1

echo Maintenance Complete.
timeout /t 3 >nul
exit

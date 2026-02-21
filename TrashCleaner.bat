@echo off
setlocal enabledelayedexpansion

:: Run as Minimized
if not "%1" == "min" start /MIN "" cmd /c "%~f0" min & exit /b

title System Maintenance Tool
echo ============================================
echo        System Optimization in Progress
echo ============================================

:: 1. Windows Temp Cleanup
echo [+] Cleaning Windows Temporary files...
if exist "%WINDIR%\Temp" (
    del /f /s /q "%WINDIR%\Temp\*" >nul 2>&1
    for /d %%i in ("%WINDIR%\Temp\*") do rd /s /q "%%i" >nul 2>&1
)

:: 2. User Temp Cleanup
echo [+] Cleaning User Profile Temp...
del /f /s /q "%temp%\*" >nul 2>&1
for /d %%i in ("%temp%\*") do rd /s /q "%%i" >nul 2>&1

:: 3. Prefetch Cleanup
echo [+] Cleaning Prefetch data...
if exist "%WINDIR%\Prefetch" (
    del /f /q "%WINDIR%\Prefetch\*" >nul 2>&1
)

:: 4. Windows Update Cache Cleanup
echo [+] Purging Windows Update Cache...
net stop wuauserv >nul 2>&1
if exist "%WINDIR%\SoftwareDistribution\Download" (
    del /f /s /q "%WINDIR%\SoftwareDistribution\Download\*" >nul 2>&1
    for /d %%i in ("%WINDIR%\SoftwareDistribution\Download\*") do rd /s /q "%%i" >nul 2>&1
)
net start wuauserv >nul 2>&1

:: 5. Recent Items & Cookies
echo [+] Removing Recent activity logs...
del /f /s /q "%userprofile%\Recent\*" >nul 2>&1
del /f /s /q "%userprofile%\Cookies\*" >nul 2>&1

echo.
echo ============================================
echo        Maintenance Task Completed!
echo ============================================
pause
exit
@echo off
:: Check for admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:: Install Chocolatey if not present
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Chocolatey...
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    echo.
    echo Chocolatey installed. Please close this window, open a NEW terminal as Administrator, and run this script again.
    pause
    exit /b 0
)

:: Install gcc (MinGW), make, and git
echo Installing mingw, make, git...
choco install mingw make git -y

echo.
echo Please close this window and open a NEW terminal as Administrator, then press any key to continue...
pause

:: Clone PDCurses
if exist PDCurses (
    echo PDCurses folder already exists, skipping clone.
) else (
    echo Cloning PDCurses...
    git clone https://github.com/Bill-Gray/PDCursesMod.git PDCurses
)

:: Build PDCurses
echo Building PDCurses...
cd PDCurses\wincon
mingw32-make
ar rcs libcurses.a *.o
cd ..\..

echo.
echo Done! Run 'make' to build your project.
pause

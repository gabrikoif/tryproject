@echo off
echo Installing dependencies...

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
)

:: Install gcc (MinGW) and make
choco install mingw -y
choco install make -y

:: Refresh environment so gcc and make are available
call refreshenv

:: Clone and build PDCurses into project folder
echo Cloning PDCursesMod...
where git >nul 2>&1
if %errorlevel% neq 0 (
    choco install git -y
    call refreshenv
)

if exist PDCurses (
    echo PDCurses folder already exists, skipping clone.
) else (
    git clone https://github.com/Bill-Gray/PDCursesMod.git PDCurses
)

echo Building PDCurses (wincon)...
cd PDCurses\wincon
mingw32-make -f Makefile
cd ..\..

echo.
echo Done! Run 'make' to build your project.
pause
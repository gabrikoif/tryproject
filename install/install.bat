@echo off
setlocal
set PROJECT_ROOT=%~dp0..\

echo ============================================
echo  Project Dependency Installer
echo ============================================
echo.

:: Check for admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Please run this script as Administrator.
    pause
    exit /b 1
)

:: Install Chocolatey if not present
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo [1/3] Installing Chocolatey...
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    echo.
    echo Chocolatey installed. Please close this window, open a NEW terminal as
    echo Administrator, and run this script again.
    echo.
    pause
    exit /b 0
)

:: Install dependencies
echo [1/3] Installing mingw, make, git...
choco install mingw make git -y
echo.

:: Clone PDCurses
echo [2/3] Setting up PDCurses...
if exist "%PROJECT_ROOT%PDCurses" (
    echo PDCurses already exists, skipping clone.
) else (
    git clone https://github.com/Bill-Gray/PDCursesMod.git "%PROJECT_ROOT%PDCurses"
)
echo.

:: Build PDCurses
echo [3/3] Building PDCurses...
cd "%PROJECT_ROOT%PDCurses\wincon"
mingw32-make
ar rcs libcurses.a *.o
cd "%PROJECT_ROOT%"
echo.

echo ============================================
echo  Done! Run 'make' to build your project.
echo ============================================
pause

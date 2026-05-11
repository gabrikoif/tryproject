# Color Sort — A terminal game written in C

A stack-based color sorting puzzle game that runs in the terminal, built with C and ncurses.

## Gameplay

You have a set of stacks filled with colored blocks. The goal is to sort them so each stack contains only one color. 

- **Left / Right** — move the cursor between stacks
- **Enter** — pick up the top block, then place it on another stack
- **C** — cancel and return the held block to its original stack
- **Q** — quit the game

## Project Structure

```txt
project
├── inc
│   ├── display.h
│   ├── game.h
│   ├── menu.h
│   ├── platform_utils.h
│   ├── stack.h
│   └── terminal.h
├── install
│   ├── install.bat
│   └── install.sh
├── Makefile
├── README.md
└── src
    ├── display.c
    ├── game.c
    ├── main.c
    ├── menu.c
    ├── stack.c
    └── terminal.c
```

## Installation

### Linux / macOS

Make sure `ncurses` is installed, then run:

```bash
chmod +x install/install.sh
./install/install.sh
```

### Windows

The Windows build uses [PDCursesMod](https://github.com/Bill-Gray/PDCursesMod) as a drop-in replacement for ncurses.

- Inside the project root, go into the `install` folder
- Run `install.bat` as administrator
- If Chocolatey is not installed, the script will install it and prompt you to reopen — just run it again after
- Once all dependencies are ready, the script will compile and launch the game automatically

<details>
<summary>Show install.bat</summary>

```bat
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
echo Running make...
make
if %errorlevel% neq 0 (
    echo Build Failed!
    pause
    exit /b 1
)
echo Project built.
echo Executing binary...
program.exe
pause
```

</details>

## What is ncurses?

ncurses (new curses) is a C library for building text-based user interfaces (TUIs) that work across a wide variety of terminals. It handles terminal differences automatically and optimizes screen updates to minimize redraw latency.
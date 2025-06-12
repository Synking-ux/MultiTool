@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title WinRAR Bruteforcer
color 3

:: Define ANSI Escape
for /f "delims=" %%A in ('"prompt $E"') do set "ESC=%%A"

:: Color Codes
set "RED=%ESC%[31m"
set "GREEN=%ESC%[32m"
set "CYAN=%ESC%[36m"
set "RESET=%ESC%[0m"


:banner
echo.
echo.
echo 		██╗    ██╗██╗███╗   ██╗██████╗  █████╗ ██████╗     ███████╗ ██████╗ ██████╗  ██████╗███████╗██████╗ 
echo 		██║    ██║██║████╗  ██║██╔══██╗██╔══██╗██╔══██╗    ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
echo 		██║ █╗ ██║██║██╔██╗ ██║██████╔╝███████║██████╔╝    █████╗  ██║   ██║██████╔╝██║     █████╗  ██████╔╝
echo 		██║███╗██║██║██║╚██╗██║██╔══██╗██╔══██║██╔══██╗    ██╔══╝  ██║   ██║██╔══██╗██║     ██╔══╝  ██╔══██╗
echo 		╚███╔███╔╝██║██║ ╚████║██║  ██║██║  ██║██║  ██║    ██║     ╚██████╔╝██║  ██║╚██████╗███████╗██║  ██║
echo  		 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝
echo.                                                                                               



:: Check if 7-Zip is installed
if not exist "C:\Program Files\7-Zip\7z.exe" (
    echo 7-Zip not installed!
    pause
    exit
)

:: Get archive path
echo.
set /p "archive=Enter Archive Path: "
if not exist "%archive%" (
    echo Archive not found!
    pause
    exit
)

:: Get wordlist path
set /p "wordlist=Enter Wordlist Path: "
if not exist "%wordlist%" (
    echo Wordlist not found!
    pause
    exit
)

echo.
echo %CYAN%Starting Brute-force Attack...%RESET%
echo.

:: Loop through each line in the wordlist
for /f "usebackq delims=" %%a in ("%wordlist%") do (
    set "pass=%%a"
    if not "!pass!"=="" (
        call :attempt
    )
)

:: If script reaches here, password wasn't found
echo.
echo %RED%Password not found in wordlist.%RESET%
pause
exit

:attempt
:: Try extracting with current password
"C:\Program Files\7-Zip\7z.exe" x -p!pass! "%archive%" -o"cracked" -y >nul 2>&1

:: Check result
if !errorlevel! EQU 0 (
    echo.
    :: echo %GREEN%Success! Password Found: !pass!%RESET%
    echo Bruteforce Successful.....
	echo %GREEN%Password Found: !pass!%RESET%
    echo.
    pause
    start "" "%~dp0..\Main.bat"
    exit
)
echo %RED%Attempting :%RESET% !pass!
goto :eof

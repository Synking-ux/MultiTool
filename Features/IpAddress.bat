@echo off
title IP Address
chcp 65001 >nul
cls

:: Set ESC for ANSI colors
for /f "delims=" %%A in ('"prompt $E"') do set "ESC=%%A"

:: Display Banner
:banner
echo.
echo.
echo %ESC%[38;5;46m 			██╗██████╗      █████╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗███████╗
echo %ESC%[38;5;46m 			██║██╔══██╗    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝
echo %ESC%[38;5;46m 			██║██████╔╝    ███████║██║  ██║██║  ██║██████╔╝█████╗  ███████╗███████╗
echo %ESC%[38;5;46m 			██║██╔═══╝     ██╔══██║██║  ██║██║  ██║██╔══██╗██╔══╝  ╚════██║╚════██║
echo %ESC%[38;5;46m 			██║██║         ██║  ██║██████╔╝██████╔╝██║  ██║███████╗███████║███████║
echo %ESC%[38;5;46m 			╚═╝╚═╝         ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝%ESC%[0m
echo.
echo.

:menu
echo ^>^>^>^>: %ESC%[38;5;46m(1)%ESC%[0m Public IP Address
echo ^>^>^>^>: %ESC%[38;5;46m(2)%ESC%[0m Private IP Address
echo ^>^>^>^>: %ESC%[38;5;46m(99)%ESC%[0m Exit
echo.

set /p inp=Enter a Number: 

if "%inp%"=="2" (
    echo.
    echo Private IP Address:
    for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4 Address"') do echo     %%A
    echo.
    goto menu
)

if "%inp%"=="1" (
    echo.
    echo Public IP Address:
    for /f %%A in ('curl -s ifconfig.me') do echo     %%A
    echo.
    goto menu
)

if "%inp%"=="99" (
    echo.
    echo Launching mt.bat in a new window...
    start "" "%~dp0..\Main.bat"
    exit
)

echo.
echo Invalid input. Try again.
pause >nul
goto menu

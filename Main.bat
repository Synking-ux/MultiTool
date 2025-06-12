@echo off
title MultiTool - By Synking
chcp 65001 >nul
cls

:: Set ANSI Escape Character
set "ESC="

:: Gradient Banner
echo.
echo.
echo %ESC%[38;5;196m 			███╗   ███╗██╗   ██╗██╗  ████████╗██╗    ████████╗ ██████╗  ██████╗ ██╗
echo %ESC%[38;5;202m 			████╗ ████║██║   ██║██║  ╚══██╔══╝██║    ╚══██╔══╝██╔═══██╗██╔═══██╗██║
echo %ESC%[38;5;208m 			██╔████╔██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║
echo %ESC%[38;5;214m 			██║╚██╔╝██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║
echo %ESC%[38;5;220m 			██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║       ██║   ╚██████╔╝╚██████╔╝███████╗
echo %ESC%[38;5;226m 			╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝%ESC%[0m
echo.
echo.
echo %ESC%[38;5;220m  		● (1) IP Lookup Tool%ESC%[0m
echo %ESC%[38;5;220m  		● (2) Netsh Run%ESC%[0m
echo %ESC%[38;5;220m  		● (3) My IP Address%ESC%[0m
echo %ESC%[38;5;220m		● (4) Password Changer%ESC%[0m
echo %ESC%[38;5;220m		● (5) Wordlist Generator%ESC%[0m
echo %ESC%[38;5;220m		● (6) WinRAR Bruteforcer%ESC%[0m
echo %ESC%[38;5;220m 		● (e) Exit%ESC%[0m
echo.

:menu
set /p inp=Enter a Number: 

if /i "%inp%"=="1" (
	start "" "%~dp0Features\RunIpLookup.bat"
	exit
)

if /i "%inp%"=="2" (
	start "" "%~dp0Features\Netstat.bat"
	exit
)

if /i "%inp%"=="3" (
    start "" "%~dp0Features\IpAddress.bat"
    exit
)

if /i "%inp%"=="4" (
    start "" "%~dp0Features\PassChange.bat"
    exit
)

if /i "%inp%"=="5" (
    start "" "%~dp0Features\WordlistGenerator.bat"
    exit
)

if /i "%inp%"=="6" (
    start "" "%~dp0Features\WinForcer.bat"
    exit
)

if /i "%inp%"=="e" (
	exit
)

:: Invalid Input Handler
echo %ESC%[38;5;196m[!] Invalid input! Please try again.%ESC%[0m
goto menu

@echo off
title Custom Admin CMD

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

:: Display some command
color a
netstat -nbf

:: Ask user for input
echo.
set /p userinput=^>^>^>

if /i "%userinput%"=="exit" (
    echo Launching mt.bat in a new window...
    start "" "%~dp0..\Main.bat"
    exit /b
) else (
    echo Invalid input. Exiting...
    timeout /t 2 >nul
    exit /b
)

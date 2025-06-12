@echo off
chcp 65001 >nul
title Password Changer Tool
cls

for /f "delims=" %%A in ('"prompt $E"') do set "ESC=%%A"

:menu
cls
echo.
echo.
echo %ESC%[38;5;46m		██████╗  █████╗ ███████╗███████╗     ██████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗
echo %ESC%[38;5;46m		██╔══██╗██╔══██╗██╔════╝██╔════╝    ██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝
echo %ESC%[38;5;46m		██████╔╝███████║███████╗███████╗    ██║     ███████║███████║██╔██╗ ██║██║  ███╗█████╗  
echo %ESC%[38;5;46m		██╔═══╝ ██╔══██║╚════██║╚════██║    ██║     ██╔══██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  
echo %ESC%[38;5;46m		██║     ██║  ██║███████║███████║    ╚██████╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗
echo %ESC%[38;5;46m		╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝%ESC%[0m  
echo.
echo.

echo ^|-------^>^> %ESC%[38;5;46m(1)%ESC%[0m List Users
echo ^|-------^>^> %ESC%[38;5;46m(2)%ESC%[0m Create A New User
echo ^|-------^>^> %ESC%[38;5;46m(3)%ESC%[0m Change a User Password
echo ^|-------^>^> %ESC%[38;5;46m(4)%ESC%[0m Delete a User
echo ^|-------^>^> %ESC%[38;5;46m(5)%ESC%[0m ^Exit
echo.

set /p input="^>^> "

if "%input%" EQU "1" (
    color a
    title List Users
    cls
    net user
    pause
    goto menu
)

if "%input%" EQU "2" (
    call :checkadmin
    title Creating a new User
    color a
    cls
    :getusername
    set "user="
    set /p "user=Username: "
    if not defined user goto :getusername
    
    :getpassword
    set "password="
    set /p "password=Password: "
    if not defined password goto :getpassword
    
    net user "%user%" "%password%" /add
    if %errorlevel% equ 0 (
        echo User "%user%" created successfully!
    ) else (
        echo Failed to create user!
    )
    pause
    goto menu
)

if "%input%" EQU "3" (
    call :checkadmin
    title Changing a Users Password
    cls
    color a
    :getuser
    set "user="
    set /p "user=Username: "
    if not defined user goto :getuser
    
    :getnewpass
    set "password="
    set /p "password=New Password: "
    if not defined password goto :getnewpass
    
    net user "%user%" "%password%"
    if %errorlevel% equ 0 (
        echo Password for "%user%" changed successfully!
    ) else (
        echo Failed to change password!
    )
    pause
    goto menu
)

if "%input%" EQU "4" (
    call :checkadmin
    color a
    cls
    echo You are the worst person ever. Tryna delete someone's account. 
    echo Don't you have morals? I'm disappointed in you!
    pause
    goto menu
)

if "%input%" EQU "5" (
    echo Bye!
    start "" "%~dp0..\Main.bat"
    exit /b
)

goto menu

:checkadmin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Restart the program with administration privileges^^!^^!^^!
    pause
    exit
)
exit /b
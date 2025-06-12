@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ================= Banner =================
title 🔐 Advanced Wordlist Generator v3.0
cls

:banner
echo.
echo.
echo %ESC%[35m	    ██╗    ██╗ ██████╗ ██████╗ ██████╗ ██╗     ██╗███████╗████████╗     ██████╗ ███████╗███╗   ██╗
echo %ESC%[35m	    ██║    ██║██╔═══██╗██╔══██╗██╔══██╗██║     ██║██╔════╝╚══██╔══╝    ██╔════╝ ██╔════╝████╗  ██║
echo %ESC%[35m	    ██║ █╗ ██║██║   ██║██████╔╝██║  ██║██║     ██║███████╗   ██║       ██║  ███╗█████╗  ██╔██╗ ██║
echo %ESC%[35m	    ██║███╗██║██║   ██║██╔══██╗██║  ██║██║     ██║╚════██║   ██║       ██║   ██║██╔══╝  ██║╚██╗██║
echo %ESC%[35m	    ╚███╔███╔╝╚██████╔╝██║  ██║██████╔╝███████╗██║███████║   ██║       ╚██████╔╝███████╗██║ ╚████║
echo %ESC%[35m 	     ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝╚══════╝   ╚═╝        ╚═════╝ ╚══════╝╚═╝  ╚═══╝ v3.0%ESC%[0m
echo. 
echo.                                      


:: ================= User Input =================
echo Enter space-separated values for each category.
set /p "names=Names (first, last, nicknames): "
set /p "birth=Birthdate (DD-MM-YYYY): "
set /p "special=Special numbers (phone, PINs, etc): "
set /p "keywords=Keywords (pets, hobbies, etc): "
set /p "symbols=Symbols to include (_ @ - .): "
set /p "outdir=Output directory (leave blank for current): "

:: ============ Parse Birthdate ============
for /f "tokens=1-3 delims=-" %%a in ("%birth%") do (
    set "dd=%%a"
    set "mm=%%b"
    set "yyyy=%%c"
    set "yy=%%c"
    set "yy=!yy:~2,2!"
)

:: ============ Merge All Elements ============
set "elements=%names% %dd% %mm% %yyyy% %yy% %special% %keywords%"

:: ============ Prepare Output ============
if "%outdir%"=="" (
    set "outfile=wordlist.txt"
) else (
    if not exist "%outdir%" mkdir "%outdir%"
    set "outfile=%outdir%\wordlist.txt"
)
if exist "%outfile%" del "%outfile%"
set "tempfile=~temp_wordlist.txt"
if exist "%tempfile%" del "%tempfile%"

:: ============ Generate Combinations ============
echo Generating combinations...

:: Write all 1-part, 2-part, and 3-part combinations
for %%a in (%elements%) do (
    echo %%a>> %tempfile%
    for %%b in (%elements%) do (
        echo %%a%%b>> %tempfile%
        for %%c in (%elements%) do (
            echo %%a%%b%%c>> %tempfile%
        )
    )
)

:: ============ Add Symbols ============
if not "%symbols%"=="" (
    for %%word in (%elements%) do (
        for %%s in (%symbols%) do (
            >> "!tempfile!" (
                echo %%word%%s
                echo %%s%%word
            )
        )
    )
)


:: ============ Add Common Password Patterns ============
echo password>> %tempfile%
echo qwerty>> %tempfile%
echo letmein>> %tempfile%
echo abc123>> %tempfile%
echo 123456>> %tempfile%

:: ============ Leetspeak Variants ============
for %%w in (%elements%) do call :leet "%%w"

:: ============ Final Filter ============
type %tempfile% | sort | findstr /v /r "^$" > "%outfile%"
del %tempfile%

:: ============ Done ============
echo.
echo ✅ Wordlist saved as: "%outfile%"
echo Total entries: 
for /f %%c in ('type "%outfile%" ^| find /c /v ""') do set count=%%c
echo !count! words generated.
pause
start "" "%~dp0..\Main.bat"
exit

:: ============ Leetspeak Subroutine ============
:leet
setlocal EnableDelayedExpansion
set "word=%~1"
set "leet=!word!"
set "leet=!leet:a=4!"
set "leet=!leet:e=3!"
set "leet=!leet:i=1!"
set "leet=!leet:o=0!"
set "leet=!leet:s=5!"
set "leet=!leet:t=7!"
(
    echo !leet!
    echo !leet!123
    echo !leet!!yyyy!
) >> "!tempfile!"
endlocal
pause
start "" "%~dp0..\Main.bat"
exit /b


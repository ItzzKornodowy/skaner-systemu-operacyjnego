@echo off
title Skaner systemu - weryfikacja konta uzytkownika


net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [BLAD] Uruchom ten program jako administrator!
    pause >nul
    exit /b
)

echo Trwa wczytywanie programu...
ping localhost -n 3 >nul
echo Gotowe!
goto menu

:menu
title Skaner systemu - menu
cls
echo. 
echo -----------------------------------------------------------
echo ---------- Witaj w skanerze systemu operacyjnego ----------
echo ----------- wybierz opcje i zacznij skanowanie! -----------
echo ---- Pamietaj aby uruchomic program jako administrator ----
echo -----------------------------------------------------------
echo.
echo 1. Skanuj rejestr
echo 2. Skanuj system w poszukiwaniu wirusow [ Tylko jesli nie masz antywirusa ]
echo 3. Skanuj sciezke [ Tylko jesli nie masz antywirusa ]
echo 4. Wyjdz
echo.
echo Wpisz "info" aby wyswietlic informacje o programie
echo.
set /p Wybieram:=Wybieram:
if %Wybieram:%==1 goto rejestr
if %Wybieram:%==2 goto antwirus
if %Wybieram:%==3 goto sciezka
if %Wybieram:%==4 goto exit
if %Wybieram:%==info goto informacje


:wyjdz
exit

:informacje
cls
title Skaner systemu autorstwa Kornodowego
echo (c) Kornodowy. Wszelkie prawa zastrzezone.
echo.
echo. 
echo -----------------------------------------------------------
echo ------------ Skaner systemu operacyjnego v.1.0 ------------
echo ------------ Autorstwa Kornodowego (kornodowy) ------------
echo ----------- E-Mail: kontakt.z@kornodowy.hub.pl ------------
echo ------------------ Github: ItzzKornodowy ------------------
echo -----------------------------------------------------------
echo.
echo.
echo Kliknij Dowolny Przycisk Aby Kontynuowac [. . .]
pause >nul
goto menu

:sciezka
echo Podaj sciezke do folderu ktory chcesz przeskanowac:
set /p folder=Sciezka: 

echo [INFO] Rozpoczynam skanowanie folderu "%folder%" . . .
"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanPath "%folder%"
echo.
echo Skanowanie zostalo zakonczone!
pause

:rejestr
cls
title Skaner systemu - skanowanie rejestru
sfc /scannow
echo Skanowanie zostalo zakonczone a wszystkie bledy w rejestrze naprawione
echo jesli system je wykryl, dziekuje za cierpliwosc!
ping localhost -n 3 >nul
echo kliknij [ Enter ] aby kontynuowac
pause > nul
goto menu

:antwirus
cls
title Skanowanie systemu - Windows Defender


set "defenderPath=%ProgramFiles%\Windows Defender\MpCmdRun.exe"

if exist "%defenderPath%" (
    echo [INFO] Rozpoczynam skanowanie systemu za pomoca Windows Defender . . .
    "%defenderPath%" -Scan -ScanType 2
    echo Skanowanie zakonczone.
) else (
    echo [BLAD] Windows Defender nie jest dostępny na tym systemie.
)

pause

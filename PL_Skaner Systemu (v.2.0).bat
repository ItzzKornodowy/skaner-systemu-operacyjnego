@echo off
title Skaner systemu - weryfikacja konta uzytkownika


@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Prosze o uruchomienie programu jako administrator!
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Trwa wczytywanie programu...
ping localhost -n 1 >nul
echo Gotowe!
goto menu

:menu
title Skaner systemu - menu
cls
echo. 
echo -----------------------------------------------------------
echo ---------- Witaj w skanerze systemu operacyjnego ----------
echo ----------- wybierz opcje i zacznij skanowanie! -----------
echo -----------------------------------------------------------
echo.
echo 1. Skanuj pliki systemowe w poszukiwaniu bledow.
echo 2. Skanuj system w poszukiwaniu wirusow [ Tylko jesli nie masz antywirusa ]
echo 3. Skanuj sciezke [ Tylko jesli nie masz antywirusa ]
echo 4. Wiecej Opcji [ Diagnostyka SO ]
echo 5. Wyjdz
echo.
echo Wpisz "info" aby wyswietlic informacje o programie
echo.
set /p Wybieram:=Wybieram:
if %Wybieram:%==1 goto rejestr
if %Wybieram:%==2 goto antwirus
if %Wybieram:%==3 goto sciezka
if %Wybieram:%==4 goto wincyj
if %Wybieram:%==5 goto exit
if %Wybieram:%==info goto informacje


:wyjdz
exit

:wincyj
cls
echo -----------------------------------------------------------
echo ------------- Diagnostyka Systemu Operacyjnego ------------
echo -----------------------------------------------------------
echo.
echo 1. Skanuj Dysk w poszukiwaniu bledow.
echo 2. Oczysc pliki tymczasowe
echo 3. Wyswietl liste procesow
echo 4. Sprawdz wersje systemu
echo 5. Wroc
set /p DiagWybieram:=Wybieram:
if %DiagWybieram:%==1 goto sprdsk
if %DiagWybieram:%==2 goto oczysctemp
if %DiagWybieram:%==3 goto procesy
if %DiagWybieram:%==4 goto sopver
if %DiagWybieram:%==5 goto menu
if %DiagWybieram:%==info goto informacje

:sopver
winver
goto wincyj

:procesy
tasklist
echo Koniec listy - Kliknij dowolny przycisk aby kontynuowac
pause >nul
goto wincyj

:oczysctemp
del /s /q C:\Windows\Temp\*
echo Operacja zakonczona sukcesem !
ping localhost -n 3 >nul
goto wincyj

:sprdysk
echo 1. Skanuj Dysk systemowy (C:)
echo 2. Wybieram inny Dysk
echo 3. Wroc
echo.
echo UWAGA! ZAPISZ WSZYSTKIE ZMIANY ZANIM TO ZROBISZ
echo.
set /p chdskw:=Wybieram:
if %chdskw:%==1 goto sprdsk
if %chdskw:%==2 goto nstndsk
if %chdskw:%==3 goto oczysctemp
if %chdskw:%==info goto informacje

:sprdsk
echo jestes pewny (t/n)
set /p chdskwarn:=Wybieram:
if %chdskwarn:%==t goto dyskC
if %chdskwarn:%==n goto wincyj

:dyskC
chkdsk C: /f /r
shutdown /r /t 0

:nstndsk
cls
echo Prosze Wpisac Litere Dysku (np. E)
set /p customdysk:=Wybieram:
goto warning

:warning
echo jestes pewny (t/n)
set /p chdskwarn:=Wybieram:
if %chdskwarn:%==t goto dyskkontynuj
if %chdskwarn:%==n goto wincyj

:dyskkontynuj
chkdsk %customdysk:%: /f /r
shutdown /r /t 0

:informacje
cls
title Skaner systemu autorstwa Kornodowego
echo (c) Kornodowy. Wszelkie prawa zastrzezone.
echo.
echo. 
echo -----------------------------------------------------------
echo ------------ Skaner systemu operacyjnego v.2.0 ------------
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
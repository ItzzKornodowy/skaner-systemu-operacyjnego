@echo off
title Skaner systemu - Kontrola konta uzytkownika


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
echo --------------------------------------------------------------------------------
echo -------------------- Witaj w skanerze systemu operacyjnego ---------------------
echo --------------------- wybierz opcje i zacznij skanowanie! ----------------------
echo --------------------------------------------------------------------------------
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-= Skanowanie Systemu =-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo 1. Skanuj pliki systemowe w poszukiwaniu bledow.
echo 2. Skanuj system w poszukiwaniu wirusow [ Tylko jesli nie masz antywirusa ]
echo 3. Skanuj sciezke [ Tylko jesli nie masz antywirusa ]
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-= Diagnostyka Systemu =-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo 4. Wiecej Opcji [ Diagnostyka SO ]
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-= Terminacje procesow =-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo 5. TaskKiller (Wbudowany osobny program przystosowany do skanera SO)
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Zakoncz Program =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo 6. Wyjdz
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Inne Opcje =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo Wpisz "info" aby wyswietlic informacje o programie
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
set /p Wybieram:=Wybieram: 
if %Wybieram:%==1 goto rejestr
if %Wybieram:%==2 goto antwirus
if %Wybieram:%==3 goto sciezka
if %Wybieram:%==4 goto wincyj
if %Wybieram:%==5 goto taskkillerbatch
if %Wybieram:%==6 goto exit
if %Wybieram:%==info goto informacje
if %Wybieram:%==test goto forcecrash
if %Wybieram:%==easteregg goto curlparrot
if %Wybieram:%==appdata goto appdatafolder
if %Wybieram:%==programdata goto programdatafolder
if %Wybieram:%==ukryteelementy.true goto pokaukryte
if %Wybieram:%==ukryteelementy.false goto schowajukryte

:schowajukryte
powershell -Command "$key='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Set-ItemProperty -Path $key -Name Hidden -Value 2"
powershell -Command "Stop-Process -Name explorer -Force; Start-Process explorer"
goto menu

:pokaukryte
powershell -Command "$key='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Set-ItemProperty -Path $key -Name Hidden -Value 1"
powershell -Command "Stop-Process -Name explorer -Force; Start-Process explorer"
goto menu

:programdatafolder
explorer C:\ProgramData

:appdatafolder
explorer C:\Users\%USERNAME%\AppData
goto menu

:forcecrash
title TEST.
if %errorlevel% neq 0 goto blynd
exit /b 1
if %errorlevel% neq 0 goto blynd

:curlparrot
title JEZUNIU MILAN
curl parrot.live


:wyjdz
exit

:wincyj
title Skaner systemu - Diagnostyka SO
cls
echo -----------------------------------------------------------
echo ------------- Diagnostyka Systemu Operacyjnego ------------
echo -----------------------------------------------------------
echo.
echo 1. Skanuj Dysk w poszukiwaniu bledow.
echo 2. Oczysc pliki tymczasowe
echo 3. Wyswietl liste procesow
echo 4. Sprawdz wersje systemu
echo 5. Skanowanie pamieci RAM
echo 5. Wroc
set /p DiagWybieram:=Wybieram:
if %DiagWybieram:%==1 goto sprdysk
if %DiagWybieram:%==2 goto oczysctemp
if %DiagWybieram:%==3 goto procesy
if %DiagWybieram:%==4 goto sopver
if %DiagWybieram:%==5 goto ramscan
if %DiagWybieram:%==6 goto menu
if %DiagWybieram:%==info goto informacje

:ramscan
cls
mdsched
goto menu

:sopver
title Skaner systemu - Wersja SO
winver
goto wincyj

:procesy
title Skaner systemu - Aktywne Procesy
tasklist
echo.
echo Koniec listy - Kliknij dowolny przycisk aby kontynuowac
pause >nul
goto wincyj

:oczysctemp
title Skaner systemu - Czyszczenie zbednych plikow
del /s /q C:\Windows\Temp\*
if %errorlevel% neq 0 goto blynd
echo Operacja zakonczona sukcesem !
ping localhost -n 3 >nul
goto wincyj

:sprdysk
title Skaner systemu - Skan Dysku (Wybierz Opcje)
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
title Skaner systemu - Potwierdz Wybor (Skanowanie Dysku C:)
echo jestes pewny (t/n)
set /p chdskwarn:=Wybieram:
if %chdskwarn:%==t goto dyskC
if %chdskwarn:%==n goto wincyj

:dyskC
title Skaner systemu - Rozpoczynam Prace . . .
chkdsk C: /f /r
shutdown /r /t 0

:nstndsk
title Skaner systemu - Skanowanie wybranego dysku (Wybierz Opcje)
cls
echo Prosze Wpisac Litere Dysku (np. E)
set /p customdysk:=Wybieram:
goto warning

:warning
title Skaner systemu - Ostrzezenie (Skan dysku %customdysk%)
echo jestes pewny ze chcesz przeskanowac dysk %customdysk% (t/n)
set /p chdskwarn:=Wybieram:
if %chdskwarn:%==t goto dyskkontynuj
if %chdskwarn:%==n goto wincyj

:dyskkontynuj
title Skaner systemu - Rozpoczynam Prace . . .
chkdsk %customdysk:%: /f /r
shutdown /r /t 0

:informacje
cls
title Skaner systemu operacyjnego autorstwa Kornodowego
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
if %errorlevel% neq 0 goto blynd

:sciezka
title Skaner systemu - Wybierz sciezke do skanu
echo Podaj sciezke do folderu ktory chcesz przeskanowac:
set /p folder=Sciezka: 

title Skaner systemu - Skanowanie Folderu
echo [INFO] Rozpoczynam skanowanie folderu "%folder%" . . .
"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanPath "%folder%"
echo.
echo Skanowanie zostalo zakonczone!
pause

:rejestr
title Skaner systemu - Skanowanie Plikow Systemowych
cls
sfc /scannow
echo Skanowanie zostalo zakonczone a wszystkie bledy naprawione
echo jesli system je wykryl, dziekuje za cierpliwosc!
ping localhost -n 3 >nul
echo kliknij [ Enter ] aby kontynuowac
pause > nul
goto menu

:antwirus
title Skaner systemu - Skaner
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

::TASKKILLER

:taskkillerbatch
@echo off
title Skaner systemu - TaskKiller
goto menu2

:menu2
title Skaner systemu - TaskKiller Menu
cls
echo. 
echo -----------------------------------------------------------
echo ------------------ TaskKiller v.1.0-ws --------------------
echo ---------------------- wybierz opcje ----------------------
echo -----------------------------------------------------------
echo.
echo 1. Zakoncz proces przez nazwe procesu (.exe)
echo 2. Zakoncz proces przez pelna nazwe procesu (rozszerzenie niestandardowe np. plik.txt albo notepad.exe)
echo 3. Zakoncz proces przez PID (process id / identyfikator procesu)
echo 4. Wyjdz
echo.
echo Wpisz "info" aby wyswietlic informacje o programie
echo.
set /p Wybieram=Wybieram: 
if "%Wybieram%"=="1" goto procexe
if "%Wybieram%"=="2" goto procniestand
if "%Wybieram%"=="3" goto procpid
if "%Wybieram%"=="4" goto menu
if /i "%Wybieram%"=="info" goto informacje2
goto menu2
if %errorlevel% neq 0 goto blynd

:procexe
title Skaner systemu - Zakoncz Zadanie (exe)
cls
set /p Zadanie=Nazwa Zadania:
if /i "%Zadanie%"=="x" goto menu2
taskkill /f /im "%Zadanie%.exe" /t
if %errorlevel% neq 0 goto blynd
title Wynik dla %Zadanie%.exe
echo Kliknij dowolny przycisk aby kontynuowac...
pause >nul
goto menu2

:procniestand
title Skaner systemu - Zakoncz Proces Niestandardowy 
cls
set /p ZadanieNiestandardowe=Nazwa Zadania:
if /i "%ZadanieNiestandardowe%"=="x" goto menu2
taskkill /f /im "%ZadanieNiestandardowe%" /t
if %errorlevel% neq 0 goto blynd
title Wynik dla %ZadanieNiestandardowe%
echo Kliknij dowolny przycisk aby kontynuowac...
pause >nul
goto menu2

:procpid
title Skaner systemu - Zakoncz Proces przez PID
cls
set /p ProcessID=ID procesu:
if /i "%ProcessID%"=="x" goto menu2
TASKKILL /PID "%ProcessID%"
if %errorlevel% neq 0 goto blynd
title Wynik dla PID: %ProcessID%
echo Kliknij dowolny przycisk aby kontynuowac...
pause >nul
goto menu2

:wyjdz
exit

:informacje2
title Skaner systemu - TaskKiller - Informacje
cls
title Program polegajacy na natychmiastowym zatrzymywaniu procesu autorstwa Kornodowego
echo (c) Kornodowy. Wszelkie prawa zastrzezone.
echo.
echo. 
echo -----------------------------------------------------------
echo ---------------- Wersja Programu v.1.0-ws -----------------
echo ------------ Autorstwa Kornodowego (kornodowy) ------------
echo ----------- E-Mail: kontakt.z@kornodowy.hub.pl ------------
echo ------------------ Github: ItzzKornodowy ------------------
echo -----------------------------------------------------------
echo.
echo.
echo -----------------------------------------------------------
echo ----------------------- TaskKiller ------------------------
echo -------------------- Wersja Specjalna ---------------------
echo ---------- Przeznaczona dla programu: Skaner SO -----------
echo -----------------------------------------------------------
echo ----------- Zbudowany na "jadrze" wersji V.1.1 ------------
echo -----------------------------------------------------------
echo.
echo Kliknij dowolny przycisk aby kontynuowac...
pause >nul
goto menu2

:blynd
title Skaner systemu - Blad
cls
color C
echo UWAGA: Wystapil blad podczas wykonywania tej operacji:
echo.
echo Przyczyny:
echo - Operacja niepoprawna
echo - Zla kompilacja polecenia
echo - Wartosc ktora wstawiles jest niepoprawna badz nie istnieje.
echo kontakt: kontakt.z@kornodowy.hub.pl
echo.
echo Kliknij dowolny przycisk aby wrocic do ekranu startowego.
pause >nul
color 7
goto menu

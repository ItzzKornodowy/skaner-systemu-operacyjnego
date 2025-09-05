@echo off
goto programconfig

:inicjalizacja
color b
title Uzytkownik: %username%
echo. 
echo Kliknij dowolny przycisk aby wczytac program ponownie
pause >nul
goto kontrolakonta

:programconfig
:: zainicjuj konfiguracje
set "config=%appdata%\KonfiguracjaSkanerSOP.txt"
set "trolling=C:\Users\%username%\Desktop\JezuniuMilan.txt"
set "customcmdconfig=%appdata%\AkcjeNiestandardoweSkanerSOP.txt"
set "AUTOSTART=%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"


:: Repozytorium i branch
setlocal
set REPO=ItzzKornodowy/skaner-systemu-operacyjnego
set BRANCH=main

goto kontrolakonta

:kontrolakonta
title Skaner systemu - Kontrola konta uzytkownika
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Prosze o uruchomienie programu jako administrator!
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Trwa wczytywanie programu...
ping localhost -n 1 >nul
echo Gotowe!
goto wczytajmotyw

:wczytajmotyw
cls
if exist "%config%" (
    for /f "usebackq delims=" %%i in ("%config%") do (
        %%i
    )
)

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
echo Wpisz "ustawienia" aby wejsc do ustawien
echo Wpisz "aktualizacja" aby zobaczyc wszystkie wersje badz je pobrac
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
if %Wybieram:%==ustawienia goto ustawienia
if %Wybieram:%==cmd goto cmdprompt
if %Wybieram:%==aktualizacja goto update
if "%Wybieram:%"=="JezuniuMilan" goto jezuniumilanxd
if "%Wybieram:%"=="jezuniumilan" goto jezuniumilanxd
if "%Wybieram:%"=="Jezuniu" goto jezuniumilanxd
if "%Wybieram:%"=="Milan" goto jezuniumilanxd
if "%Wybieram:%"=="milan" goto jezuniumilanxd
if "%Wybieram:%"=="jezuniu" goto jezuniumilanxd
if "%Wybieram:%"=="JEZUNIUMILAN" goto jezuniumilanxd

:jezuniumilanxd
echo Jezuniu Milan, https://www.youtube.com/@milanowyyy. Milan jak to czytasz to jest easteregg blagam nie zabij mnie tylko za to 🙏🙏🙏... Jak cos to COSTAMOWKI atakuja caly swiat i costamowkuja. DAJ mi zyc, zobacz dam ci nawet tu reklame twojego dc xd: https://discord.gg/hWfTvGm52D (Nie zabijaj). A jak to za malo to jeszcze tiktok https://www.tiktok.com/@mrkrafcik TYLKO PLIS NIE ZABIJAJ...> "%trolling%"
goto blynd



:update
cls
echo ================= Wybierz plik do pobrania =================

powershell -NoProfile -Command ^
"$files = Invoke-RestMethod -Uri 'https://api.github.com/repos/ItzzKornodowy/skaner-systemu-operacyjnego/contents/?ref=main'; ^
$i=1; $map=@{}; ^
foreach ($f in $files) { Write-Host ($i.ToString() + '. ' + $f.name); $map[$i] = $f.download_url; $i++ }; ^
do { ^
    $choice = Read-Host 'Wpisz numer pliku do pobrania (0 aby wyjsc)'; ^
    if ($choice -eq '0') { break }; ^
    if ($map.ContainsKey([int]$choice)) { ^
        $dest = $env:USERPROFILE + '\Downloads\' + $map[[int]$choice].Split('/')[-1]; ^
        Invoke-WebRequest -Uri $map[[int]$choice] -OutFile $dest; ^
        Write-Host 'Pobrano plik do Downloads: ' $dest -ForegroundColor Green ^
    } else { Write-Host 'Nieprawidlowy wybor!' -ForegroundColor Red } ^
} while ($true)"

pause
goto wybierz

:WYBIERZ
set /p choice=Wpisz numer pliku do pobrania (0 aby wyjsc): 
if "%choice%"=="0" goto KONIEC_AKTUALIZACJI
:: Pobranie wybranego pliku
powershell -NoProfile -Command ^
"$fileMap = Get-Content 'filemap.json' | ConvertFrom-Json; ^
if ($fileMap.ContainsKey([int]'%choice%')) { ^
    $dest = [Environment]::GetFolderPath('Downloads') + '\' + $fileMap[[int]'%choice%'].Split('/')[-1]; ^
    Invoke-WebRequest -Uri $fileMap[[int]'%choice%'] -OutFile $dest; ^
    Write-Host 'Pobrano plik do Downloads: ' $dest -ForegroundColor Green ^
} else { Write-Host 'Nieprawidlowy wybor!' -ForegroundColor Red }"
pause
del filemap.json
goto aktualizacja

:KONIEC_AKTUALIZACJI
cls
echo Koniec aktualizacji.
pause
goto menu

:cmdprompt
cls
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Wewnetrzna konsola polecen [Skaner SOP]
echo Wpisz komende ktora chcesz wykonac
set /p cmdinsert="Polecenie: "
%cmdinsert%
pause
echo Czy chcesz wykonac inne polecenie [t/n]
set /p dalszepolecenia="Wartosc: "
if "%dalszepolecenia%"=="y" goto cmdprompt
if "%dalszepolecenia%"=="n" goto menu

:ustawienia
cls
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Wybierz zakladke:
echo 1 - Ustawienia Motywu
echo 2 - Akcje przy uruchomieniu aplikacji
echo 3 - Dodaj program do autostartu
echo 4 - Usun program z autostartu
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set /p wybieramy="Wpisz numer: "
if "%wybieramy%"=="1" goto ustawieniamotywu
if "%wybieramy%"=="2" goto ustawakcje
if "%wybieramy%"=="3" goto dodajautostart
if "%wybieramy%"=="4" goto usunautostart


:ustawakcje
cls
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Wpisz komende (CMD/BATCH) ktora ma sie wykonac
echo Po uruchomieniu aplikacji.
echo.
echo Jesli chcesz usunac akcje pozostaw te pole puste. :)
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=  
set /p customcmd="Wpisz komende: "
    echo %customcmd% > "%customcmdconfig%"

    :dodajautostart
    powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AUTOSTART%\PL_Skaner Systemu (v.4.0).lnk');$s.TargetPath='%~f0';$s.Save()"
goto menu

:usunautostart
if exist "%AUTOSTART%\PL_Skaner Systemu (v.4.0).lnk" (
    del "%AUTOSTART%\PL_Skaner Systemu (v.4.0).lnk"
    goto menu
) else (
    goto blynd
)

:ustawieniamotywu
cls
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Wybierz motyw:
echo 1 - Powershell
echo 2 - Hackerski
echo 3 - Tryb ciemny [Domyslny]
echo 4 - Tryb Jasny
echo 5 - Niestandardowy
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set /p wybor="Wpisz numer: "

if "%wybor%"=="1" (
    echo color 1F > "%config%"
) else if "%wybor%"=="2" (
    echo color 0A > "%config%"
) else if "%wybor%"=="3" (
    echo color 07 > "%config%"
    ) else if "%wybor%"=="4" (
    echo color F0 > "%config%"
        ) else if "%wybor%"=="5" (
   goto niestandardowykolor
)
goto wczytajmotyw

:niestandardowykolor
cls
echo Oto lista kolorow:
echo.
color /?
echo.
set /p NiestandardowyKolor="Kod Koloru: " 
echo color %NiestandardowyKolor% > "%config%"
if errorlevel 1 goto blynd
goto wczytajmotyw


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
echo ------------ Skaner systemu operacyjnego v.4.0 ------------
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
echo - Operacja niepoprawna.
echo - Zla kompilacja polecenia.
echo - Wartosc ktora wstawiles jest niepoprawna badz nie istnieje.
echo - Probujesz wykonac niemozliwa operacje.
echo - Usunac plik ktory nie istnieje.
echo kontakt: kontakt.z@kornodowy.hub.pl
echo.
echo Kliknij dowolny przycisk aby wrocic do ekranu startowego.
pause >nul
cls
goto inicjalizacja

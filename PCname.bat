@echo off
set LOG=C:\skripte\logs\logfile.txt
>> %LOG% echo Datum: %date%

:abfrage
echo ***********************************************************
echo Bitte PC Namen eingeben, oder Taste x um Vorgang zu beenden
echo ***********************************************************
set /p pcname=
>> %LOG% echo PC: %pcname%


if /i %pcname% == x goto abbruch else goto schleife

:schleife
echo **********************************************
echo Am PC %pcname% wird versucht Ivoris zu beendet
echo **********************************************
taskkill /s %pcname% /f /IM Notepad.exe >> %LOG% 
rem taskkill /s %pcname% /f /IM mspaint.exe >> %LOG% 

echo ********************************************
echo Wollen Sie einen weiteren PC eingeben (j/n)?
echo ********************************************
set /p frage=
if /i %frage% == j goto :abfrage else goto :nein


:nein 
echo Sie haben Nein gedrueckt
echo ************************
ping 127.0.0.1 -n 4 > NUL
>> %LOG% echo ***** ENDE ***** Datum: %date% *****
goto ende


:abbruch
echo Sie haben x gedrueckt. Programm wird beendet
echo ********************************************
ping 127.0.0.1 -n 4 > NUL
>> %LOG% echo ***** ENDE ***** Datum: %date% *****
goto ende

:ende

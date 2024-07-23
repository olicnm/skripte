Windows 7 und Server 2008 (2011) haben den Fehler, dass die CBSLog Dateien da Laufwerk C: zu müllen. Hier ein Skript um den Müll zu entsorgen. Als Batch auf den PC speichern und mit dem Aufgabenplaner 

<code>dir c:\
net stop TrustedInstaller
del C:\Windows\Temp\cab*
del C:\Windows\logs\CBS\*.cab
del C:\Windows\logs\CBS\*.log
net start TrustedInstaller
dir c:\
pause
</code>

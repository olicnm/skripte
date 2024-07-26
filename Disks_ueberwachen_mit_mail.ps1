New-EventLog –LogName System –Source "DiskAlert"

$ThreshHold = 50
$ThreshHold2 = 20

$MachineName = $env:COMPUTERNAME
 $PingMachine = "select * from win32_pingstatus where address = '$MachineName'"
$PingResult = Get-WmiObject -query $PingMachine
 if ($PingResult.protocoladdress) {

 $GetDisks = get-wmiobject Win32_LogicalDisk -computername $MachineName -Filter "DriveType = 3"

 foreach ($Disk in $GetDisks) {
 if ($Disk.size -gt 0) {$PercentFree = [Math]::round((($disk.freespace/$disk.size) * 100))}
 else {$PercentFree = 0}

$Drive = $Disk.DeviceID
"$MachineName – $Drive – $PercentFree"

 if ($PercentFree -gt $ThreshHold) {

 Write-EventLog –LogName System –Source "DiskAlert" –EntryType Information –EventID 111 -Message "Der Speicherplatz auf der Maschine $MachineName, Laufwerk $Drive ist kleiner als $ThreshHold Prozent der Gesamtkapazität. Auf dem Laufwerk $Drive sind nur noch $PercentFree Prozent frei."
}

elseif ($PercentFree -le $ThreshHold2) {

Write-EventLog –LogName System –Source "DiskAlert" –EntryType Warning –EventID 112 -Message "Der Speicherplatz auf der Maschine $MachineName ist kritisch, Laufwerk $Drive ist geringer als $ThreshHold2 Prozent der Gesamtkapazität. Auf dem Laufwerk $Drive sind nur noch $PercentFree Prozent frei."

$Sender = "email sender" 
$Receipt = "email empfänger" 
$Server = "mailserver" 
$Subject = $env:computername+": automatische Festplattenüberwachung vom "+(Get-Date)
$Content = "Der Speicherplatz auf der Maschine $MachineName ist kritisch, Laufwerk $Drive ist geringer als $ThreshHold2 Prozent der Gesamtkapazität. Auf dem Laufwerk $Drive sind nur noch $PercentFree Prozent frei."
$SMTPclient = new-object System.Net.Mail.SmtpClient $Server 
$SMTPClient.port = 587 
$SMTPclient.EnableSsl = $true
$SMTPAuthUsername = "email adresse" 
$SMTPAuthPassword = "email passwort" 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($SMTPAuthUsername, $SMTPAuthPassword)
$Message = new-object System.Net.Mail.MailMessage $Sender, $Receipt, $Subject, $Content 
$Message.IsBodyHtml = $true
$SMTPclient.Send($Message)

}
 }
 }

Remove-EventLog -Source "DiskAlert"

@echo off
%windir%\System32\more +8 "%~f0" > "%temp%\%~n0.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%temp%\%~n0.ps1" %*
del %temp%\%~n0.ps1
pause
exit /b
 
*** Ab hier PowerShell ***
$IP = "127.0.0.1"
$User = "koco-root"
$Pass = "GEHEIM"
 
#Reboot
$PerformAction = "reboot"
$Data = ''
 
# Login
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
$LoginUri = "https://" + $IP + ":9443/j_security_check"
$LoginBody = @{
    j_username = "$User"
    j_password = "$Pass"
}
$LoginResponse = Invoke-WebRequest -Uri $LoginUri -SessionVariable "Session" -Body $LoginBody -Method "POST" 
 
# Get X-Token
$BackendUri = "https://" + $IP + ":9443/administration/json-retrieve/infoservice"
$BackendResponse = Invoke-WebRequest -Uri $BackendUri -WebSession $Session -Headers @{'Content-Type' = 'application/json'}
$xtoken = (((($BackendResponse.Headers."Set-Cookie") -Split ";")[0]) -Split "=")[1]
 
# Perform Action
$PerformUri = "https://" + $IP + ":9443/administration/perform/" + $PerformAction
$PerformHeaders = @{
'Content-Type' = 'application/json'
'X-TOKEN' = "$xtoken"
}
$PerformResponse = Invoke-WebRequest -Uri $PerformUri -WebSession $Session -Body $Data -Method "POST" -Headers $PerformHeaders
echo $PerformResponse.content
 

powershell.exe -file KeyansSNMPscriptbeta.ps1 -IP 10.0.0.1
param([string]$ip="172.16.144.125")
#powershell.exe -file KeyansSNMPscriptbeta.ps1 -IP 10.0.0.1


Write-Host "Executing script for target:"
Write-Host $ip
start-sleep 2
exit

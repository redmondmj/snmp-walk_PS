param([string]$ip="172.16.144.125")

$walk = Invoke-SnmpWalk -IpAddress $ip | Out-File -FilePath ".\PrinterData-$IP.txt" -Append
$script = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument $walk
$trigger = New-ScheduledTaskTrigger -Daily 7pm

Register-ScheduledTask -Action $script -Trigger $trigger -TaskName "WalkPrinter" -Description "SNMP walk on printer"
$oidOwner = "1.3.6.1.2.1.1.4"
$oidLocation = "1.3.6.1.2.1.1.6"
$oidDescription = "1.3.6.1.2.1.1.1"
$oidUptime = "1.3.6.1.2.1.1.3"
  $IP = '172.16.144.252'
  invoke-snmpwalk -IP $IP -Community EntMan -OID $oidOwner | Out-File -FilePath ".\SwitchData-$IP.txt" -Append
    invoke-snmpwalk -IP $IP -Community EntMan -OID $oidLocation | Out-File -FilePath ".\SwitchData-$IP.txt" -Append
    invoke-snmpwalk -IP $IP -Community EntMan -OID $oidDescription | Out-File -FilePath ".\SwitchData-$IP.txt" -Append
    invoke-snmpwalk -IP $IP -Community EntMan -OID $oidUptime | Out-File -FilePath ".\SwitchData-$IP.txt" -Append
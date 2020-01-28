param([string]$ip="172.16.144.125")
$oid = "1.3.6.1.2"


Invoke-SnmpWalk -IpAddress $ip | Format-Table -AutoSize > fullwalk.txt
param([string]$ip="172.16.144.125")
$oid = "1.3.6.1.2.1.43.11.1.1.9.1.1"


#Invoke-SnmpWalk -IpAddress $ip -Oid $oid | Format-Table -AutoSize
Invoke-SnmpWalk -IpAddress $ip -Oid $oid
# | Format-Table -AutoSize
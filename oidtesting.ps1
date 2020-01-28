param([string]$ip="172.16.144.125")
$oid = "1.3.6.1.4.1.1347.43.10.1.1.12.1"


# Invoke-SnmpWalk -IpAddress $ip -Oid $oid | Format-Table -AutoSize
Invoke-SnmpWalk -IpAddress $ip
# | Format-Table -AutoSize
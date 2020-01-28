param([string]$ip="172.16.144.251")
$oid = "1.3.6.1.2.1.1.4"


# Invoke-SnmpWalk -IpAddress $ip -Oid $oid 
Invoke-SnmpWalk -IpAddress $ip -Community EntMan | Format-Table -AutoSize
# | Format-Table -AutoSize
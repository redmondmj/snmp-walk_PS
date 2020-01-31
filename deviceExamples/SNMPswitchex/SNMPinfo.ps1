#pre setting ip address and oids to get info.
$IP = "172.16.144.251"
$COMM = "EntMan"
$oidDeviceOwner = "1.3.6.1.2.1.1.4"
$oidLocation = "1.3.6.1.2.1.1.6"
$oidOS = "1.3.6.1.2.1.1.1"
# creating variables to hold the data
$owner = Invoke-SnmpWalk -ip $IP -Oid $oidDeviceOwner -Community $COMM
$location = Invoke-SnmpWalk -ip $IP -Oid $oidLocation -Community $COMM
$operatingsystem = Invoke-SnmpWalk -ip $IP -Oid $oidOS -Community $COMM


Write-Host "switch owner"
$owner
Write-Host "device location"
$location
Write-Host "operating system"
$operatingsystem
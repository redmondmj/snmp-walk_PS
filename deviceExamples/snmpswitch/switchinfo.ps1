#Setting up known OIDs for the dell switch
$IP = "172.16.144.251"
$COMMUNITY = "EntMan"
$oidDeviceOwner = "1.3.6.1.2.1.1.4"
$oidLocation = "1.3.6.1.2.1.1.6"
$oidOperatingSystem = "1.3.6.1.2.1.1.1"
$owner = Invoke-SnmpWalk -ip $IP -Oid $oidDeviceOwner -Community $COMMUNITY
$location = Invoke-SnmpWalk -ip $IP -Oid $oidLocation -Community $COMMUNITY
$operatingsystem = Invoke-SnmpWalk -ip $IP -Oid $oidOperatingSystem -Community $COMMUNITY

Write-Host "switch owner"
Write-Host "device location"
Write-Host "operating system"
$owner
$location
$operatingsystem
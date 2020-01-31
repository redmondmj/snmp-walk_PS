#Creating Variables
#setting ip of switch
$ip = "172.16.144.251"
#community variable on switch
$community = "EntMan"
#choosing 3 oids for the SNMP walk
$oidLocation = "1.3.6.1.2.1.1.6"
$oidOwner = "1.3.6.1.2.1.1.4"
$oidDeviceName = "1.3.6.1.2.1.1.5"

#run the SMNP using the given ip address and selected oids
$location = Invoke-SnmpWalk -IP $ip -OID $oidLocation -Community $community
$owner = Invoke-SnmpWalk -IP $ip -OID $oidOwner -Community $community
$deviceName = Invoke-SnmpWalk -IP $ip -OID $oidDeviceName -Community $community


#call the gathered data in a function and write it to the host
write-host "Device Location:" $location
write-host "Device Owner:" $owner
write-host "Device Name:" $deviceName

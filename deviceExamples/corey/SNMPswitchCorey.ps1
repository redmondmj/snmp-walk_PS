#Setting up known OIDs for Kyrocera Printers
$oidManufacturer = "1.3.6.1.2.1.1.1"
$oidModel = "1.3.6.1.4.1.1347.43.5.1.1.36"
$oidSerial = "1.3.6.1.4.1.1347.43.5.1.1.28"
$oidName = "1.3.6.1.4.1.1347.40.10.1.1.5"

#my modifications
$freememory = "1.3.6.1.4.1.674.10895.5000.2.6132.1.1.1.1.4.1"
$totalmemory = "1.3.6.1.4.1.674.10895.5000.2.6132.1.1.1.1.4.2"
$CPUuse = "1.3.6.1.4.1.674.10895.5000.2.6132.1.1.1.1.4.3"
#$tonerpercent = $tonercapacity / $tonerlevel
$temp = "1.3.6.1.4.1.674.10895.5000.2.6132.1.1.43.1.8.1.2"

#switch
#Invoke-SnmpWalk -IP 172.16.144.251 -Community EntMan

do { #Input validation for IP
    Clear-Host
    #draw header
    write-host ""
    write-host "********************************"
    write-host "**      SNMP DEll switch      **"
    write-host "**                            **"
    write-host "**   SNSMP Package Required   **"
    write-host "**       Try Proxx SNMP       **"
    write-host "********************************"
    
    write-host ""
    get input from user
    $IP = read-host "Enter IP"
    #$IP = "172.16.144.251"
    regex for checking ip
    $Octet = '(?:0?0?[0-9]|0?[1-9][0-9]|1[0-9]{2}|2[0-5][0-5]|2[0-4][0-9])'
    [regex] $IPv4Regex = "^(?:$Octet\.){3}$Octet$"
    
    #if the ip is ok continue, otherwise notify the user
    $ok = $IP -match $IPv4Regex
    if ( -not $ok) {
        write-host  -ForegroundColor Red "Invalid IP"
        start-sleep 2
        write-host ""
    }
} until ($ok) #verified IP input
    
do { 
    #show snmp menu
    do {
        Clear-Host
        #draw header
        write-host ""
        write-host "******************************"
        write-host "**       SNMP Walker        **"
        write-host "******************************"
        write-host ""

        write-host "1 - Switch Manufacturer"
        write-host "2 - Switch Model"
        write-host "3 - Switch Serial"
        write-host "4 - free memory"
        write-host "5 - total memory"
        write-host "6 - CPU use"
        write-host "7 - temp"
        write-host ""
        write-host "8 - Errors"
        write-host ""
        write-host "9 - Exit"

        write-host ""
        #get input from user
        $answer = read-host "Choose all data you would like to collect"

        $ok = $answer -match '[123456789]+$'
        #if the provided answer is not numeric 1-9 notify user and return to menu
        if ( -not $ok) {
            write-host  -ForegroundColor Red "Invalid selection"
            Start-Sleep 2
            write-host ""
        }
    } until ($ok) #verified $answer
        
    #Compare $answer to the following cases and execute the associated command.
    switch -Regex ( $answer ) {
    "1" {invoke-snmpwalk -IP $IP -OID $oidManufacturer | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "2" {invoke-snmpwalk -IP $IP -OID $oidModel | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "3" {invoke-snmpwalk -IP $IP -OID $oidSerial | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "4" {invoke-snmpwalk -IP $IP -OID $freememory | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "5" {invoke-snmpwalk -IP $IP -OID $totalmemory | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "6" {invoke-snmpwalk -IP $IP -OID $CPUuse | Out-File -FilePath ".\SwitchData-$IP.txt" -Append        }
    "7" {invoke-snmpwalk -IP $IP -OID $temp  | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "8" {write-output "HUH? Does not compute... Coming Soon" | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    } #finished executing menu options

} until ($answer -eq 9) #User selected option 9 to exit.
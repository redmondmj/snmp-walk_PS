#Invoke-SnmpWalk 172.16.144.251 -Community EntMan
param([string]$IP="172.16.144.251")
$oidManufacturer = "1.3.6.1.2.1.1.1.0"
$oidName = "1.3.6.1.2.1.1.5.0"
$oidLocation = "1.3.6.1.2.1.1.6.0"
$oidUpTime = "1.3.6.1.2.1.1.3.0"
$oidOwner = "1.3.6.1.2.1.1.4.0"

    write-host ""
    write-host "********************************"
    write-host "**         Set Target         **"
    write-host "**                            **"
    write-host "**   SNSMP Package Required   **"
    write-host "**       Try Proxx SNMP       **"
    write-host "********************************"
    
    write-host ""
    #get input from user
    $IP = read-host "Enter IP"
    
    #regex for checking ip
    $Octet = '(?:0?0?[0-9]|0?[1-9][0-9]|1[0-9]{2}|2[0-5][0-5]|2[0-4][0-9])'
    [regex] $IPv4Regex = "^(?:$Octet\.){3}$Octet$"
    
    #if the ip is ok continue, otherwise notify the user
    $ok = $IP -match $IPv4Regex
    if ( -not $ok) {
        write-host  -ForegroundColor Red "Invalid IP"
        sleep 2
        write-host ""
    }
 until ($ok) #verified IP input
    
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
        write-host "1 - Switch Owner"
        write-host "2 - Switch Manufacturer and Model"
        write-host "3 - Switch Name"
        write-host "4 - Switch Uptime"
        write-host "5 - Switch Name "
        write-host ""
        write-host "6 - Exit"

        write-host ""
        #get input from user
        $answer = read-host "Choose all data you would like to collect"

        $ok = $answer -match '[123456]+$'
        #if the provided answer is not numeric 1-9 notify user and return to menu
        if ( -not $ok) {
            write-host  -ForegroundColor Red "Invalid selection"
            sleep 2
            write-host ""
        }
    } until ($ok) #verified $answer
        
    #Compare $answer to the following cases and execute the associated command.
    switch -Regex ( $answer ) {
    "1" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidOwner | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "2" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidManufacturer | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "3" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidName | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "4" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidUpTime | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "5" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidName | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    } #finished executing menu options

} until ($answer -eq 6) #User selected option 6 to exit.
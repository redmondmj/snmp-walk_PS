#Setting up known OIDs for Kyrocera Printers
$oidHostname
$oid


do { #Input validation for IP
    Clear-Host
    #draw header
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
        Start-Sleep 2
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

        write-host "1 - Printer Manufacturer"
        write-host "2 - Printer Model"
        write-host "3 - Printer Serial"
        write-host "4 - Exit"

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
    "1" {invoke-snmpwalk -IP $IP -OID $oidHostname | Out-File -FilePath "C:\Users\ryan_\Desktop\DeviceData-$IP.txt" -Append}
    "2" {invoke-snmpwalk -IP $IP -OID $oidModel | Out-File -FilePath "C:\Users\ryan_\Desktop\DeviceData-$IP.txt" -Append}
    "3" {invoke-snmpwalk -IP $IP -OID $oidSerial | Out-File -FilePath "C:\Users\ryan_\Desktop\DeviceData-$IP.txt" -Append}
    } #finished executing menu options

} until ($answer -eq 4) #User selected option 9 to exit.
       
    
       
    
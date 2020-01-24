#oids
$oiddescription = "1.3.6.1.2.1.1.1"
$oiduptime = "1.3.6.1.2.1.1.3"
$oidcontact = "1.3.6.1.2.1.1.4"
$oidLocation = "1.3.6.1.2.1.1.6"


do { #Input validation for IP
    Clear-Host
    #draw header
    write-host ""
    write-host "********************************"
    write-host "**                            **"
    write-host "**           Keyan's SNMP     **"
    write-host "**                            **"
    write-host "**                            **"
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

        write-host "1 - Printer uptime"
        write-host "2 - Printer description"
        write-host "3 - Printer contact information"
        write-host "4 - Printer location "
        write-host "5 - Exit "
      

        write-host ""
        #get input from user
        $answer = read-host "Choose all data you would like to collect"

        $ok = $answer -match '[12345]+$'
        #if the provided answer is not numeric 1-5 notify user and return to menu
        if ( -not $ok) {
            write-host  -ForegroundColor Red "Invalid selection"
            start_sleep 2
            write-host ""
        }
    } until ($ok) #verified $answer
        
    #Compare $answer to the following cases and execute the associated command.
    switch -Regex ( $answer ) {
    "1" {invoke-snmpwalk -IP $IP -OID $oiduptime | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "2" {invoke-snmpwalk -IP $IP -OID $oiddescription | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "3" {invoke-snmpwalk -IP $IP -OID $oidcontact | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "4" {invoke-snmpwalk -IP $IP -OID $oidlocation | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
   
    }

} until ($answer -eq 5) #User selected option 5 to exit.
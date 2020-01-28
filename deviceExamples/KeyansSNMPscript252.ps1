#oids
#$oidname = "1.3.6.1.4.1.1347.40.10.1.1.5"
$oiddescription = "1.3.6.1.2.1.1.1"
$oiduptime = "1.3.6.1.2.1.1.3"
$oidcontact = "1.3.6.1.2.1.1.4"
$oidLocation = "1.3.6.1.2.1.1.6"


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

        write-host "1 - Switch uptime"
        write-host "2 - Switch description"
        write-host "3 - Switch contact information"
      #  write-host "4 - Switch location "
        write-host '4 - Switch location '
        write-host "5 - Quit "
      

        write-host ""
        #get input from user
        $answer = read-host "Choose all data you would like to collect"

        $ok = $answer -match '[12345]+$'
        #if the provided answer is not numeric 1-9 notify user and return to menu
        if ( -not $ok) {
            write-host  -ForegroundColor Red "Invalid selection"
            start_sleep 2
            write-host ""
        }
    } until ($ok) #verified $answer
        
    #Compare $answer to the following cases and execute the associated command.
    switch -Regex ( $answer ) {
    "1" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oiduptime | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "2" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oiddescription | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "3" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidcontact | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
    "4" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidlocation| Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
   # "5" {invoke-snmpwalk -Community EntMan -IP $IP -OID $oidname | Out-File -FilePath ".\SwitchData-$IP.txt" -Append}
   
    }

} until ($answer -eq 5) #User selected option 9 to exit.
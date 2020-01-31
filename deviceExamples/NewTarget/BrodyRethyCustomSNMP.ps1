#oid of switch
$oidLocation = "1.3.6.1.2.1.1.6.6"
$oidUptime = "1.3.6.1.2.1.1.3"
$oidName = "1.3.6.1.2.1.1.5"

#IP of switch
$IP = "172.16.144.251"

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

        write-host "1 - Switch Location"
        write-host "2 - Switch Uptime"
        write-host "3 - Switch Name"
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
            sleep 2
            write-host ""
        }
    } until ($ok) #verified $answer
        
    #Compare $answer to the following cases and execute the associated command.
    switch -Regex ( $answer ) {
    "1" {invoke-snmpwalk -IP $IP -OID $oidLocation | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "2" {invoke-snmpwalk -IP $IP -OID $oidUptime | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "3" {invoke-snmpwalk -IP $IP -OID $oidName | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "8" {invoke-snmpwalk -IP $IP -OID $oidError | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    } #finished executing menu options

} until ($answer -eq 9) #User selected option 9 to exit.

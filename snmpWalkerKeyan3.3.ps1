param([string]$ip="172.16.144.125")



$oidToner = "1.3.6.1.2.1.43.11.1.1.9.1.1"



function tonerLevel {

    param (

        $oidToner

    )

    $toner = Get-SnmpData -IP $ip -OID $oidToner

    $tonerData = $toner."Data"

    $tonerLevel = 100 * $tonerData/20000

    return $tonerLevel

}



$output = tonerLevel($oidToner)
#Setting up known OIDs for Kyrocera Printers
$oidManufacturer = "1.3.6.1.2.1.1.1"
$oidModel = "1.3.6.1.4.1.1347.43.5.1.1.36"
$oidSerial = "1.3.6.1.4.1.1347.43.5.1.1.28"
$oidName = "1.3.6.1.4.1.1347.40.10.1.1.5"
$oidPrinter = "1.3.6.1.2.1.1.7"
$oidToner = "1.3.6.1.2.1.43.11.1.1.9.1.1 "
$oidPages = "1.3.6.1.4.1.1347.43.10.1.1.12.1"
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

        write-host "1 - Printer Manufacturer"
        write-host "2 - Printer Model"
        write-host "3 - Printer Serial"
        write-host "4 - Printer Name"
        write-host "5 - Printer "
        write-host "6 - Toner Level"
        write-host "7 - Location"
        write-host ""
        write-host "8 - Page Count"
        write-host ""
        write-host "9 - Exit"

        write-host ""
        #get input from user
        $answer = read-host "Choose all data you would like to collect"

        $ok = $answer -match '[123456789]+$'
        #if the provided answer is not numeric 1-9 notify user and return to menu
        if ( -not $ok) {
            write-host  -ForegroundColor Red "Invalid selection"
            start_sleep 2
            write-host ""
        }
    } until ($ok) #verified $answer

        
    #Compare $answer to the following cases and execute the associated command.
    switch -Regex ( $answer ) {
    "1" {invoke-snmpwalk -IP $IP -OID $oidManufacturer | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "2" {invoke-snmpwalk -IP $IP -OID $oidModel | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "3" {invoke-snmpwalk -IP $IP -OID $oidSerial | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "4" {invoke-snmpwalk -IP $IP -OID $oidName | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "5" {invoke-snmpwalk -IP $IP -OID $oidManufacturer | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "6" {Write-Output "Toner ink is at $output%." | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "7" {invoke-snmpwalk -IP $IP -OID $oidLocation | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    "8" {invoke-snmpwalk -IP $IP -OID $oidPages | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
    } #finished executing menu options

} until ($answer -eq 9) #User selected option 9 to exit.
       
    
       
    
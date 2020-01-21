
do {
    cls
    write-host ""
    write-host "****************************"
    write-host "**       Set Target       **"
    write-host "**                        **"
    write-host "** SNSMP Package Required **"
    write-host "****************************"
    
    
    
    write-host ""
    $IP = read-host "Enter IP"
        
    $Octet = '(?:0?0?[0-9]|0?[1-9][0-9]|1[0-9]{2}|2[0-5][0-5]|2[0-4][0-9])'
    [regex] $IPv4Regex = "^(?:$Octet\.){3}$Octet$"
    
    $ok = $IP -match $IPv4Regex
    if ( -not $ok) {write-host  -ForegroundColor Red "Invalid IP"
                    sleep 2
                    write-host ""
                    }
    } until ($ok)
    
    do {
    
        do {
            cls
            write-host ""
            write-host "****************************"
            write-host "**       SNMP Walker        **"
            write-host "****************************"
            write-host "** Requires an SNMP "
    
            write-host "1 - Printer Manufacturer"
            write-host "2 - Printer Model"
            write-host "3 - Printer Serial"
            write-host "4 - Printer Manager"
            write-host "5 - Printer Location"
            write-host "6 - Toner Level"
            write-host "7 - Page Count"
            write-host ""
            write-host "8 - Errors"
            write-host ""
            write-host "9 - Exit"
    
            write-host ""
            $answer = read-host "Select number(s)"
    
            $ok = $answer -match '[123456789]+$'
            if ( -not $ok) {write-host  -ForegroundColor Red "Invalid selection"
                            sleep 2
                            write-host ""
                            }
            } until ($ok)
        
            switch -Regex ( $answer ) {
            "1" {invoke-snmpwalk -IP 172.16.144.125 -OID 1.3.6.1.2.1.1.1 | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
            "2" {invoke-snmpwalk -IP 172.16.144.125 -OID 1.3.6.1.4.1.1347.43.5.1.1.1 | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
            "3" {invoke-snmpwalk -IP 172.16.144.125 -OID 1.3.6.1.4.1.1347.43.5.1.1.28.1 | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
            "4" {write-output Comming Soon}
            "5" {invoke-snmpwalk -IP 172.16.144.125 -OID 1.3.6.1.4.1.1347.43.20.7.1.5 | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
            "6" {invoke-snmpwalk -IP 172.16.144.125 -OID 1.3.6.1.4.1.1347.43.5.1.1.28.1 | Out-File -FilePath ".\PrinterData-$IP.txt" -Append}
            "7" {write-output Comming Soon}
            "8" {write-output Comming Soon}
         }
    
    } until ($answer -eq 9)
       
    
       
    
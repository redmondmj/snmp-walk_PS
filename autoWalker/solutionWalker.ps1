# Did you know you could define parameters that can passed to you script when you execute it?
param([string]$ip="172.16.144.125") #Must be the first statement in your script
# now you can run the script and specify an IP like this:
# powershell.exe -file autoWalker.ps1 -IP 10.0.0.1

#Confirm target IP Address.
Write-Host "Alright, you gave me the IP:"
Write-Host $ip
Write-Host "Cancel or Allow?"
start-sleep 2

#set up hashtable of OID names and values.
$oid = @{
    Man="1.3.6.1.2.1.1.1"; 
    Model="1.3.6.1.4.1.1347.43.5.1.1.36"; 
    Serial="1.3.6.1.4.1.1347.43.5.1.1.28"; 
    Name="1.3.6.1.4.1.1347.40.10.1.1.5";
}

#Iterate through hashtable for each oid and run command.
foreach($key in $oid.Keys) {
    Write-host "Here we go... let's try getting the $key with $($oid[$key])"
    Invoke-SnmpWalk -IP $ip -OID $oid[$key] | Out-File -FilePath ".\PrinterData-$ip.txt" -Append
    Write-host "Done."
}

exit
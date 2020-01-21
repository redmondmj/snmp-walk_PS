# Did you know you could define parameters that can passed to you script when you execute it?
param([string]$ip="172.16.144.125") #Must be the first statement in your script
param([datetime]$time)

# now you can run the script and specify an IP like this:
# powershell.exe -file autoWalker.ps1 -IP 10.0.0.1
Write-Host "Executing script for target:"
Write-Host $ip
start-sleep 2
exit

#You can also use PS to create a scheduled task


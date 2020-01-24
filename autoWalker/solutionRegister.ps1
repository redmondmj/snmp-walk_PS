# Did you know you could define parameters that can passed to you script when you execute it?
param([string]$ip="172.16.144.125") #Must be the first statement in your script
# now you can run the script and specify an IP like this:
# powershell.exe -file autoWalker.ps1 -IP 10.0.0.1

#Confirm target IP
Write-Host "Adding scheduled task for:"
Write-Host $ip
start-sleep 2

#Build command arguments including provided IP
$argument = "-NonInteractive -NoLogo -NoProfile -File `"C:\Users\Matt\Documents\GitHub\snmp-walk_PS\autoWalker\solutionWalker.ps1`" -IP $ip"

#set the action for the new scheduled task
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "$argument"
#when should the task execute
$trigger =  New-ScheduledTaskTrigger -Daily -At 1am

#Finally, create the task.
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "PrinterLog-$ip" -Description "SNMP Printer Log Daily - $ip"
#You may wish to include  -User 'username' -Password 'passhere'
exit


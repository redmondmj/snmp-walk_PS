#used to use the inputed Ip address
param([string]$ip="172.16.144.251")

#the path and program to lanuch in order to use the script
$task = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-File "C:\Users\erich\Downloads\snmp-walk_PS\deviceExamples\SNMPswitchex\SWITCHinfo.ps1"'

#take is set to trigger at 12AM daily
$trigger = New-ScheduledTasktrigger -Daily -At 12AM
#making the tas show up in task scheduler and assignging the task with an action.
Register-ScheduledTask -Action $task -Trigger $trigger -TaskName "SNMPTest" -Description "Automateing SNMP Script"  
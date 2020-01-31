#ip of switch given as parameter
param([string]$ip="172.16.144.251")

#creating action to execute powershell, and then run the selected custom snmp powershell script
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-File "C:\Users\ryan_\Documents\GitHub\snmp-walk_PS\deviceExamples\NewTarget\RyanSCustomSNMP.ps1"'
#set task to trigger daily at 3pm
$trigger = New-ScheduledTaskTrigger -Daily -At 3PM
#registering the task as well as asssigning the trigger and action to the task. Adding a name and description to task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "SNMPAutoTest" -Description "Automated SNMP Script"    
   
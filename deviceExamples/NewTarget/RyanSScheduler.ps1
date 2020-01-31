param([string]$ip="172.16.144.251")
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-File "C:\Users\ryan_\Documents\GitHub\snmp-walk_PS\deviceExamples\NewTarget\RyanSCustomSNMP.ps1"'


$trigger = New-ScheduledTaskTrigger -Daily -At 2:10PM
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "SNMPAutoTest" -Description "Automated SNMP Script"    
   
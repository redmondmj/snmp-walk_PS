$start = New-ScheduledTaskAction -execute 'Powershell.exe' -argument "D:\brian\Documents\snmp-walk_PS\autoWalker\keyanSNMPscriptbeta.ps1"
$when = New-ScheduledTaskTrigger  -Daily -At 8am
Register-ScheduledTask -Action $start -Trigger $when -TaskName "Automation"

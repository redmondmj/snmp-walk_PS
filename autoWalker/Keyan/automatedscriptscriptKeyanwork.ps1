$start = New-ScheduledTaskAction -execute 'Powershell.exe' -argument ".\keyanscriptthatrunsautomatically.ps1"
$when = New-ScheduledTaskTrigger  -Daily -At 8am
Register-ScheduledTask -Action $start -Trigger $when -TaskName "Automation"

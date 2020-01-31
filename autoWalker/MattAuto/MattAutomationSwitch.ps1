$start = New-ScheduledTaskAction -execute 'Powershell.exe' -Argument ".\MatthewCassidySwitch.ps1"
$when = New-ScheduledTaskTrigger -Daily -At 8am
Register-ScheduledTask -Action $start -Trigger $when -TaskName "MattAutomationSwitch"
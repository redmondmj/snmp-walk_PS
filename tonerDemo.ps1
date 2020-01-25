param([string]$ip="172.16.144.125")

$oidToner = "1.3.6.1.2.1.43.11.1.1.9.1.1"

function tonerLevel {
    param (
        $oidToner
    )
    $toner = Get-SnmpData -IP $ip -OID $oidToner
    $tonerData = $toner."Data"
    $tonerLevel = 100 * $tonerData/20000
    return $tonerLevel
}

$output = tonerLevel($oidToner)

Write-Host "The current toner level for the printer is $output%."
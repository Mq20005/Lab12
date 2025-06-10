<#
    .SYNOPSIS
    Monitoruje logi OpenSSH/Operational i generuje raport o nieudanych logowaniach SSH.

    .DESCRIPTION
    Skrypt pobiera zdarzenia z dziennika OpenSSH/Operational, wykrywa nieudane próby logowania
    (np. "Failed password") i generuje raport w konsoli oraz opcjonalnie do pliku CSV.

    .PARAMETER LookBackMinutes
    Określa, jak daleko wstecz (w minutach) analizowane są zdarzenia z logu.

    .EXAMPLE
    PS> .\Monitor_SSH_Logins.ps1 -LookBackMinutes 120
#>

param(
    [Parameter(Mandatory=$true)]
    [int]$LookBackMinutes
)

$Events = Get-WinEvent -LogName "OpenSSH/Operational" -ErrorAction SilentlyContinue |
    Where-Object { $_.TimeCreated -gt (Get-Date).AddMinutes(-$LookBackMinutes) }

$FailedLogins = $Events | Where-Object { $_.Message -match "Failed password" }

if ($FailedLogins.Count -gt 0) {
    Write-Host "`n==== RAPORT: Nieudane logowania (ostatnie $LookBackMinutes min) ====" -ForegroundColor Red

    foreach ($event in $FailedLogins) {
        Write-Host ("{0} | {1} | {2}" -f $event.TimeCreated, $event.Id, $event.Message)
    }

    # Zapis do pliku CSV
    $OutputDir = "C:\Raporty"
    if (-not (Test-Path $OutputDir)) {
        New-Item -Path $OutputDir -ItemType Directory | Out-Null
    }

    $FailedLogins | Select-Object TimeCreated, Id, Message |
        Export-Csv -Path "$OutputDir\Raport_FailedLogins.csv" -NoTypeInformation -Encoding UTF8

    Write-Host "`nRaport zapisany do $OutputDir\Raport_FailedLogins.csv" -ForegroundColor Green
} else {
    Write-Host "`nBrak nieudanych logowań w ostatnich $LookBackMinutes min." -ForegroundColor Cyan
}

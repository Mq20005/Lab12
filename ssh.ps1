<#
    .SYNOPSIS
    Laczenie sie z danym serwerem poprzez ssh

    .DESCRIPTION
    Skrypt laczy sie z danym serwerem przez ssh, loguje sie na konto i wykonuje parę czynnosci

    .PARAMETER hostname
    Adres ip lub nazwa serwera na, ktory program bedzie sie logowal

    .PARAMETER username
    Nazwa uzytkownika na serwerze na ktorym sie logujemy

    .PARAMETER path
    Sciezka do pliku w ktorym zapisywane beda dane otrzymane z serwera

    .EXAMPLE
    PS> .\ssh.ps1 "hostname.net" "uzytkownik" "C:\users\gosc\plik.txt"
#>

param(
    [String] $hostname,
    [String] $username,
    [String] $path
)

$password = Read-Host "Podaj haslo do konta $username : " -AsSecureString
$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

Import-Module Posh-SSH

$session = New-SSHSession -ComputerName $hostname -Credential $credential
$commands = @("ls -l", "pwd", "whoami")
$output = @()

foreach($command in $commands) {
    $response = Invoke-SSHCommand -SessionId $session.SessionId -Command $command
    $output += " >> $command`n"
    $output += $response.Output
    $output += "`n"
}

$output | Out-File -Filepath $path

Remove-SSHSession -SessionId $session.SessionId
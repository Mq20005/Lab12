<#
    .SYNOPSIS
    Tworzy kopię zapasową wybranych plików i przesyła ją na serwer FTP.

    ,Description
    Archiwizuje i kompresuje okreslone pliki, a nastepnie robi ich kopie zapasowa i przesyla na serwer poprzez FTP

    .PARAMETER SourcePath
    Ścieżka do katalogu z plikami do backupu.

    .PARAMETER BackupPath
    Ścieżka do lokalnego pliku ZIP (backup).

    .PARAMETER FtpServer
    Adres serwera FTP.

    .PARAMETER FtpUsername
    Nazwa użytkownika FTP.

    .PARAMETER FtpPassword
    Hasło do konta FTP.

    .PARAMETER FtpTargetDir
    Katalog docelowy na serwerze FTP.

    .EXAMPLE
    PS> .\backup_ftp.ps1 "sciezka/pliow/do/backupu" "sciezka/do/miejsca/backupu" "adres.serwera.ftp" "nazwa_urzytkownika" "haslo _do_konta" "folder na ftp"
#>

param(
    [string]$SourcePath,
    [string]$BackupPath,
    [string]$FtpServer,
    [string]$FtpUsername,
    [string]$FtpPassword,
    [string]$FtpTargetDir
)

Write-Host "Kompresowanie plików z $SourcePath do $BackupPath"
Compress-Archive -Path "$SourcePath\*" -DestinationPath $BackupPath -Force
Write-Host "Kompresja zakończona."

$ftpUri = "ftp://$FtpServer/$FtpTargetDir/$(Split-Path $BackupPath -Leaf)"
Write-Host "Wysyłanie $BackupPath na $ftpUri ..."

$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($FtpUsername, $FtpPassword)

$webclient.UploadFile($ftpUri, "STOR", $BackupPath)

Write-Host "Backup przesłany pomyślnie."

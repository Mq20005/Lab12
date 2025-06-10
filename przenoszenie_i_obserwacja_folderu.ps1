<#
    .SYNOPSIS
    monitoruje dany folder

    .DESCRIPTION
    przenosi nowo dodane pliki .txt z folderu obserwowanego do folderu docelowego

    .PARAMETER watched
    sciezka folderu obserwowanego

    .PARAMETER target
    sciezka folderu docelowego

    .EXAMPLE
    PS> .\Lab7.ps1 "C:\watched\path" "C:\target\path"
#>

param (
    [String] $watched,
    [String] $target
)

if ( -not (Test-Path -Path $target)) {
    New-Item -ItemType Directory -Path $target
    Write-Host "Utworzono folder docelowy $target"
} 

while ($true) {
    $pliki = Get-ChildItem -Path $watched -Filter *.txt -Name
    foreach ($plik in $pliki) {
        $sciezka = Join-Path -Path $watched -ChildPath $plik
        Move-Item $sciezka $target
    }
    Start-Sleep 10
}
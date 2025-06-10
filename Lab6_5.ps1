$Env:NAZWA = "Lenovo"

Function Date {
  $aktualna_data = Get-Date
  Write-Host "Aktualna data na komputerze $Env:NAZWA to $aktualna_data."
} #Wyswietlanie obecnej daty

Function Version {
$name = Get-ComputerInfo | Select-Object -ExpandProperty OsName
$wersja = Get-ComputerInfo | Select-Object -ExpandProperty OsVersion
Write-Host "Aktualna wersja systemu na komputerze $Env:NAZWA to $name $wersja."
} #Wyswietlanie obecnej wersji systemu

Function User {
Write-Host "Nazwa uzytkownika aktualnie korzystajacego z komputera $Env:NAZWA to $Env:USERNAME"
} #Wystwieltanie uzytkownika

function IP {
    $adresy = Get-NetIPAddress -AddressFamily IPv4 |
              Where-Object { $_.IPAddress -ne "127.0.0.1" -and $_.IPAddress -ne "::1" } |
              Select-Object -ExpandProperty IPAddress

    Write-Host "Twój adres IP:"
    foreach ($ip in $adresy) {
        Write-Host $ip
    }
}


Date
Version
User
IP
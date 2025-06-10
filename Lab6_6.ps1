# Wczytaj plik CSV z separatorem ;
$inputData = Import-Csv -Path ".\input_file.csv" -Delimiter ";"

# Pobierz wszystkie informacje z systemu
$info = Get-ComputerInfo

# Mapowanie nazw z pliku do w�a�ciwo�ci systemowych
$mapowanie = @{
    "Computername"   = $env:COMPUTERNAME
    "Manufacturer"   = $info.CsManufacturer
    "Model"          = $info.CsModel
    "SerialNumber"   = $info.BiosSeralNumber
    "CpuName"        = $info.CsProcessors[0].Name
    "RAM"            = ([math]::Round($info.CsTotalPhysicalMemory / 1GB)).ToString() + " GB"
}

# Przejd� przez ka�dy wiersz i wypisz tylko te z GenerateReport = True
foreach ($wiersz in $inputData) {
    if ($wiersz.GenerateReport -eq "True" -and $mapowanie.ContainsKey($wiersz.Component)) {
        Write-Host "$($wiersz.Component): $($mapowanie[$wiersz.Component])"
    }
}

<#
.SYNOPSIS
Wyszukuje dane o adresie IP z użyciem darmowego API Shodan.

.DESCRIPTION
Skrypt korzysta z endpointu `host/search`, który działa na darmowych kontach Shodan.
Wyszukuje informacje o wskazanym adresie IP – jeśli Shodan posiada otwarte dane.

.PARAMETER ip
Adres IP do wyszukania (np. 8.8.8.8).

.PARAMETER apikey
Twój klucz API z konta Shodan.

.EXAMPLE
.\api_shodan.ps1 -ip "8.8.8.8" -apikey "TWÓJ_KLUCZ_API"
#>

param (
    [string]$ip,
    [string]$apikey
)

if (-not $ip) {
    $ip = Read-Host "Podaj adres IP"
}

if (-not $apikey) {
    $apikey = Read-Host "Podaj swój klucz API Shodan"
}

$url = "https://api.shodan.io/shodan/host/$($ip)?key=$($apikey)"

try {
    $response = Invoke-RestMethod -Uri $url

    Write-Host "Wyniki dla IP ${ip}:"

    Write-Host "IP: $($response.ip_str)"
    Write-Host "Organizacja: $($response.org)"
    Write-Host "Host: $($response.hostnames -join ', ')"
    Write-Host "Lokalizacja: $($response.city), $($response.country_name)"
    Write-Host "Otwarte porty:"

    foreach ($port in $response.ports) {
        Write-Host " - Port: $port"
    }

} catch {
    Write-Host "Błąd: Nie udało się pobrać danych z Shodan."
    Write-Host $_.Exception.Message
}


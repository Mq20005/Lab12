<#
.SYNOPSIS
Pobiera kurs waluty z ostatnich 5 dni

.DESCRIPTION
Skrypt pobiera aktualny kurs waluty (np. EUR, USD, CHF) z API NBP oraz różnice kursowe między kolejnymi dniami.

.PARAMETER currency
Kod waluty do sprawdzenia (np. "EUR", "USD", "CHF")

.EXAMPLE
.\Waluty.ps1 "USD"
#>

param (
    [string]$currency
)

$currency = $currency.ToLower()
$apiUrl = "http://api.nbp.pl/api/exchangerates/rates/A/$currency/last/5/?format=json"

try {
    $response = Invoke-RestMethod -Uri $apiUrl

    Write-Host "Kursy z ostatnich 5 dni dla waluty '$currency' względem PLN:"

    $previous = $null
    foreach ($rate in $response.rates) {
        $date = $rate.effectiveDate
        $value = $rate.mid
        Write-Host "$date : $value zł"

        if ($previous -ne $null) {
            $diff = [math]::Round($value - $previous, 4)
            Write-Host "  Różnica względem poprzedniego dnia: $diff"
        }

        $previous = $value
    }
}
catch {
    Write-Host "Błąd: Nie udało się pobrać danych."
}


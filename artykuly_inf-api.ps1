<#
.SYNOPSIS
Wyszukuje artykuły informacyjne na podany temat.

.DESCRIPTION
Łączy się z serwisem NewsData.io i pobiera listę najnowszych artykułów dotyczących tematu podanego przez użytkownika.

.PARAMETER topic
Temat, na który mają być wyszukane artykuły.

.PARAMETER apikey
Klucz API z portalu NewsData.io.

.EXAMPLE
.\artykuly_inf.ps1 "cyberbezpieczeństwo" "TWÓJ_KLUCZ_API"
#>

param (
    [string]$topic,
    [string]$apikey
)

if (-not $topic) {
    $topic = Read-Host "Podaj temat do wyszukania"
}

if (-not $apikey) {
    $apikey = Read-Host "Podaj swój klucz API z NewsData.io"
}

$url = "https://newsdata.io/api/1/news?apikey=$apikey&q=$topic&language=pl"

try {
    $response = Invoke-RestMethod -Uri $url

    Write-Host "Znalezione artykuły na temat: $topic"
    foreach ($article in $response.results) {
        Write-Host "$($article.title)"
        Write-Host "Data: $($article.pubDate)"
        Write-Host "Link: $($article.link)"
    }
}
catch {
    Write-Host "Błąd podczas pobierania danych."
}

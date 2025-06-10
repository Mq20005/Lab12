<# 
    .SYNOPSIS
    sprawdza czy plik jest bezpieczny

    .DESCRIPTION
    wysyla zapytanie do virustotal i sprawdza, czy plik jest oznaczony jako niebezpieczny

    .PARAMETER file
    sciezka do pliku ktory chcemy sprawdzic

    .Parameter api
    klucz api virustotal

    .OUTPUTS
    odpowiedz czy plik jest bezpieczny

    .EXAMPLE
    PS> .\check-file.ps1 proba.txt klucz_api
#>

param (
    [String]$file,
    [String]$api
)

#suma kontrolna
function Get-Hash {
    (Get-FileHash -Path $file -Algorithm SHA256).Hash
}

#Zapytanie do virustotal
function Ask-Virustotal {
    $headers=@{}
    $headers.Add("accept", "application/json")
    $headers.Add("x-apikey", $api)
    $response = Invoke-RestMethod -Uri "https://www.virustotal.com/api/v3/files/$(Get-Hash)" -Method GET -Headers $headers
    return $response
}

#sprawdzenie wynikow
function Analyze-Results {
    $result = Ask-Virustotal
    $bad = $result.data.attributes.last_analysis_stats.malicious
    if($bad -gt 0) {
        Write-Host "Plik moze byc niebezpieczny"
    } else {
        Write-Host "Plik jest bezpieczny"
    }
}
Analyze-Results


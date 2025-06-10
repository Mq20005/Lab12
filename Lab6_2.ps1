#Sprawdzanie czy podana liczba jest wieksza niz 10
[int]$liczba = Read-Host -prompt "Podaj liczbe: "
if ($liczba -gt 10) {
 Write-Host "Liczba jest wieksza od 10"
 } elseif ($liczba -eq 10) {
 Write-Host "Liczba jest rowna 10"
 } else {
 Write-Host "Liczba jest mniejsza niz 10"
 }
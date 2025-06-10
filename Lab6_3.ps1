#Sprawdzanie poprawnosci wprowadzonej nazwy uzytkownika i hasla
$correctUsername = "admin"
$correctPassword = "password"
$username = Read-Host "Podaj nazwę użytkownika"
$passwordSecure = Read-Host "Podaj hasło" -AsSecureString
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordSecure)
)

if ($username -eq $correctUsername -and $password -eq $correctPassword) {
    Write-Host "Logowanie udane!" -ForegroundColor Green
} else {
    Write-Host "Błędna nazwa użytkownika lub hasło." -ForegroundColor Red
}


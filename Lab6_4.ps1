#Generowanie adresow IP petla
$ip = "192.168.1."
for($i=0; $i -le 9; $i++) {
Write-Host $ip$i
}

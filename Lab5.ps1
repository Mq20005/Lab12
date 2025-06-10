New-Item -Name "Nowyplik.txt" -ItemType File #Tworzenie nowgo pustego pliku
Rename-Item -Path "Nowyplik.txt" -NewName "Nowszyplik.txt" #Zmienianie nazwy stworzonego pliku
Get-FileHash -Path "Nowszyplik.txt" #Sprawdzanie hashu pliku (sumy kontrolnej)
notepad #Uruchamianie notatnika z poziomu powershella
Get-ChildItem -File | Sort-Object {$_.Name.Length} | Select-Object Name #Sortowanie plikow z domysnego katalogu po dlugosci ich nazwy
$lokalizacja = (pwd).Path #Zapisywanie obecnej lokalizacji o zmiennej
$lokalizacja >> "Nowszyplik.txt" #Wpisywanie informacji zapisanych w zmiennej do pliku
Get-Process | Select-Object -First 5 | Select-Object -Property ProcessName, Id #Wyswietlanie pierwszych 5 wierszy, tylko z kolumnami name i id
Get-Process | Sort-Object -Property WorkingSet -Descending | Select-Object -First 5 #Wyswietlanie 5 procesow z najwiekszym zuzyciem pamieci
Get-Process | Sort-Object -Property WorkingSet | Select-Object -First 5 ProcessName, @{Name = "MemoryUsage"; Expression = {$_.WorkingSet}} # 5 procesow 
#zuzywajacych najmniej pamieci, tylko kolumny nazwy i pamieci, zamienona nazwa kolumny z pamiecia
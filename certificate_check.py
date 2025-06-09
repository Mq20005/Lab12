from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA

plik = input("Podaj nazwę pliku do sprawdzenia: ")
klucz_publiczny_plik = input("Podaj nazwę pliku z kluczem publicznym: ")

with open(plik, "rb") as f:
    zawartosc = f.read()

hash_pliku = SHA256.new(zawartosc)

with open(plik + ".sig", "rb") as f:
    podpis = f.read()

with open(klucz_publiczny_plik, "rb") as f:
    klucz_publiczny = RSA.import_key(f.read())

try:
    pkcs1_15.new(klucz_publiczny).verify(hash_pliku, podpis)
    print("Podpis jest poprawny, plik nie został zmodyfikowany.")
except (ValueError, TypeError):
    print("Podpis nie jest poprawny, plik został zmieniony lub podpis nie pasuje.")

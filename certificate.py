from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA

klucz = RSA.generate(2048)

with open("klucz_prywatny.pem", "wb") as f:
    f.write(klucz.export_key())
print("Klucz prywatny zostal zapisany w pliku klucz_prywatny.pem")

with open("klucz_publiczny.pem", "wb") as f:
    f.write(klucz.publickey().export_key())
print("Klucz publiczny zostal zapisany w pliku klucz_publiczny.pem")

print("Wygenerowano nowa pare kluczy RSA")
plik = input("Podaj nazwę pliku do podpisania: ")

with open(plik, "rb") as f:
    zawartosc = f.read()
hash_pliku = SHA256.new(zawartosc)

with open("klucz_prywatny.pem", "rb") as f:
    klucz_prywatny = RSA.import_key(f.read())

podpis = pkcs1_15.new(klucz_prywatny).sign(hash_pliku)

with open(plik + ".sig", "wb") as f:
    f.write(podpis)

print(f"Plik '{plik}' został podpisany.")
print(f"Podpis zapisano w pliku: '{plik}.sig'")


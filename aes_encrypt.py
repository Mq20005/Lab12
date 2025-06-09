from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad

file = input("Podaj nazwe pliku, ktory chcesz zaszyfrowac: ")
encrypted_file = input("Podaj nazwe zaszyfrowanego pliku: ")
key = get_random_bytes(16)
iv = get_random_bytes(16)
with open(file, "rb") as f:
    data = f.read()

cipher = AES.new(key, AES.MODE_CBC, iv)
ciphertext = cipher.encrypt(pad(data, AES.block_size))

with open(encrypted_file, "wb") as f:
    f.write(iv+ciphertext)

print("\nZAPAMIETAJ TEN KLUCZ (hex): ", key.hex())
print("Plik zostal zaszyfrowanu i zapisany jako: ", encrypted_file)
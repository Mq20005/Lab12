from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from binascii import unhexlify

encrypted= input("Podaj nazwę pliku zaszyfrowanego: ")
decrypted = input("Podaj nazwę pliku odszyfrowanego: ")
key_hex = input("Podaj klucz (hex) użyty przy szyfrowaniu: ")
key = unhexlify(key_hex)

with open(encrypted, "rb") as f:
    iv = f.read(16)
    ciphertext = f.read()

cipher = AES.new(key, AES.MODE_CBC, iv)
plaintext = unpad(cipher.decrypt(ciphertext), AES.block_size)

with open(decrypted, "wb") as f:
    f.write(plaintext)

print("Plik został odszyfrowany i zapisany jako:", decrypted)

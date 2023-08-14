import requests
import mmh3
import base64
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Solicitar a URL do usuário
url = input("Digite a URL do ICON: ")

# Fazer a solicitação GET
response = requests.get(url)

# Verificar se a solicitação foi bem-sucedida
if response.status_code == 200:
    favicon = base64.encodebytes(response.content)
    hash_value = mmh3.hash(favicon)
    print("Hash MurmurHash3 do ícone de favoritos:", hash_value)
else:
    print("Não foi possível obter o ícone de favoritos da URL fornecida.")

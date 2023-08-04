import requests
from bs4 import BeautifulSoup

def get_extension_title(extension_id):
    url = f"https://chrome.google.com/webstore/detail/{extension_id}"
    
    try:
        response = requests.get(url)
        if response.status_code == 200:
            soup = BeautifulSoup(response.content, 'html.parser')
            title = soup.title.string
            print(f"Título da extensão {extension_id}: {title}")
        else:
            print(f"Falha ao acessar a URL da extensão {extension_id}. Código de resposta: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Erro ao acessar a URL da extensão {extension_id}: {e}")

# Ler os IDs das extensões a partir do arquivo
with open("ids_extensoes.txt", "r") as file:
    lista_extensoes = [line.strip() for line in file]

for extensao_id in lista_extensoes:
    get_extension_title(extensao_id)

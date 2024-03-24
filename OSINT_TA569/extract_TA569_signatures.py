import re
import requests

# URL da página da web
url = "https://lawmaker.cloud/signatures.txt"

# Realiza o request para obter o conteúdo da página
response = requests.get(url)
html_content = response.text

# Encontra todas as ocorrências de texto entre "||" usando expressões regulares
pattern = re.compile(r'\|\|(.*?)\|\|')

# Itera sobre as correspondências encontradas e verifica se contêm a string 'TA569'
matches = pattern.findall(html_content)
for match in matches:
    if 'TA569' in match:
        print(match.strip())  # Imprime o conteúdo encontrado entre "||"

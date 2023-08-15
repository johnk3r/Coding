import requests
import re
import time
from bs4 import BeautifulSoup

def get_vpn_provider(ip):
    request = requests.get('https://spur.us/context/{}'.format(ip))
    soup = BeautifulSoup(request.text, 'html.parser')

    for meta_tag in soup.find_all('meta'):
        search = re.search('(.*) \( (.*) \) IP Context', str(meta_tag.get('content')))
        if search:
            return search.group(2)

def main():
    input_file = input("[+] Nome do arquivo de IPs: ")

    try:
        with open(input_file, 'r') as file:
            ip_list = file.read().splitlines()
    except FileNotFoundError:
        print("Arquivo não encontrado.")
        return

    for ip in ip_list:
        result = get_vpn_provider(ip)
        if result:
            print('IP:', ip, '- Provider:', result)
        else:
            print('IP:', ip, '- Não foi possível determinar o provedor.')

        time.sleep(5)  # Atraso de 5 segundos

if __name__ == "__main__":
    main()

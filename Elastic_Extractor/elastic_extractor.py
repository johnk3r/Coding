from elasticsearch import Elasticsearch
import json

# Configuração do Elasticsearch com autenticação
es = Elasticsearch(
    ['<seu_host_elasticsearch>'],
    http_auth=('<seu_usuario>', '<sua_senha>'),
    scheme="https",
    port=443
)

# Consulta para recuperar documentos do Elasticsearch
query = {
    "query": {
        "match_all": {}
    }
}

# Recuperar documentos do Elasticsearch
result = es.search(index='<seu_índice_elasticsearch>', body=query)

# Nome do arquivo para salvar os documentos
output_file = 'documents.json'

# Salvar documentos em um arquivo JSON
with open(output_file, 'w') as f:
    json.dump(result['hits']['hits'], f)

print("Documentos salvos com sucesso em", output_file)

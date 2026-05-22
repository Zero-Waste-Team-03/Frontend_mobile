import json

try:
    with open('schema.json', 'r', encoding='utf-16') as f:
        d = json.load(f)
except Exception:
    with open('schema.json', 'r', encoding='utf-8') as f:
        d = json.load(f)

types = d['data']['__schema']['types']
query_type = [x for x in types if x['name'] == 'Query'][0]
donations_field = [f for f in query_type['fields'] if f['name'] == 'donations'][0]

print("--- Query.donations Arguments ---")
for arg in donations_field['args']:
    print(arg['name'], arg['type'])

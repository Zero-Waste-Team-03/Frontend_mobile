import urllib.request, json
query = '{ __schema { types { name inputFields { name type { name kind ofType { name kind } } } } } }'
req = urllib.request.Request('https://api.gaspzero.qzz.io/graphql', data=json.dumps({'query': query}).encode('utf-8'), headers={'Content-Type': 'application/json'})
res = json.loads(urllib.request.urlopen(req).read().decode('utf-8'))
for t in res['data']['__schema']['types']:
    if t['name'] == 'LocationInput':
        print('=== LocationInput ===')
        for f in t.get('inputFields', []):
            print(f"Input: {f['name']} -> {f['type']}")

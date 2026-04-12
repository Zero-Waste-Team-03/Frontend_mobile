import urllib.request, json
query = '{ __schema { types { name kind inputFields { name type { name kind ofType { name kind ofType { name kind } } } } } } }'
req = urllib.request.Request('https://api.gaspzero.qzz.io/graphql', data=json.dumps({'query': query}).encode('utf-8'), headers={'Content-Type': 'application/json'})
res = json.loads(urllib.request.urlopen(req).read().decode('utf-8'))
types = res['data']['__schema']['types']
for t in types:
    if t['name'] == 'DonationBehaviorContextInput':
        print('=== DonationBehaviorContextInput ===')
        for f in t['inputFields']:
            print(f"Input: {f['name']} -> {f['type']}")

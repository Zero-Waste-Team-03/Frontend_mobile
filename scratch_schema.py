import urllib.request
import json
import sys

url = "https://api.gaspzero.qzz.io/graphql"

query = """
  query IntrospectionQuery {
    __schema {
      types {
        kind
        name
        inputFields {
          name
          type {
            name
            kind
            ofType {
              name
              kind
              ofType {
                 name
                 kind
                 ofType { name kind }
              }
            }
          }
        }
        fields {
          name
          args {
            name
            type {
              name
              kind
              ofType {
                name
                kind
                ofType { name kind }
              }
            }
          }
          type {
            name
            kind
            ofType {
              name
              kind
              ofType { name kind }
            }
          }
        }
      }
    }
  }
"""

req = urllib.request.Request(url, data=json.dumps({'query': query}).encode('utf-8'), headers={'Content-Type': 'application/json'})
try:
    response = urllib.request.urlopen(req)
    res = json.loads(response.read().decode('utf-8'))
    types = res['data']['__schema']['types']
    
    interesting = ['CreateDonationInput', 'DonationsFilterInput', 'Mutation', 'Query', 'Donation']
    for t in types:
        if t['name'] in interesting:
            print(f"=== {t['name']} ===")
            if t.get('inputFields'):
                for f in t['inputFields']:
                    print(f"Input: {f['name']} -> {f['type']}")
            if t.get('fields'):
                for f in t['fields']:
                    if t['name'] in ['Mutation', 'Query'] and f['name'] not in ['createDonation', 'donations', 'refreshTokens']:
                        continue
                    print(f"Field: {f['name']} -> {f['type']}")
                    if f.get('args'):
                        for a in f['args']:
                            print(f"  Arg: {a['name']} -> {a['type']}")
except Exception as e:
    print("Error:", e)

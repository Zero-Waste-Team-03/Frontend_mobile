import urllib.request, json
url = 'https://api.gaspzero.qzz.io/graphql'
query = '''query GetDonations($pagination: PaginationInput, $filter: DonationsFilterInput, $behaviorContext: DonationBehaviorContextInput) {
    donations(pagination: $pagination, filter: $filter, behaviorContext: $behaviorContext) {
        items { id }
    }
}'''
variables = {
    'behaviorContext': {
        'origin': '36.7201600, 3.1819600'
    }
}
req = urllib.request.Request(url, data=json.dumps({'query': query, 'variables': variables}).encode('utf-8'), headers={'Content-Type': 'application/json'})
try:
    res = urllib.request.urlopen(req)
    print(res.read().decode('utf-8'))
except Exception as e:
    import urllib.error
    if isinstance(e, urllib.error.HTTPError):
        print(e.read().decode('utf-8'))
    else:
        print(e)

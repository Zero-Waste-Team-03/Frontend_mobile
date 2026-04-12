import urllib.request, json
url = 'https://api.gaspzero.qzz.io/graphql'
query = '''query GetDonations($pagination: PaginationInput, $filter: DonationsFilterInput, $behaviorContext: DonationBehaviorContextInput) {
    donations(pagination: $pagination, filter: $filter, behaviorContext: $behaviorContext) {
        items { id }
    }
}'''
def make_req(bc):
    variables = {}
    if bc is not None: variables['behaviorContext'] = bc
    req = urllib.request.Request(url, data=json.dumps({'query': query, 'variables': variables}).encode('utf-8'), headers={'Content-Type': 'application/json'})
    try:
        res = urllib.request.urlopen(req)
        print('Success for', bc, res.read().decode('utf-8'))
    except Exception as e:
        import urllib.error as ue
        if isinstance(e, ue.HTTPError):
            print('Error for', bc, e.read().decode('utf-8'))
        else:
            print('Error for', bc, e)

make_req({'origin': '35.2061,-0.6424', 'distanceBucket': 'LOCAL'})
make_req({'origin': '35.206,-0.642'})
make_req({'distanceBucket': 'LOCAL'})
make_req(None)

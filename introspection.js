const https = require('https');
const data = JSON.stringify({ query: 'query { __type(name: \"Query\") { fields { name type { name kind ofType { name kind ofType { name kind ofType { name kind ofType { name kind } } } } } } } }' });
const options = { hostname: 'api.gaspzero.qzz.io', port: 443, path: '/graphql', method: 'POST', headers: { 'Content-Type': 'application/json', 'Content-Length': data.length } };
const req = https.request(options, (res) => {
  let body = '';
  res.on('data', (chunk) => body += chunk);
  res.on('end', () => {
    try {
        const parsed = JSON.parse(body);
        if (parsed.errors) console.log(JSON.stringify(parsed.errors, null, 2));
        const fields = parsed.data.__type.fields;
        console.log(JSON.stringify(fields.find(f => f.name === 'myActiveConversations'), null, 2));
    } catch(e) { console.log(body); }
  });
});
req.on('error', (e) => console.error(e));
req.write(data);
req.end();

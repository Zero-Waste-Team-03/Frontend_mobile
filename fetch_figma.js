const fs = require('fs');

async function fetchFigma() {
    try {
        const res = await fetch('https://api.figma.com/v1/files/8K144CSriRH1PQrYezkJVz/nodes?ids=849-2087', {
            headers: {
                'X-Figma-Token': process.env.FIGMA_TOKEN || 'YOUR_FIGMA_TOKEN'
            }
        });
        const data = await res.json();
        fs.writeFileSync('figma_data.json', JSON.stringify(data, null, 2));
        console.log('Success!', Object.keys(data));
    } catch(e) {
        console.error(e);
    }
}

fetchFigma();

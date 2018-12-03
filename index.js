const _ = require('lodash');
const fs = require('fs');
const moment = require('moment');
const express = require('express');
const exec = require('child_process').execSync;

const app = express();
const port = 3000;


// const config = JSON.parse(fs.readFileSync("./config.json"));
const config = {
    "scripts": {
        "start": "start.sh",
        "stop": "stop.sh",
    },
    "credentials": {
        
    },
    "jobs": {
        "user-front-end": {
            "branch": "master",
            "repo": "git@gitlab.com:buy-in-kannur/bik-user-app.git",
            "location": "user-front-end"
        }
    }
};

app.use(express.json());

app.get('/build', (req, res) => {
    res.send('OK');
    let ref = req.body.ref.replace(/(.*)\/(.*)/,"$2");
    let checkoutSha = req.body.checkout_sha;
    let url = req.body.repository.git_ssh_url;
    let job = _(config.jobs).find(o => o.repo === url);
    
    if(ref !== job.branch) 
        return;    

    exec(`/bin/bash ./scripts/deploy.sh ${url} ${checkoutSha} ${job.location}`)
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
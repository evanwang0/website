const fs = require("fs");
const tls = require("tls");
const https = require("https");
const express = require("express");

const rootTLSContext = tls.createSecureContext({
    key: fs.readFileSync(process.env["ROOT_TLS_KEY"]),
    cert: fs.readFileSync(process.env["ROOT_TLS_CERT"]),
});

const wwwTLSContext = tls.createSecureContext({
    key: fs.readFileSync(process.env["WWW_TLS_KEY"]),
    cert: fs.readFileSync(process.env["WWW_TLS_CERT"]),
});

const httpsOptions = {
    SNICallback: (domain, cb) => {
        if ("evanwang0.com" === domain)
            cb(null, rootTLSContext);
        else if ("www.evanwang0.com" === domain)
            cb(null, wwwTLSContext);
        else
            cb();
    }
}

const app = express();
app.use(express.static("public"));

https.createServer(httpsOptions, app).listen(8443);

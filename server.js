const fs = require("fs");
const https = require("https");
const express = require("express");

const httpsOptions = {
    key: fs.readFileSync(process.env["WEBSITE_TLS_KEY"]),
    cert: fs.readFileSync(process.env["WEBSITE_TLS_CERT"]),
};

const app = express();
app.use(express.static("public"));

https.createServer(httpsOptions, app).listen(8443);

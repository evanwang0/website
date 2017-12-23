const express = require("express");

const app = express();
app.disable('x-powered-by');
app.use(express.static("public"));
app.listen(8080);
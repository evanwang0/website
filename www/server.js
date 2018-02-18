const express = require("express");
const app = express();

app.disable('x-powered-by');
app.use(/^\/$/, (req, res, next) => res.redirect(302, "/index.html"));
app.use(express.static("public"));
app.listen(8080);
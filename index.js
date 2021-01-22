const express = require('express');

const app = express();
const routes = require('./src/routes');

const port = process.env.PORT || 3000;

app.use('', routes);

app.listen(port, () => {
    console.info(`Server listening on port ${port}`);
})

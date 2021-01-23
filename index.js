const express = require('express');
const bodyParser = require('body-parser');
// const mongoose = require('mongoose')

const app = express();
const routes = require('./src/routes');

app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(bodyParser.json());

app.use('', routes);

// mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });
// const db = mongoose.connection;
//
// db.on('error', err => console.error.bind(`\x1b[31m[ERROR]: Mongodb connection error: ${err}\x1b[0m`));
// db.on('open', () => console.info(`\x1b[34m[OK]: Mongodb has been connected succefully\x1b[0m`));

const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.info(`\x1b[34m[OK]: Server listening on port ${port}\x1b[0m`);
})

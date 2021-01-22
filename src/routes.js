const router = require('express').Router();

router.get('/', (req, res) => {
    res.json({
        status: 'Api Its Working',
    });
})

router.get('/liveness', (req, res) => {
    res.json('I\'m alive');
})

router.get('/readiness', (req, res) => {
    res.json();
})

module.exports = router;

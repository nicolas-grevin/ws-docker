const router = require('express').Router();

const userController = require('./controller/user');

router.get('/', (req, res) => {
    console.info('\x1b[33m[INFO]: Route "home" has been called\x1b[0m');
    res.json({
        status: 'Api Its Working',
    });
})

router.get('/liveness', (req, res) => {
    console.info('\x1b[33m[INFO]: Route "liveness" has been called\x1b[0m');
    res.json('I\'m alive');
})

router.get('/readiness', (req, res) => {
    console.info('\x1b[33m[INFO]: Route "readiness" has been called\x1b[0m');
    res.json();
})

// router.route('/users')
//     .get(userController.all)
//     .post(userController.create);
//
// router.route('/users/:id')
//     .get(userController.get)
//     .patch(userController.update)
//     .put(userController.update)
//     .delete(userController.delete);

module.exports = router;

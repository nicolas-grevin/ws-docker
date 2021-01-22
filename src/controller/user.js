User = require('../model/user');

exports.all = (req, res) => {
    User.get((err, users) => {
        if (err)
            res.status(500).json({error: err});

        res.status(200).json(users);
    });
};

exports.create = (req, res) => {
    const user = new User();
    user.name = req.body.name ? req.body.name : user.name;
    user.email = req.body.email;

    user.save(err => {
        if (err)
            res.status(500).json({error: err});

        res.status(201).json(user);
    });
};

exports.get = (req, res) => {
    User.findById(req.params.id, (err, user) => {
        if (err)
            res.status(500).json({error: err});

        res.status(201).json(user);
    });
};

exports.update = (req, res) => {
    User.findById(req.params.id, (err, user) => {
        if (err)
            res.status(500).json({error: err});

        user.name = req.body.name ? req.body.name : user.name;
        user.email = req.body.email;

        user.save(err => {
            if (err)
                res.status(500).json({error: err});

            res.status(200).json(user);
        });
    });
};

exports.delete = (req, res) => {
    User.deleteOne({_id: req.params.id}, (err, user) => {
        if (err)
            res.status(500).json({error: err});

        res.status(204).json();
    });
};

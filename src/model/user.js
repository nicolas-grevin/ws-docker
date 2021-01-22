const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name: {
        type: String,
        require: true,
    },
    email: {
        type: String,
        require: true,
    },
    create_at: {
        type: Date,
        default: Date.now
    }
});

const User = module.exports = mongoose.model('user', userSchema);


module.exports.get = (callback, limit) => {
    User.find(callback).limit(limit);
}

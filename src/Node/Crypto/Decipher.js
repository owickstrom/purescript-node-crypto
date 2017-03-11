var crypto = require('crypto');

exports.createDecipher = function (algo) {
    return function (secret) {
        return function () {
            return crypto.createDecipher(algo, secret);
        };
    };
};

exports.createDecipherIV = function (algo) {
    return function (key) {
        return function (iv) {
            return function () {
                return crypto.createDecipheriv(algo, key, iv);
            };
        };
    };
};


exports.update = function (decipher) {
    return function (buf) {
        return function () {
            return decipher.update(buf);
        };
    };
};

exports.final = function (decipher) {
    return function () {
        return decipher.final();
    };
};

var crypto = require('crypto');

exports.createCipher = function (algo) {
    return function (secret) {
        return function () {
            return crypto.createCipher(algo, secret);
        };
    };
};

exports.createCipherIV = function (algo) {
    return function (key) {
        return function (iv) {
            return function () {
                return crypto.createCipheriv(algo, key, iv);
            };
        };
    };
};

exports.update = function (cipher) {
    return function (buf) {
        return function () {
            return cipher.update(buf);
        };
    };
};

exports.final = function (cipher) {
    return function () {
        return cipher.final();
    };
};

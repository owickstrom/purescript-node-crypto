var crypto = require('crypto');

exports._createCipher = function (algo) {
    return function (secret) {
        return function () {
            return crypto.createCipher(algo, secret);
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
var crypto = require('crypto');

exports._createDecipher = function (algo) {
    return function (secret) {
        return function () {
            return crypto.createDecipher(algo, secret);
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
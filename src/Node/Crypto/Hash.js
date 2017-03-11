var crypto = require('crypto');

exports.createHash = function (algorithm) {
    return function () {
        return crypto.createHash(algorithm);
    };
};

exports._update = function (hash) {
    return function (buf) {
        return function () {
            hash.update(buf);
            return buf;
        };
    };
};

exports.digest = function (hash) {
    return function () {
        return hash.digest();
    };
};

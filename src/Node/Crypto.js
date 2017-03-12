var crypto = require('crypto');

exports.randomBytes = function (n) {
    return function () {
        return crypto.randomBytes(n);
    };
};

exports._timingSafeEqual = function (Left) {
    return function (Right) {
        return function (b1) {
            return function (b2) {
                try {
                    return Right(crypto.timingSafeEqual(b1, b2));
                } catch (e) {
                    return Left(e);
                }
            };
        };
    };
};

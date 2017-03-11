var crypto = require('crypto');

exports.randomBytes = function (n) {
  return function () {
    return crypto.randomBytes(n);
  };
};

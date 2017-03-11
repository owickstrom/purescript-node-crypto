-- | This module is used to encrypt data, wrapping
-- | https://nodejs.org/api/crypto.html#crypto_class_cipher.
module Node.Crypto.Cipher
       ( Cipher
       , createCipher
       , createCipherIV
       , update
       , final
       ) where

import Control.Monad.Eff (Eff)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO)

-- | The Cipher type represents instances of the [Cipher
-- | class](https://nodejs.org/api/crypto.html#crypto_class_cipher)
-- | in NodeJS.
foreign import data Cipher :: *

-- | Create a new [Cipher](#cipher) using the specified algoritm and password.
-- |
-- | The possible values for the algorithm depends on the OpenSSL version of
-- | the platform. Some examples are `"sha256"` and `"sha512"`.
foreign import createCipher
  :: forall e
   . Algorithm
  -> String
  -> Eff (crypto :: CRYPTO | e) Cipher

-- | Create a new [Cipher](#cipher) using the specified algoritm, key, and
-- | initialization vector.
-- |
-- | The possible values for the algorithm depends on the OpenSSL version of
-- | the platform. Some examples are `"sha256"` and `"sha512"`.
-- |
-- | Note that the key and IV buffer lengths need to match the specified
-- | algorithm.
foreign import createCipherIV
  :: forall e
   . Algorithm
  -> Buffer
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Cipher

-- | Update the [Cipher](#cipher) with the specified buffer contents. Returns
-- | a buffer of enciphered data. Cannot be called if the cipher has been
-- | [finalized](#final).
foreign import update
  :: forall e
   . Cipher
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Buffer

-- | Finalize the cipher and return any remaining enciphered data.
-- |
-- | The [Cipher](#cipher) value cannot be updated or finalized again after
-- | this operation.
foreign import final
  :: forall e
   . Cipher
  -> Eff (crypto :: CRYPTO | e) Buffer

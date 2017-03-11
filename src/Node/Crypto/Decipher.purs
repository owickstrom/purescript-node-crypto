-- | This module is used to decrypt data, wrapping
-- | https://nodejs.org/api/crypto.html#crypto_class_decipher.
module Node.Crypto.Decipher
       ( Decipher
       , createDecipher
       , update
       , final
       ) where

import Control.Monad.Eff (Eff)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO)

-- | The Decipher type represents instances of the [Decipher
-- | class](https://nodejs.org/api/crypto.html#crypto_class_decipher)
-- | in NodeJS.
foreign import data Decipher :: *

-- | Create a new [Decipher](#decipher) using the specified algoritm and
-- | password.
-- |
-- | The possible values for the algorithm depends on the OpenSSL version of
-- | the platform. Some examples are `"sha256"` and `"sha512"`.
foreign import createDecipher
  :: forall e
   . Algorithm
  -> String
  -> Eff (crypto :: CRYPTO | e) Decipher

-- | Create a new [Decipher](#decipher) using the specified algoritm, key, and
-- | initialization vector.
-- |
-- | The possible values for the algorithm depends on the OpenSSL version of
-- | the platform. Some examples are `"sha256"` and `"sha512"`.
-- |
-- | Note that the key and IV buffer lengths need to match the specified
-- | algorithm.
foreign import createDecipherIV
  :: forall e
   . Algorithm
  -> String
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Decipher

-- | Update the [Decipher](#decipher) with the specified buffer contents.
-- | Returns a buffer of deciphered data. Cannot be called if the decipher has
-- | been [finalized](#final).
foreign import update
  :: forall e
   . Decipher
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Buffer

-- | Finalize the decipher and return any remaining deciphered data.
-- |
-- | The [Decipher](#decipher) value cannot be updated or finalized again after
-- | this operation.
foreign import final
  :: forall e
   . Decipher
  -> Eff (crypto :: CRYPTO | e) Buffer

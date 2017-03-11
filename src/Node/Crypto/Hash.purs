-- | This module is used to hash data, wrapping
-- | https://nodejs.org/api/crypto.html#crypto_class_hash.
module Node.Crypto.Hash where

import Prelude
import Control.Monad.Eff (Eff)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO)

-- | The Hash type represents instances of the [Hash
-- | class](https://nodejs.org/api/crypto.html#crypto_class_hash)
-- | in NodeJS.
foreign import data Hash :: *

-- | Create a new [Hash](#hash) using the specified algoritm. The possible
-- | values for the algorithm depends on the OpenSSL version of the platform.
-- | Some examples are `"sha256"` and `"sha512"`.
foreign import createHash
  :: forall e
   . Algorithm
  -> Eff (crypto :: CRYPTO | e) Hash

foreign import _update
  :: forall e
   . Hash
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Hash

-- | Update the [Hash](#hash) with the specified buffer contents.
update
  :: forall e
   . Hash
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Unit
update h = void <<< _update h

-- | Calculate the digest of all data passed to be hashed, using the
-- | [update](#update) function. The [Hash](#hash) value cannot be updated or
-- | digested again after this operation.
foreign import digest
  :: forall e
   . Hash
   -> Eff (crypto :: CRYPTO | e) Buffer

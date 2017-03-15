module Node.Crypto
       ( CRYPTO
       , Algorithm
       , randomBytes
       , timingSafeEqual
       ) where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (Error)
import Data.Either (Either(..))
import Node.Buffer (BUFFER, Buffer)

-- | The effect of functions using the Crypto library in NodeJS.
foreign import data CRYPTO :: !

-- | Algoritms are dependent on OpenSSL in NodeJS, and are thus represented as
-- | strings.
type Algorithm = String

-- | Generate a buffer of the specified length, filled with random bytes.
foreign import randomBytes
  :: forall e
   . Int
  -> Eff (buffer :: BUFFER | e) Buffer

foreign import _timingSafeEqual
  :: (Error -> Either Error Boolean)
  -> (Boolean -> Either Error Boolean)
  -> Buffer
  -> Buffer
  -> Either Error Boolean

-- | Returns true if the buffers are equal, without leaking timing information
-- | that would allow an attacker to guess one of the values.
-- |
-- | Read more details in the NodeJS docs about
-- | [timingSafeEqual](https://nodejs.org/api/crypto.html#crypto_crypto_timingsafeequal_a_b).
timingSafeEqual
  :: Buffer
  -> Buffer
  -> Either Error Boolean
timingSafeEqual = _timingSafeEqual Left Right

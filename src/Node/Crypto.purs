module Node.Crypto where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM)
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
  -> Eff (random :: RANDOM, buffer :: BUFFER | e) Buffer

module Node.Crypto where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM)
import Node.Buffer (BUFFER, Buffer)

foreign import data CRYPTO :: !

type Algorithm = String

foreign import randomBytes
  :: forall e
   . Int
  -> Eff (random :: RANDOM, buffer :: BUFFER | e) Buffer

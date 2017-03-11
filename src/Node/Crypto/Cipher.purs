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

foreign import data Cipher :: *

foreign import createCipher
  :: forall e
   . Algorithm
  -> String
  -> Eff (crypto :: CRYPTO | e) Cipher

foreign import createCipherIV
  :: forall e
   . Algorithm
  -> Buffer
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Cipher

foreign import update
  :: forall e
   . Cipher
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Buffer

foreign import final
  :: forall e
   . Cipher
  -> Eff (crypto :: CRYPTO | e) Buffer

module Node.Crypto.Decipher
       ( Decipher
       , createDecipher
       , update
       , final
       ) where

import Control.Monad.Eff (Eff)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO)

foreign import data Decipher :: *

foreign import createDecipher
  :: forall e
   . Algorithm
  -> String
  -> Eff (crypto :: CRYPTO | e) Decipher

foreign import createDecipherIV
  :: forall e
   . Algorithm
  -> String
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Decipher

foreign import update
  :: forall e
   . Decipher
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Buffer

foreign import final
  :: forall e
   . Decipher
  -> Eff (crypto :: CRYPTO | e) Buffer

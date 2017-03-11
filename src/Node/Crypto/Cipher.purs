module Node.Crypto.Cipher
       ( Cipher
       , createCipher
       , update
       , final
       ) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Newtype (unwrap)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO, Secret)

foreign import data Cipher :: *

foreign import _createCipher 
  :: forall e
   . Algorithm
  -> String 
  -> Eff (crypto :: CRYPTO | e) Cipher

createCipher
  :: forall e
   . Algorithm
  -> Secret
  -> Eff (crypto :: CRYPTO | e) Cipher
createCipher algo = _createCipher algo <<< unwrap

foreign import update 
  :: forall e
   . Cipher
  -> Buffer 
  -> Eff (crypto :: CRYPTO | e) Buffer

foreign import final
  :: forall e
   . Cipher
  -> Eff (crypto :: CRYPTO | e) Buffer


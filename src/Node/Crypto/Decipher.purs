module Node.Crypto.Decipher
       ( Decipher
       , createDecipher
       , update
       , final
       ) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Newtype (unwrap)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO, Secret)

foreign import data Decipher :: *

foreign import _createDecipher 
  :: forall e
   . Algorithm
  -> String 
  -> Eff (crypto :: CRYPTO | e) Decipher

createDecipher
  :: forall e
   . Algorithm
  -> Secret
  -> Eff (crypto :: CRYPTO | e) Decipher
createDecipher algo = _createDecipher algo <<< unwrap

foreign import update 
  :: forall e
   . Decipher
  -> Buffer 
  -> Eff (crypto :: CRYPTO | e) Buffer

foreign import final
  :: forall e
   . Decipher
  -> Eff (crypto :: CRYPTO | e) Buffer
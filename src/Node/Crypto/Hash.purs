module Node.Crypto.Hash where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Newtype (unwrap)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO, Secret)

foreign import data Hash :: *

foreign import _createHash 
  :: forall e
   . Algorithm 
  -> String 
  -> Eff (crypto :: CRYPTO | e) Hash

createHash
  :: forall e
   . Algorithm
  -> Secret
  -> Eff (crypto :: CRYPTO | e) Hash
createHash algo = _createHash algo <<< unwrap

foreign import _update 
  :: forall e
   . Hash
  -> Buffer
  -> Eff (crypto :: CRYPTO | e) Hash

update
  :: forall e
   . Hash
  -> Buffer 
  -> Eff (crypto :: CRYPTO | e) Unit
update h = void <<< _update h

foreign import _digest 
  :: forall e
   . Hash
   -> Eff (crypto :: CRYPTO | e) Buffer

digest 
  :: forall e
   . Hash
   -> Eff (crypto :: CRYPTO | e) Buffer
digest = _digest
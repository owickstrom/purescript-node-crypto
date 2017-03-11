module Node.Crypto.Hash where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Newtype (unwrap)
import Node.Buffer (Buffer)
import Node.Crypto (Algorithm, CRYPTO)

foreign import data Hash :: *

foreign import createHash
  :: forall e
   . Algorithm
  -> String
  -> Eff (crypto :: CRYPTO | e) Hash

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

foreign import digest
  :: forall e
   . Hash
   -> Eff (crypto :: CRYPTO | e) Buffer

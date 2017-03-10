module Node.Crypto where

import Data.Newtype (class Newtype)

foreign import data CRYPTO :: !

type Algorithm = String

newtype Secret = Secret String

derive instance newtypeSecret :: Newtype Secret _
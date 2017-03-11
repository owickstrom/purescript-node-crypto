module Node.Crypto.TestBuffer where

import Prelude
import Node.Buffer as Buffer
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Newtype (class Newtype)
import Node.Buffer (Buffer)
import Node.Encoding (Encoding(..))
import Test.QuickCheck (class Arbitrary, arbitrary)

newtype TestBuffer = TestBuffer Buffer

derive instance newtypeTestBuffer :: Newtype TestBuffer _

instance arbitraryTestBuffer :: Arbitrary TestBuffer where
  arbitrary = map bufferFromString arbitrary
    where
      bufferFromString = 
        TestBuffer 
        <<< unsafePerformEff
        <<< Buffer.fromString `flip` UTF8

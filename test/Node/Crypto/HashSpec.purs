module Node.Crypto.HashSpec where

import Prelude
import Node.Buffer as Buffer
import Node.Crypto.Hash as Hash
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Newtype (unwrap)
import Node.Buffer (Buffer)
import Node.Crypto (CRYPTO)
import Node.Crypto.TestBuffer (TestBuffer)
import Node.Encoding (Encoding(..))
import Test.QuickCheck (Result, (===))
import Test.Spec (Spec, SpecEffects, describe, it)
import Test.Spec.QuickCheck (quickCheck)

digest :: forall e. Buffer -> Eff (crypto :: CRYPTO | e) Buffer
digest buf = do
  hash <- Hash.createHash "sha256"
  Hash.update hash buf
  Hash.digest hash

digestsAreEqual :: TestBuffer -> Result
digestsAreEqual buf = unsafePerformEff do
  d1 <- digest (unwrap buf) >>= Buffer.toString UTF8
  d2 <- digest (unwrap buf) >>= Buffer.toString UTF8
  pure (d1 === d2)

spec :: Spec (SpecEffects (random :: RANDOM)) Unit
spec =
  describe "Node.Crypto.Hash" do
    it "gives the same result twice" $
      quickCheck digestsAreEqual

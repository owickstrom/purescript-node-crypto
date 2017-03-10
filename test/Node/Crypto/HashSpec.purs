module Node.Crypto.Digest.SHA256Spec where

import Prelude
import Node.Buffer as Buffer
import Node.Crypto.Hash as Hash
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Newtype (class Newtype, unwrap)
import Node.Buffer (Buffer)
import Node.Crypto (Secret(Secret))
import Node.Encoding (Encoding(..))
import Test.QuickCheck (class Arbitrary, arbitrary)
import Test.Spec (Spec, SpecEffects, describe, it)
import Test.Spec.QuickCheck (quickCheck)

newtype TestBuffer = TestBuffer Buffer

derive instance newtypeTestBuffer :: Newtype TestBuffer _

instance arbitraryTestBuffer :: Arbitrary TestBuffer where
  arbitrary = unsafePerformEff <$> map TestBuffer <$> Buffer.fromString `flip` UTF8 <$> arbitrary

buffersAreEqual :: Buffer -> Buffer -> Boolean
buffersAreEqual d d' =
  eq <$> Buffer.toString UTF8 d <*> Buffer.toString UTF8 d'
  # unsafePerformEff 

testDigest ::  Buffer -> Buffer
testDigest buf = unsafePerformEff do
  hash <- Hash.createHash "sha256" (Secret "n0tsup3rz3cr1t")
  Hash.update hash buf
  Hash.digest hash

spec :: Spec (SpecEffects (random :: RANDOM)) Unit
spec =
  describe "Node.Crypto.Hash" do
    it "gives the same result twice" $
      quickCheck \(buf :: TestBuffer) -> 
        buffersAreEqual
          (testDigest (unwrap buf))
          (testDigest (unwrap buf))

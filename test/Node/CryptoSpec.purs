module Node.CryptoSpec where

import Prelude
import Node.Buffer as Buffer
import Node.Crypto as Crypto
import Control.Monad.Eff.Exception (message)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Either (Either(..))
import Data.Newtype (unwrap)
import Node.Crypto.TestBuffer (TestBuffer(..))
import Node.Encoding (Encoding(..))
import Test.QuickCheck (Result(..), assertEquals, assertNotEquals, (===))
import Test.Spec (Spec, SpecEffects, describe, it)
import Test.Spec.QuickCheck (quickCheck)

buffersAreTimingSafeEqual :: TestBuffer -> Result
buffersAreTimingSafeEqual buf =
  case Crypto.timingSafeEqual (unwrap buf) (unwrap buf) of
    Left err -> Failed (message err)
    Right res -> res === true

throwsErrorForBuffersOfDifferingLength :: TestBuffer -> TestBuffer -> Result
throwsErrorForBuffersOfDifferingLength (TestBuffer b1) (TestBuffer b2) =
  case Crypto.timingSafeEqual b1 b2 of
    -- Errors are expected for buffers of different size.
    Left err -> unsafePerformEff (assertNotEquals <$> Buffer.size b1 <*> Buffer.size b2)
    -- Successful results are expected for buffers with equal size.
    Right _ -> unsafePerformEff (assertEquals <$> Buffer.size b1 <*> Buffer.size b2)

returnsResultForBuffersOfEqualLength :: TestBuffer -> TestBuffer -> Result
returnsResultForBuffersOfEqualLength (TestBuffer b1) (TestBuffer b2) =
  case Crypto.timingSafeEqual b1 b2 of
    -- Errors are expected for buffers of different size.
    Left err -> unsafePerformEff (assertNotEquals <$> Buffer.size b1 <*> Buffer.size b2)
    -- Successful results are expected for buffers with equal size, but
    -- possibly different data.
    Right true -> assertsBuffers assertEquals b1 b2
    Right false -> assertsBuffers assertNotEquals b1 b2
  where
    assertsBuffers assert b1' b2' =
      unsafePerformEff $
        assert <$> Buffer.toString Hex b1' <*> Buffer.toString Hex b2'

spec :: Spec (SpecEffects (random :: RANDOM)) Unit
spec =
  describe "Node.Crypto" do
    describe "timingSafeEqual" do

      it "returns true for same buffer" $
        quickCheck buffersAreTimingSafeEqual

      it "throws error for buffers of different length" $
        quickCheck throwsErrorForBuffersOfDifferingLength

      it "return boolean result for buffers of equal length" $
        quickCheck returnsResultForBuffersOfEqualLength

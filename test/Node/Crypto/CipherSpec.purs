module Node.Crypto.CipherSpec where

import Prelude
import Node.Buffer as Buffer
import Node.Crypto.Cipher as Cipher
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Newtype (unwrap)
import Node.Buffer (BUFFER, Buffer)
import Node.Crypto (CRYPTO, Secret(Secret))
import Node.Crypto.TestBuffer (TestBuffer)
import Node.Encoding (Encoding(..))
import Test.QuickCheck (Result, (===))
import Test.Spec (Spec, SpecEffects, describe, it)
import Test.Spec.QuickCheck (quickCheck)

encrypt :: forall e. Buffer -> Eff (buffer :: BUFFER, crypto :: CRYPTO | e) Buffer
encrypt buf = do
  cipher <- Cipher.createCipher "aes192" (Secret "n0tsup3rz3cr1t")
  a <- Cipher.update cipher buf
  b <- Cipher.final cipher
  Buffer.concat [a, b]

encryptedBuffersAreEqual :: TestBuffer -> Result
encryptedBuffersAreEqual buf = unsafePerformEff do
  b1 <- encrypt (unwrap buf) >>= Buffer.toString UTF8
  b2 <- encrypt (unwrap buf) >>= Buffer.toString UTF8
  pure (b1 === b2)

spec :: Spec (SpecEffects (random :: RANDOM)) Unit
spec =
  describe "Node.Crypto.Cipher" do
    it "gives the same result twice" $
      quickCheck encryptedBuffersAreEqual

module Node.Crypto.CipherSpec where

import Prelude
import Node.Buffer as Buffer
import Node.Crypto as Crypto
import Node.Crypto.Cipher as Cipher
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Newtype (unwrap)
import Node.Buffer (BUFFER, Buffer)
import Node.Crypto (CRYPTO)
import Node.Crypto.Cipher (Cipher)
import Node.Crypto.TestBuffer (TestBuffer)
import Node.Encoding (Encoding(..))
import Test.QuickCheck (Result, (===))
import Test.Spec (Spec, SpecEffects, describe, it)
import Test.Spec.QuickCheck (quickCheck)

encryptWith
  :: forall e
   . Eff (buffer :: BUFFER, crypto :: CRYPTO | e) Cipher
  -> Buffer
  -> Eff (buffer :: BUFFER, crypto :: CRYPTO | e) Buffer
encryptWith cipher buf = do
  c <- cipher
  a <- Cipher.update c buf
  b <- Cipher.final c
  Buffer.concat [a, b]

encryptedBuffersAreEqual
  :: forall e
   . (Buffer -> Eff (crypto :: CRYPTO, buffer :: BUFFER | e) Buffer)
  -> TestBuffer
  -> Result
encryptedBuffersAreEqual encrypt buf = unsafePerformEff do
  b1 <- encrypt (unwrap buf) >>= Buffer.toString UTF8
  b2 <- encrypt (unwrap buf) >>= Buffer.toString UTF8
  pure (b1 === b2)

spec :: Spec (SpecEffects (random :: RANDOM, buffer :: BUFFER)) Unit
spec =
  describe "Node.Crypto.Cipher" do

    describe "without IV" $
      it "gives the same result twice" do
        let cipher = Cipher.createCipher "aes192" "n0tsup3rz3cr1t"
        quickCheck (encryptedBuffersAreEqual (encryptWith cipher))

    describe "with IV" $
      it "gives the same result twice" do
        key <- liftEff (Crypto.randomBytes 24)
        iv <- liftEff (Crypto.randomBytes 16)
        let cipher = Cipher.createCipherIV "aes192" key iv
        quickCheck (encryptedBuffersAreEqual (encryptWith cipher))


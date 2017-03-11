module Node.Crypto.DecipherSpec where

import Prelude
import Node.Buffer as Buffer
import Node.Crypto.Cipher as Cipher
import Node.Crypto.Decipher as Decipher
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Newtype (unwrap)
import Node.Buffer (BUFFER, Buffer)
import Node.Crypto (CRYPTO, Algorithm)
import Node.Crypto.TestBuffer (TestBuffer)
import Node.Encoding (Encoding(..))
import Test.QuickCheck (Result, (===))
import Test.Spec (Spec, SpecEffects, describe, it)
import Test.Spec.QuickCheck (quickCheck)

algorithm :: Algorithm
algorithm = "aes192"

secret :: String
secret = "n0tsup3rz3cr1t"

encrypt :: forall e. Buffer -> Eff (buffer :: BUFFER, crypto :: CRYPTO | e) Buffer
encrypt buf = do
  cipher <- Cipher.createCipher algorithm secret
  a <- Cipher.update cipher buf
  b <- Cipher.final cipher
  Buffer.concat [a, b]

decrypt :: forall e. Buffer -> Eff (buffer :: BUFFER, crypto :: CRYPTO | e) Buffer
decrypt buf = do
  cipher <- Decipher.createDecipher algorithm secret
  a <- Decipher.update cipher buf
  b <- Decipher.final cipher
  Buffer.concat [a, b]

roundtrips :: TestBuffer -> Result
roundtrips buf = unsafePerformEff do
  inputStr <- Buffer.toString UTF8 (unwrap buf)
  encrypted <- encrypt (unwrap buf)
  decryptedStr <- decrypt encrypted >>= Buffer.toString UTF8
  pure (inputStr === decryptedStr)

spec :: Spec (SpecEffects (random :: RANDOM)) Unit
spec =
  describe "Node.Crypto.Decipher" do
    it "roundtrips" (quickCheck roundtrips)


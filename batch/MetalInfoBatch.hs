-- stack runghc batch/MetalInfoBatch.hs
{-# LANGUAGE OverloadedStrings #-}
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Client (defaultManagerSettings, newManager)
import Network.HTTP.Simple
import Control.Lens
import Data.Aeson.Lens

main :: IO ()
main = do
  print "----- do start -----"
  manager <- newManager defaultManagerSettings
  let request = setRequestManager manager "http://localhost:3000/metalInfo"
  response <- httpLBS request

  putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response

  let (Just goldValue') = (getResponseBody response) ^? key "gold" . _String
  let (Just ptValue') = (getResponseBody response) ^? key "pt" . _String

  print goldValue'
  print ptValue'

  print "----- do end -----"


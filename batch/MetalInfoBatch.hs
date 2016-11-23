-- stack runghc batch/MetalInfoBatch.hs
{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Lazy.Char8 as L8
import           Network.HTTP.Client (defaultManagerSettings, newManager)
import           Network.HTTP.Simple

main :: IO ()
main = do
  print "----- do start -----"
  manager <- newManager defaultManagerSettings
  let request = setRequestManager manager "http://localhost:3000/metalInfo"
  response <- httpLBS request

  putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response
  L8.putStrLn $ getResponseBody response 

  print "----- do end -----"


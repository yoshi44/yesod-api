-- stack runghc batch/MetalInfoBatch.hs
{-# LANGUAGE OverloadedStrings #-}
import Control.Lens
import Data.Aeson
import Data.Aeson.Lens
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Network.HTTP.Client (defaultManagerSettings, newManager)
import Network.HTTP.Simple
import Turtle

mailCommand :: String -> String -> String -> String
mailCommand body title address =
  unwords ["echo "
          , body
          , " | "
          , "mail ", "-s ", title
          , show address]

exeMail :: String -> Text -> Text -> IO ()
exeMail address gold pt = do
  print address
  print gold
  print pt

  let mailTemplate = "\
                      \ mailTemplate test  \n\
                      \ aaa test"

  let body = "Today Information: " ++ "Gold=" ++ show gold ++ "Platinum=" ++ show pt
  let title = "title test"
  let cmd = mailCommand (show body) (show title) address

  print cmd
  T.putStrLn (T.pack cmd)

  shell (T.pack cmd) empty -- execute command
  print ""

main :: IO ()
main = do
  print "----- do start -----"
  manager <- newManager defaultManagerSettings
  let request = setRequestManager manager "http://localhost:4444/metalInfo"
  response <- httpLBS request

  putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response

  let (Just goldValue') = (getResponseBody response) ^? key "gold" . _String
  let (Just ptValue') = (getResponseBody response) ^? key "pt" . _String

  print goldValue'
  print ptValue'

  let requestForEmail = setRequestManager manager "http://localhost:4444/email"
  responseForEmail <- httpLBS requestForEmail

  print $ getResponseBody responseForEmail

  -- :TODO index
  let (Just emails) = (getResponseBody responseForEmail) ^? key "emailsKey" . nth 1 . key "email" . _String
  print emails

  exeMail (show emails) goldValue' ptValue'

  print "----- do end -----"


module Handler.Email where

import Import

getEmailR :: Handler Value
getEmailR = do
  emails <- runDB $ selectList [] [] :: Handler [Entity Email]
  return $ object ["emailsKey" .= emails]


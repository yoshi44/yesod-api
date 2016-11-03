module Handler.Message where

import Import

-- getMessageR :: Handler Html
-- getMessageR = error "Not yet implemented: getMessageR"

getMessageR :: Handler Value
getMessageR = do
  message <- runDB $ selectList [] [] :: Handler [Entity Message]
  return $ object ["message" .= message]

-- postMessageR :: Handler Html
-- postMessageR = error "Not yet implemented: postMessageR"
postMessageR :: Handler ()
postMessageR = do
  post <- requireJsonBody :: Handler Message
  _    <- runDB $ insert post
  sendResponseStatus status201 ("CREATED" :: Text)


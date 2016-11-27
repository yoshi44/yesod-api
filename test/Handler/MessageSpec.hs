module Handler.MessageSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

    describe "getMessageR" $ do
      it "gives a 200" $ do
        get MessageR
        statusIs 200


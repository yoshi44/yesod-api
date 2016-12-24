module Handler.EmailSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

  describe "getEmailR" $ do
    it "gives a 200" $ do
      get EmailR
      statusIs 200


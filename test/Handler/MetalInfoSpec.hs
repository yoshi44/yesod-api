module Handler.MetalInfoSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do
    describe "metalInfo.txt" $ do
        it "gives a 200" $ do
            get MetalInfoR
            statusIs 200

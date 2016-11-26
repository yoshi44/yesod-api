module Handler.MetalInfo where

import Import

import Text.XML.Cursor
import Text.HTML.DOM
import Network.HTTP.Conduit
import qualified Data.Text as T

data MetalInfo = MetalInfo
  {
    gold :: Text
   ,pt :: Text
  }

instance ToJSON MetalInfo where
  toJSON MetalInfo {..} = object
    [
      "gold" .= gold
     ,"pt" .= pt
    ]

getMetalInfoR :: Handler Value
getMetalInfoR = do
  putStrLn "----- do start -----"
  doc <- parseLBS <$> simpleHttp "http://gold.tanaka.co.jp/commodity/souba/english/"
  let root = fromDocument doc
  let goldInfo = unwords (pickUpMetalInfo root "gold")
  let ptInfo = unwords (pickUpMetalInfo root "pt")
  putStrLn "----- do end -----"
  returnJson $ MetalInfo goldInfo ptInfo

pickUpMetalInfo :: Cursor -> Text -> [T.Text]
pickUpMetalInfo info metalType = info $// element "table"
                             >=> attributeIs "id" "metal_price"
                             >=> child
                             >=> element "tr"
                             >=> attributeIs "class" metalType
                             >=> child
                             >=> element "td"
                             >=> attributeIs "class" "retail_tax"
                             &// content


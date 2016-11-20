module Handler.Gold where

import Import

import Text.XML.Cursor
import Text.HTML.DOM
import Network.HTTP.Conduit
import qualified Data.Text as T

data MetalInfo = MetalInfo
  {
    gold :: [Text]
   ,pt :: [Text]
  }

instance ToJSON MetalInfo where
  toJSON MetalInfo {..} = object
    [
      "gold" .= gold
     ,"pt" .= pt
    ]

getGoldR :: Handler Value
getGoldR = do
  putStrLn "----- do start -----"
  doc <- parseLBS <$> simpleHttp "http://gold.tanaka.co.jp/commodity/souba/english/"
  let root = fromDocument doc
  let goldInfo = pickUpGoldInfo root
  let ptInfo = pickUpPtInfo root
  putStrLn "----- do end -----"
  returnJson $ MetalInfo goldInfo ptInfo

pickUpGoldInfo :: Cursor -> [T.Text]
pickUpGoldInfo info = info $// element "table"
                            >=> attributeIs "id" "metal_price"
                            >=> child
                            >=> element "tr"
                            >=> attributeIs "class" "gold"
                            >=> child
                            >=> element "td"
                            >=> attributeIs "class" "retail_tax"
                            &// content

pickUpPtInfo :: Cursor -> [T.Text]
pickUpPtInfo info = info $// element "table"
                            >=> attributeIs "id" "metal_price"
                            >=> child
                            >=> element "tr"
                            >=> attributeIs "class" "pt"
                            >=> child
                            >=> element "td"
                            >=> attributeIs "class" "retail_tax"
                            &// content


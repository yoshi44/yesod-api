{-# LANGUAGE OverloadedStrings #-}
module Handler.Gold where

import Import

import Text.XML.Cursor
import Text.HTML.DOM
import Network.HTTP.Conduit
import qualified Data.Text as T

getGoldR :: Handler Value
getGoldR = do
  putStrLn "----- do start -----"
  doc <- parseLBS <$> simpleHttp "http://gold.tanaka.co.jp/index.php"
  let root = fromDocument doc
  let entries = pickUpMetalInfo root
  print entries
  putStrLn (unwords entries)
  putStrLn "----- do end -----"
  return $ object ["gold" .= (String "bbb") ]

pickUpMetalInfo :: Cursor -> [T.Text]
pickUpMetalInfo info = info $// element "div"
                            >=> attributeIs "id" "soba_info"
                            >=> child
                            >=> element "ul"
                            >=> child
                            >=> element "li"
                            >=> child
                            >=> element "a"
                            >=> child
                            >=> element "span"
                            &// content


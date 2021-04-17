{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

module Main where

import Data.Colour (withOpacity)
import Data.Colour.SRGB (sRGB)
import Diagrams.Prelude
import Diagrams.Backend.Rasterific.CmdLine
-- for svg output comment out previous line and uncomment following
-- import Diagrams.Backend.SVG.CmdLine 

circle' :: Int -> Diagram B
circle' _ = circle 1 # fcA circleColour # lwL 0.012
    where circleColour = withOpacity (sRGB 1 0 0) 0.1

pAdic :: Int -> Int -> Diagram B
pAdic p 1 = circle' 1
pAdic p n = circle' n `atop` scale r circles
    where circles  = atPoints vertices $ repeat $ pAdic p (n - 1)
          vertices = trailVertices $ regPoly p 2
          r = sin (pi / q) / (sin (pi / q) + 1)
          q = fromIntegral p

createDiagram :: Int -> Int -> Diagram B
createDiagram p depth = pAdic p depth # bgFrame 0.1 white

main :: IO ()
main = mainWith createDiagram

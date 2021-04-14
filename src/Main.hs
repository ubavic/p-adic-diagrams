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

circleColour ::  AlphaColour Double
circleColour = withOpacity (sRGB 1 0 0) 0.1

myCircle :: Diagram B
myCircle = circle 1 # fcA circleColour # lwL 0.012

pAdic :: Int -> Int -> Diagram B
pAdic 1 _  = myCircle
pAdic n p  = myCircle `atop` (scale r circles)
    where circles  = atPoints vertices $ repeat $ pAdic (n - 1) p
          vertices = trailVertices $ regPoly p 2
          r = sin (pi / q) / (sin (pi / q) + 1)
          q = fromIntegral p

-- square is used for padding 
createDiagram :: Int -> Int -> Diagram B
createDiagram p depth  = (pAdic depth p) `atop` square 2.1 # fc white # lw none 

main :: IO ()
main = mainWith createDiagram

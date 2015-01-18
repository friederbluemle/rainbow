-- Generates a Cabal file using the Cartel package.
--
-- Written for Cartel version 0.12

import Cartel

rainbowVersion :: [Word]
rainbowVersion = [0,20,0,6]

-- Dependencies

base :: Package
base = closedOpen "base" [4,5,0,0] [4,8,0,0]

terminfo :: Package
terminfo = closedOpen "terminfo" [0,3,2] [0,5,0,0]

text :: Package
text = closedOpen "text" [0,11,2,0] [1,3,0,0]

commonOptions :: HasBuildInfo a => [a]
commonOptions =
  [ haskell2010
  , ghcOptions ["-Wall"]
  , buildDepends [base, terminfo, text]
  , hsSourceDirs ["lib"]
  ]

properties :: Properties
properties = blank
  { name = "rainbow"
  , version = rainbowVersion
  , cabalVersion = Just (1,16)
  , buildType = Just simple
  , license = Just bsd3
  , licenseFile = "LICENSE"
  , copyright = "Copyright 2013-2015 Omari Norman"
  , author = "Omari Norman"
  , maintainer = "omari@smileystation.com"
  , stability = "Experimental"
  , homepage = "https://www.github.com/massysett/rainbow"
  , bugReports = "https://www.github.com/massysett/rainbow/issues"
  , category = "System"
  , synopsis = "Print text to terminal with colors and effects"
  , description =
    [ "rainbow helps you print Text chunks to a terminal with colors and effects"
    , "such as bold, underlining, etc. You pair each Text with a description"
    , "of how it should appear. Rainbow works with both 8-color and 256-color"
    , "terminals."
    , ""
    , "rainbow uses the terminfo package which, in turn, needs the full C"
    , "library for ncurses installed, including the development"
    , "headers. Before installing terminfo, you may need to install the"
    , "ncurses headers (for instance, on Debian systems, install the"
    , "libncurses5-dev package.)"
    ]
  , testedWith = map (\ls -> (ghc, eq ls)) [[7,6,3], [7,8,2]]
  }

main :: IO ()
main = defaultMain $ do
  libModules <- modules "lib"
  testModules <- modules "tests"
  return
    ( properties
    , exposedModules libModules
      : commonOptions
    , [ githubHead "massysett" "rainbow"
      ]
    )

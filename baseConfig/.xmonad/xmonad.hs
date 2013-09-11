import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO
 
main = do
  xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmobarrc"
  xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
      , layoutHook = avoidStruts  $  layoutHook defaultConfig
      , logHook = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor "green" "" . shorten 80
        }
    , terminal    = "urxvt"
    , modMask     = mod1Mask
    , borderWidth = 1 --was "3"
    , focusedBorderColor = "#4099FF"
    , normalBorderColor = "#474747"
    }

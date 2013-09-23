import XMonad
import XMonad.Config.Xfce
main = xmonad xfceConfig
       { terminal = "urxvt"
       , modMask = mod1Mask -- sets to alt key 
       , borderWidth = 1 --was "3"
       , focusedBorderColor = "#4099FF"
       , normalBorderColor = "#474747" 
       }

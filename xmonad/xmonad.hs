import XMonad

-- LAYOUTS
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

-- WINDOW RULES
import XMonad.ManageHook

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers

-- KDE INTEGRATION
import XMonad.Config.Kde

-- KEYBOARD & MOUSE CONFIG
import XMonad.Util.EZConfig

import XMonad.Hooks.Script

import XMonad.Util.Run

import qualified XMonad.StackSet as W

main = xmonad $ kde4Config
                {
                        -- Basic
                        modMask            = mod1Mask,
                        borderWidth        = 4,
                        focusedBorderColor = "#A55",
                        focusFollowsMouse  = False,
                        clickJustFocuses   = False,
                        terminal           = "urxvt",
                        workspaces         = [ "1" , "2" , "3", "4" , "5" ],

                        -- Hooks
                        layoutHook = smartBorders $ myLayout,
                        manageHook = manageHook defaultConfig <+> manageDocks <+> myManageHook <+> insertPosition Master Newer <+>
                                        composeOne
                                        [
                                                isKDETrayWindow -?> doIgnore,
                                                transience,
                                                isFullscreen -?> doFullFloat
                                        ]
                }
                `additionalKeys`
                [
                        ((mod1Mask .|. shiftMask, xK_q), kill),
                        ((mod1Mask .|. shiftMask, xK_m), windows W.swapMaster)
                ]
                `removeKeys`
                [
                        (mod1Mask .|. shiftMask, xK_slash ),
                        (mod1Mask              , xK_p     ),
                        (mod1Mask              , xK_n     ),
                        (mod1Mask              , xK_Return)
                ]
                `removeMouseBindings`
                [
                    (mod1Mask, button1),
                    (mod1Mask, button2),
                    (mod1Mask, button3)
                ]

--------------------------------------------------------------------------------
-- DECLARE WORKSPACES RULES
--------------------------------------------------------------------------------
myLayout = avoidStruts (tiled ||| simpleTabbed)
        where
                tiled    = spacing 0 $ ResizableTall nmaster delta ratio []
                nmaster  = 1
                delta    = 5/100
                ratio    = toRational (2/(1 + sqrt 5 :: Double))

--------------------------------------------------------------------------------
-- APPLICATION SPECIFIC RULES
--------------------------------------------------------------------------------
myManageHook = composeAll . concat $
        [
                [ className   =? c --> doFloat           | c <- myFloats],
                [ title       =? t --> doFloat           | t <- myOtherFloats],
                [ className   =? l --> insertPosition End Newer | l <- myPosition]
        ]
        where
                myFloats      = ["MPlayer", "Gimp", "Plasma", "Plasma-desktop", "Klipper", "Kded4"]
                myOtherFloats = ["alsamixer", "exit"]
                myPosition    = ["XTerm", "URxvt", "Dolphin"]

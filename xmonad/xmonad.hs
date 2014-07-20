import XMonad

-- LAYOUTS
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

-- WINDOW RULES
import XMonad.ManageHook

-- STATUS BAR
import XMonad.Hooks.DynamicLog

-- KEYBOARD & MOUSE CONFIG
import XMonad.Util.EZConfig

-- STATUS BAR
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks

import XMonad.Hooks.Script

import XMonad.Util.Run

main = do
        dzenLeftBar         <- spawnPipe myXmonadBar
        dzenRightBar        <- spawnPipe myStatusBar
        xmonad $ defaultConfig
                {
                        -- Basic
                        modMask            = mod1Mask,
                        borderWidth        = 4,
                        focusedBorderColor = "#A55",
                        focusFollowsMouse  = False,
                        terminal           = "urxvt",
                        workspaces         = [ "1" , "2" , "3", "4" , "5" ],

                        -- Hooks
                        -- startupHook = execScriptHook "~/bin/start",
                        layoutHook = smartBorders $ myLayout,
                        logHook = myLogHook dzenLeftBar,
                        manageHook = manageHook defaultConfig <+> manageDocks <+> myManageHook <+> insertPosition End Newer
                }
                `additionalKeys`
                [
                          ((mod1Mask .|. shiftMask, xK_q), kill)
                ]

--------------------------------------------------------------------------------
-- DZEN LOG RULES for workspace names, layout image, current program title
--------------------------------------------------------------------------------
myLogHook h = dynamicLogWithPP ( defaultPP
        {
                ppCurrent         = dzenColor color15 background    . pad,
                ppVisible         = dzenColor color14 background    . pad,
                ppHidden          = dzenColor color14 background    . pad,
                ppHiddenNoWindows = dzenColor background background . pad,
                ppWsSep           = "",
                ppSep             = "    ",
                ppOrder           =  \(ws:l:t:_) -> [ws,l, t],
                ppOutput          =   hPutStrLn h
        } )

myXmonadBar = "dzen2 -e '' -x '0' -y '0' -h '15' -w '500' -ta 'l' -fg '"++foreground++"' -bg '"++background++"' -fn "++myFont
myStatusBar = "~/bin/status_bar '"++foreground++"' '"++background++"' "++myFont

--------------------------------------------------------------------------------
-- DECLARE WORKSPACES RULES
--------------------------------------------------------------------------------
myLayout = avoidStruts (tiled)
        where
                tiled    = spacing 10 $ ResizableTall nmaster delta ratio []
                nmaster  = 1
                delta    = 5/100
                ratio    = toRational (2/(1 + sqrt 5 :: Double))

--------------------------------------------------------------------------------
-- APPLICATION SPECIFIC RULES
--------------------------------------------------------------------------------
myManageHook = composeAll
        [
                title =? "exit" --> doFloat
        ]
--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
myFont = "xft:Inconsolata:size=10"

background = "#181512"
foreground = "#D6C3B6"
color0     = "#332d29"
color1     = "#8c644c"
color2     = "#746C48"
color3     = "#bfba92"
color4     = "#646a6d"
color5     = "#766782"
color6     = "#4B5C5E"
color7     = "#504339"
color8     = "#817267"
color9     = "#9f7155"
color10    = "#9f7155"
color11    = "#E0DAAC"
color12    = "#777E82"
color13    = "#897796"
color14    = "#556D70"
color15    = "#9a875f"

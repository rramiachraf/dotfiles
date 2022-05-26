local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}

-- Palette
theme.bg    = "#121d41"
theme.fg    = "#F3F1F5"
theme.main  = "#6d3153"
theme.green = "#6ECB63"
theme.red   = "#FF4848"
theme.title = "#FDAF75"

-- General
theme.font = "jetbrains mono 9"

-- Windows
theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = "#131313"
theme.border_focus  = theme.main

-- Wibar
wibar_transparency   = 10
theme.wibar_bg       = theme.bg .. wibar_transparency
theme.wibar_fg       = theme.fg

-- Systray
theme.bg_systray = theme.bg

-- Tooltip
theme.tooltip_bg           = theme.bg
theme.tooltip_fg           = theme.fg
theme.tooltip_border_color = theme.main
theme.tooltip_border_width = 1

-- Taglist
theme.taglist_fg_occupied = "#FFE162"
theme.taglist_bg_focus    = theme.main

-- Wallpaper
theme.wallpaper = os.getenv("HOME")..".config/wallpapers/1.jpg"

-- Hotkeys popup
theme.hotkeys_bg                     = theme.bg
theme.hotkeys_fg                     = theme.fg
theme.hotkeys_border_color           = theme.main
theme.hotkeys_border_width           = 3
theme.hotkeys_modifiers_fg           = theme.title
theme.hotkeys_group_margin           = 10
theme.hotkeys_description_font       = theme.font

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Adwaita"

return theme

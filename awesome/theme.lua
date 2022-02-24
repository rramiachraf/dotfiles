local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}

-- Palette
theme.bg = "#161616"
theme.fg = "#F3F1F5"
theme.main = "#072227"
theme.green = "#6ECB63"
theme.red = "#FF4848"

-- General
theme.font          = "jetbrains mono nerd font medium 10"

-- Windows
theme.useless_gap   = dpi(3)
theme.border_width  = dpi(3)
theme.border_normal = "#131313"
theme.border_focus  = theme.main

-- Navbar
theme.wibar_bg      = theme.bg
theme.wibar_fg      = theme.fg

-- Systray
theme.bg_systray    = theme.bg

-- Tooltip
theme.tooltip_bg = theme.bg
theme.tooltip_fg = theme.fg
theme.tooltip_border_color = theme.fg
theme.tooltip_border_width = 1

-- Taglist
theme.taglist_fg_occupied = "#FFE162"
theme.taglist_bg_focus = theme.main

-- Wallpaper
theme.wallpaper = os.getenv("HOME")..".config/awesome/wallpaper.jpg"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Adwaita"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

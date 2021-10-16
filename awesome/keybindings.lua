local awful = require("awful")
local gears = require("gears")

local modkey = "Mod4"

local rofi_drun =
    awful.key(
    {modkey},
    "d",
    function()
        awful.spawn("rofi -show drun")
    end,
    {description = "rofi drun prompt", category = "launcher"}
)

local rofi_run = 
	awful.key(
	{modkey},
	"r",
	function()
		awful.spawn("rofi -show run")
	end,
	{description = "rofi run prompt", category = "launcher"}
)

local rofi_window =
	awful.key(
	{modkey},
	"w",
	function()
		awful.spawn("rofi -show window")
	end,
	{description = "rofi window prompt", category = "launcher"}
)

local globalkeys = gears.table.join(rofi_drun, rofi_run, rofi_window)

return globalkeys

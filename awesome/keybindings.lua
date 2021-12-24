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
    {description = "rofi drun prompt", group = "launcher"}
)

local rofi_run = 
	awful.key(
	{modkey},
	"r",
	function()
		awful.spawn("rofi -show run")
	end,
	{description = "rofi run prompt", group = "launcher"}
)

local rofi_window =
	awful.key(
	{modkey},
	"w",
	function()
		awful.spawn("rofi -show window")
	end,
	{description = "rofi window prompt", group = "launcher"}
)

local libreworlf = 
	awful.key(
	{modkey},
	"q",
	function()
		awful.spawn("librewolf")
	end,
	{description = "launch librewolf browser", group = "applications"}
)

local session_lock =
	awful.key(
	{modkey, "shift"},
	"s",
	function()
		awful.spawn("alacritty")
	end,
	{description = "lock session", group = "system"}
)

local rofi = gears.table.join(rofi_drun, rofi_run, rofi_window)
local applications = gears.table.join(librewolf)
local system = gears.table.join(sssion_lock)

return gears.table.join(rofi, applications, system)

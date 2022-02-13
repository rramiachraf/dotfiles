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
    {
        description = "rofi drun prompt",
        group = "launcher"
    }
)

local rofi_run =
    awful.key(
    {modkey},
    "r",
    function()
        awful.spawn("rofi -show run")
    end,
    {
        description = "rofi run prompt",
        group = "launcher"
    }
)

local rofi_window =
    awful.key(
    {modkey},
    "w",
    function()
        awful.spawn("rofi -show window")
    end,
    {
        description = "rofi window prompt",
        group = "launcher"
    }
)

local librewolf =
    awful.key(
    {modkey},
    "q",
    function()
        awful.spawn("librewolf")
    end,
    {
        description = "launch librewolf browser",
        group = "applications"
    }
)

local power_prompt =
    awful.key(
    {modkey, "Shift"},
    "p",
    function()
        local cmd = "echo 'Shut Down\nRestart\nSuspend' | rofi -dmenu -window-title 'Power Options'"
        awful.spawn.easy_async_with_shell(
            cmd,
            function(stdout)
                if stdout:match("Suspend") then
                    awful.spawn("xsecurelock")
                elseif stdout:match("Shut Down") then
                    awful.spawn("shutdown now")
                elseif stdout:match("Restart") then
                    awful.spawn("reboot")
                end
            end
        )
    end,
    {description = "power options prompt", group = "system"}
)

local rofi = gears.table.join(rofi_drun, rofi_run, rofi_window)
local applications = gears.table.join(librewolf)
local system = gears.table.join(power_prompt)

return gears.table.join(rofi, applications, system)

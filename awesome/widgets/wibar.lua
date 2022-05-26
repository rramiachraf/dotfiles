local awful = require("awful")
local wibox = require("wibox")

local battery = require("widgets.battery")
local memory = require("widgets.memory")
local weather = require("widgets.weather")
local clock = require("widgets.clock")
local disk = require("widgets.disk")
local network = require("widgets.network")
local uptime = require("widgets.uptime")
local systray = require("widgets.systray")

local opts = {}

opts.position = "top"

function create_wibar(s, taglists)
    opts.screen = s
    wibar = awful.wibar(opts)

    left = {
        layout = wibox.layout.fixed.horizontal,
        taglists
    }

    right = {
        layout = wibox.layout.fixed.horizontal,
        spacing = 15,
        systray,
        uptime,
        weather,
        disk,
        memory,
        battery,
        network,
        clock
    }

    wibar:setup {
        layout = wibox.layout.align.horizontal,
        left,
        {
            layout = wibox.layout.align.horizontal
        },
        right
    }
end

return create_wibar

local awful = require("awful")
local beautiful = require("beautiful")

local DIR = "/sys/class/power_supply/BAT0/"

function icon_markup(capacity, color)
    if color == nil then
        color = "#687980"
    end
    markup = "<span foreground='" .. color .. "'> </span>" .. capacity .. "%"
    return markup
end

local widget =
    awful.widget.watch(
    "cat " .. DIR .. "present",
    1,
    function(widget, stdout)
        widget.font = beautiful.font

        if stdout:match("1") then
            local status_file = io.open(DIR .. "status", "r")
            local capacity_file = io.open(DIR .. "capacity", "r")

            local capacity = tonumber(capacity_file:read("a"))
            local status = status_file:read("a")

            if status:match("Charging") and capacity <= 95 then
                widget:set_markup(icon_markup(capacity, "#FFB344"))
            elseif status:match("Charging") and capacity > 95 then
                widget:set_markup(icon_markup(capacity, "#6ECB63"))
            elseif capacity < 30 then
                widget:set_markup(icon_markup(capacity, "#FF4848"))
            else
                widget:set_markup(icon_markup(capacity))
            end

            status_file:close()
            capacity_file:close()
        else
            widget:set_markup("<span color='#687980'>NO BATTERY</span>")
        end
    end
)

local tooltip =
    awful.tooltip {
    margins_leftright = 10
}

tooltip:add_to_object(widget)

widget:connect_signal(
    "mouse::enter",
    function()
        local energy_full_design_file = io.open(DIR .. "energy_full_design")
        if energy_full_design_file ~= nil then
            local energy_full_file = io.open(DIR .. "energy_full")
            local energy_full_design = energy_full_design_file:read("a")
            local energy_full = energy_full_file:read("a")
            energy_full_design_file:close()
            energy_full_file:close()
            local health = (tonumber(energy_full) / tonumber(energy_full_design)) * 100
            local text = string.format("Battery Health: %.0f%%", health)
            tooltip.text = text
        else
            tooltip.text = "Battery Health: Unknown"
        end
    end
)

return widget

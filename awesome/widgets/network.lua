local awful = require("awful")
local beautiful = require("beautiful")

network =
    awful.widget.watch(
    "ip a",
    10,
    function(widget, stdout)
        local format = "<span foreground='%s' weight='bold'>%s</span>"
        if stdout:match("state UP") ~= nil then
            widget:set_markup(string.format(format, beautiful.green, "CONNECTED"))
        else
            widget:set_markup(string.format(format, beautiful.red, "DISCONNECTED"))
        end
    end
)

return network

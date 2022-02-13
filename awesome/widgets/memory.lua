local awful = require("awful")
local beautiful = require("beautiful")

memory_widget =
    awful.widget.watch(
    "bash -c 'vmstat -s -S m | head -n 2 | tail -n 1'",
    5,
    function(widget, stdout)
        widget.font = beautiful.font
        widget:set_markup("<span foreground='#687980'>  </span>" .. stdout:match("[0-9]+") .. " MiB")
    end
)

return memory_widget

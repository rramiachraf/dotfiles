local awful = require("awful")
local beautiful = require("beautiful")

memory_widget =
    awful.widget.watch(
    "bash -c 'vmstat -s -S m | head -n 2 | tail -n 1'",
    5,
    function(widget, stdout)
        markup = string.format("<span foreground='%s'>RAM</span> %s MiB", beautiful.title, stdout:match("[0-9]+"))
        widget:set_markup(markup)
    end
)

return memory_widget

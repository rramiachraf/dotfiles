local awful = require("awful")
local beautiful = require("beautiful")

local cmd = [[bash -c "df -h | awk '/dev\\/sda./ {print $3\"/\"$2}'"]]

disk =
    awful.widget.watch(
    cmd,
    10800,
    function(widget, stdout)
        markup = string.format("<span foreground='%s' weight='bold'>DISK</span> %s", beautiful.title, stdout)
        widget:set_markup(markup)
    end
)

return disk

local awful = require("awful")
local beautiful = require("beautiful")

local cmd = [[bash -c "df -h | awk '/dev\\/sda./ {print $3\"/\"$2}'"]]

disk =
    awful.widget.watch(
    cmd,
    10800,
    function(widget, stdout)
        widget.font = beautiful.font
        widget:set_markup("<span foreground='#687980'>DISK</span> " .. stdout)
    end
)

return disk

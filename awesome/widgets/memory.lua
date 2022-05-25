local awful = require("awful")
local beautiful = require("beautiful")

local cmd = [[bash -c "echo `free -h --mega | awk '{if(NR==2) print $3\"/\"$2}'`"]]

memory_widget =
    awful.widget.watch(
    cmd,    
    5,
    function(widget, stdout)
        markup = string.format("<span foreground='%s' weight='bold'>RAM</span> %s", beautiful.title, stdout)
        widget:set_markup(markup)
    end
)

return memory_widget

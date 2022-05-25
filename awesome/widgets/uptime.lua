local awful = require("awful")
local beautiful = require("beautiful")

return awful.widget.watch(
    'bash -c "uptime -p | cut -c 4-"',
    60,
    function(widget, stdout) 
        markup = string.format("<span color='%s' weight='bold'>UPTIME</span> %s", beautiful.title, stdout )
        widget:set_markup(markup)
    end
)

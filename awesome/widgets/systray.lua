local wibox = require("wibox")

systray = wibox.widget.systray()

x = 3
y = 2

return wibox.container.margin(systray, x, x, y, y)

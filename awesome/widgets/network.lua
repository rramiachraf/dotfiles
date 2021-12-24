local awful = require("awful")
local beautiful = require("beautiful")

network = awful.widget.watch("ip a", 10, function(widget, stdout)
	widget.font = beautiful.font

	if stdout:match("state UP") ~= nil then
		widget:set_markup("<span foreground='#6ECB63'>CONNECTED</span>")
	else
		widget:set_markup("<span foreground='#FF4848'>DISCONNECTED</span>")
	end
end
)

return network

local awful = require("awful")
local beautiful = require("beautiful")

local endpoint = "http://api.openweathermap.org/data/2.5/weather"
local api_key = os.getenv("OPENWEATHERMAP_API")
local location = "Casablanca,Morocco"

local url = endpoint .. "?q=" .. location .. "&appid=" .. api_key .. "&mode=json&units=metric"

local cmd = "curl '" .. url .. "' -H 'content-type: application/json'"

weather_widget =
    awful.widget.watch(
    cmd,
    1800,
    function(widget, stdout)
	widget.font = beautiful.font
        local temp = stdout:match('temp":[0-9]+.?[0-9]*,'):match("[0-9]+.?[0-9]*")
	local temp_int = tonumber(temp)
        widget:set_markup("<span foreground='#687980'>  </span>"..math.ceil(temp_int).."°C")
    end
)

return weather_widget

local awful = require("awful")
local beautiful = require("beautiful")
local json = require("packages.jsonlua.json")

local endpoint = "http://api.openweathermap.org/data/2.5/weather"
local api_key = os.getenv("OPENWEATHERMAP_API")
local location = "Casablanca,Morocco"

local url = endpoint .. "?q=" .. location .. "&appid=" .. api_key .. "&mode=json&units=metric"

local cmd = "curl '" .. url .. "' -H 'content-type: application/json'"

weather_widget =
    awful.widget.watch(
    cmd,
    3600,
    function(widget, stdout)
        local data = json.decode(stdout)
        local temp = data.main.temp
        local description = data.weather[1].main
        local markup = string.format("<span foreground='%s'>WEATHER</span> %.0f°C", beautiful.title, temp)
        widget:set_markup(markup)
    end
)

return weather_widget

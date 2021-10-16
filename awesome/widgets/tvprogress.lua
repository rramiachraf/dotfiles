local wibox = require("wibox")
local awful = require("awful")
local json = require("packages.jsonlua.json")

local file = io.open(os.getenv("HOME").."/tvprogress.json", "r")
local file_exists = file ~= nil
local tv = file_exists and json.decode(file:read("a")) or ""

if file_exists then 
	file:close()
end

local text = file_exists and string.format("%s - S%sE%02d", tv.show, tv.season, tv.episode) or "N/A"

local tvprogress = wibox.widget {
	widget = wibox.widget.textbox,
	markup = "<span foreground='#687980'>  </span>"..text
}

tvprogress:connect_signal("button::press", function()
	command = string.format("alacritty --working-directory %s", file_exists and tv.location:gsub(" ", "\\ ") or os.getenv("HOME"))
	awful.spawn(command)
end
)

return tvprogress

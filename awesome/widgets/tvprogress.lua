local wibox = require("wibox")
local awful = require("awful")
local json = require("packages.jsonlua.json")

local file = io.open(os.getenv("HOME").."/tvprogress.json", "r")
local file_exists = file ~= nil
local tv = file_exists and json.decode(file:read("a")) or ""

if file_exists then 
	file:close()
end

local text = file_exists and string.format("%s - S%02dE%02d", tv.work, tv.season, tv.episode) or "N/A"

local tvprogress = wibox.widget {
	widget = wibox.widget.textbox,
	markup = "<span foreground='#687980'>  </span>"..text
}

tvprogress:connect_signal("button::press", function()
	tv_location = tv.location and tv.location:gsub(" ", "\\ ") or os.getenv("HOME")
	tv_command = string.format("alacritty --working-directory %s", file_exists and tv_location)
	anime_command = string.format("alacritty --working-directory %s/Scripts/ani-cli -e ./ani-cli", os.getenv("HOME"))
	if tv.type == "anime" then awful.spawn(anime_command) else awful.spawn(tv_command) end
end
)

return tvprogress

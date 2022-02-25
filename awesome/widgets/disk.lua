local awful = require("awful")
local beautiful = require("beautiful")

local df = "df -T -h -t ext4"
local tail = "tail -n 1"
local sed = "sed 's/\\s+/\\t/gmi' -r"
local cut = "cut -f 3,4"
local awk = 'awk \'{printf \\"%s/%s\\", $2, $1}\''

local cmd = 'bash -c "' .. df .. "|" .. tail .. "|" .. sed .. "|" .. cut .. "|" .. awk .. '"'

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

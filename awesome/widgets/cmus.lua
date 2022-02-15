local awful = require("awful")
local beautiful = require("beautiful")


local widget = awful.widget.watch("cmus-remote -Q", 0.5, function(widget, stdout, _, _, exitcode)
    widget.font = beautiful.font
    if exitcode == 1 then
        widget:set_markup("<span foreground='#687980'></span> N/A")
    else
        local artist = stdout:match("tag artist [a-zA-Z0-9' ]*"):gsub("tag artist ", "")
        local title = stdout:match("tag title [a-zA-Z0-9' ]*"):gsub("tag title ", "")
        local playing = stdout:match("status %a*"):gsub("status ", "")
        local format = ""

        if #title > 17 then
            title = title:sub(1, 16).."..."
        end

        if #artist > 13 then
            artist = artist:sub(1, 12).."..."
        end

        if playing:match("playing") then
            format = string.format("<span foreground='#687980'></span> %s - %s", artist, title)
        elseif playing:match("paused") then
            format = string.format("<span foreground='#687980'>契</span> %s - %s", artist, title)
        end

        widget:set_markup(format)
    end
end
)

return widget

local awful = require("awful")
local beautiful = require("beautiful")

function icon_markup(percentage, color)
	if color == nil then color = "#687980" end
	if percentage == nil then percentage = "0" end

	markup = "<span foreground='"..color.."'> </span>"..percentage.."%"
	return markup
end

battery =
    awful.widget.watch(
    "acpi",
    1,
    function(widget, stdout)
	widget.font = beautiful.font
	if percentage ~= "" then
		percentage = stdout:match("%d+%%"):sub(1, -2)
	end

	if stdout:match("Charging") ~= nil and tonumber(percentage) <= 95 then
		widget:set_markup(icon_markup(percentage, "#FFB344"))
	elseif stdout:match("Charging") ~= nil or stdout:match("Full") ~= nil and tonumber(percentage) > 95 then
		widget:set_markup(icon_markup(percentage, "#6ECB63"))
	elseif stdout:match("Discharging") ~= nil and tonumber(percentage) <= 30 then
		widget:set_markup(icon_markup(percentage, "#FF4848"))
	else
		widget:set_markup(icon_markup(percentage) or 0)
	end

    end
)

return battery

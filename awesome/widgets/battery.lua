local awful = require("awful")
local beautiful = require("beautiful")

local DIR = "/sys/class/power_supply/BAT0/"

function icon_markup(percentage, color)
	if color == nil then color = "#687980" end
	markup = "<span foreground='"..color.."'> </span>"..percentage.."%"
	return markup
end

-- use energy_full_design to make tooltip for battery quality

battery =
    awful.widget.watch(
    "cat "..DIR.."present",
    1,
    function(widget, stdout)
	widget.font = beautiful.font

	if stdout:match("1") then
		local energy_now_file = io.open(DIR.."energy_now", "r")
		local energy_full_file = io.open(DIR.."energy_full", "r")
		local status_file = io.open(DIR.."status", "r")

		local energy_now = energy_now_file:read("a")
		local energy_full = energy_full_file:read("a")
		local status = status_file:read("a")

		local formula = (tonumber(energy_now) / tonumber(energy_full)) * 100
		local percentage = math.floor(formula)
		
		if status:match("Charging") and percentage <= 95 then
			widget:set_markup(icon_markup(percentage, "#FFB344"))
		elseif status:match("Charging") and percentage > 95 then
			widget:set_markup(icon_markup(percentage, "#6ECB63"))
		elseif percentage < 30 then
			widget:set_markup(icon_markup(percentage, "#FF4848"))
		else
			widget:set_markup(icon_markup(percentage))
		end

		-- cleanup
		energy_now_file:close()
		energy_full_file:close()
		status_file:close()
	else
		widget:set_markup("NO BATTERY")
	end
end
)

return battery

local awful = require("awful")
local json = require("packages.jsonlua.json")

local api_key = os.getenv("COINMARKETCAP_API")
local url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
local currency = "SHIB"
local full_url = url.."?symbol="..currency
local percentage_foreground = ""

local cmd = "curl -sL '"..full_url.."' -H 'X-CMC_PRO_API_KEY: "..api_key.."'"

return awful.widget.watch(cmd, 900, function(widget, stdout)
	decoded = json.decode(stdout)
	price = decoded.data[currency].quote.USD.price
	day_percentage = decoded.data[currency].quote.USD.percent_change_24h
	
	if day_percentage > 0 then
		percentage_foreground = "#6ECB63"
	else
		percentage_foreground = "#FF4848"
	end

	widget:set_markup(
		string.format(
		"<span foreground='#687980'>%s </span>%.8f USD <span foreground='%s'>%.2f%%</span>",
		currency, 
		price,
		percentage_foreground, 
		day_percentage
		)
	)
end
)

local awful = require("awful")
local json = require("packages.jsonlua.json")
local beautiful = require("beautiful")

local api_key = os.getenv("COINMARKETCAP_API")
local url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
local currency = "XMR"
local full_url = url .. "?symbol=" .. currency

local cmd = "curl -sL '" .. full_url .. "' -H 'X-CMC_PRO_API_KEY: " .. api_key .. "'"

local crypto_widget =
    awful.widget.watch(
    cmd,
    3600,
    function(widget, stdout)
        decoded = json.decode(stdout)
        price = decoded.data[currency].quote.USD.price
        day_percentage = decoded.data[currency].quote.USD.percent_change_24h

        percentage_foreground = day_percentage > 0 and beautiful.green or beautiful.red

        widget:set_markup(
            string.format(
                "<span foreground='%s' weight='bold'>%s</span> %.2f USD <span foreground='%s'>%.2f%%</span>",
                beautiful.title,
                currency,
                price,
                percentage_foreground,
                day_percentage
            )
        )
    end
)

return crypto_widget

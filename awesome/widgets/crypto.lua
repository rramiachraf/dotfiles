local awful = require("awful")
local json = require("packages.jsonlua.json")
local beautiful = require("beautiful")

local price = 0
local balance = 1498143.16
local api_key = os.getenv("COINMARKETCAP_API")
local url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
local currency = "SHIB"
local full_url = url .. "?symbol=" .. currency
local percentage_foreground = ""

local cmd = "curl -sL '" .. full_url .. "' -H 'X-CMC_PRO_API_KEY: " .. api_key .. "'"

local crypto_widget =
    awful.widget.watch(
    cmd,
    900,
    function(widget, stdout)
        decoded = json.decode(stdout)
        price = decoded.data[currency].quote.USD.price
        day_percentage = decoded.data[currency].quote.USD.percent_change_24h

        percentage_foreground = day_percentage > 0 and beautiful.green or beautiful.red

        widget:set_markup(
            string.format(
                "<span foreground='#687980'>%s</span> %.6f USD <span foreground='%s'>%.2f%%</span>",
                currency,
                price,
                percentage_foreground,
                day_percentage
            )
        )
    end
)

local crypto_tooltip =
    awful.tooltip {
    margins_leftright = 10
}

crypto_tooltip:add_to_object(crypto_widget)

crypto_widget:connect_signal(
    "mouse::enter",
    function()
        local text = string.format("%.2f %s = %.2f USD", balance, currency, balance * price)
        crypto_tooltip.text = text
    end
)

return crypto_widget

local beautiful = require('beautiful')
local awful = require('awful')

function all(clientkeys, clientbuttons) 
    return {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }
end


browsers = {
    rule_any = { class = { "firefox", "librewolf" } },
    properties = { maximized = true }
}

function setrules(clientkeys, clientbuttons) 
    return {
        browsers,
        all(clientkeys, clientbuttons)
    }
end

return setrules

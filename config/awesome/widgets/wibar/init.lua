local awful = require("awful")
local wibox = require("wibox")

local dpi = require("beautiful.xresources").apply_dpi

local menu = require("widgets.menu")

-- local layoutbox = require('widgets.wibar.layoutbox')
-- local taglist   = require('widgets.wibar.taglist')
-- local tasklist  = require('widgets.wibar.tasklist')

-- return function (s)
--    s.widgets = {
--       layoutbox      = layoutbox(s),
--       taglist        = taglist(s),
--       tasklist       = tasklist(s),

--       keyboardlayout = awful.widget.keyboardlayout(),
--       promptbox      = awful.widget.prompt(),
--       systray        = wibox.widget.systray(),
--       textclock      = awful.widget.textclock(),
--    }

--    s.widgets.wibar = awful.wibar({
--       screen   = s,
--       position = 'bottom',

--       height = dpi(16),

--       widget = {
--          layout = wibox.layout.align.horizontal,

--          -- left widgets
--          {
--             layout = wibox.layout.fixed.horizontal,
--             menu.launcher,
--             s.widgets.taglist,
--             s.widgets.promptbox,
--          },

--          -- middle widgets
--          s.widgets.tasklist,

--          -- right widgets
--          {
--             layout = wibox.layout.fixed.horizontal,
--             s.widgets.keyboardlayout,
--             s.widgets.systray,
--             s.widgets.textclock,
--             s.widgets.layoutbox,
--          }
--       }
--    })

-- end

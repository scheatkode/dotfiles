local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local beautiful = require("beautiful")

local vars = require("config.vars")

local function setup_screen(s)
	-- wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper

		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end

		gears.wallpaper.centered(wallpaper, s, "#282828")
	end

	-- each screen has its own tag table
	awful.tag(vars.tags, s, awful.layout.layouts[1])

	-- create a keyboard map indicator and switcher
	s.keyboardlayout = awful.widget.keyboardlayout()

	-- create a promptbox for each screen
	s.promptbox = awful.widget.prompt()

	-- create an imagebox widget which will contain an icon indicating which
	-- layout we're using
	-- we need one layoutbox per screen
	s.layoutbox = awful.widget.layoutbox(s)

	s.layoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	-- create a taglist widget
	s.taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		-- buttons = taglist_buttons
	})

	-- create a tasklist widget
	s.tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		-- buttons = tasklist_buttons
	})

	-- create a textclock widget
	s.textclock = wibox.widget.textclock()

	-- create the wibox
	s.wibox = awful.wibar({
		position = "bottom",
		screen = s,
	})

	-- Add widgets to the wibox
	s.wibox:setup({
		layout = wibox.layout.align.horizontal,

		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- s.launcher,
			s.taglist,
			s.promptbox,
		},

		s.tasklist, -- Middle widget

		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			s.keyboardlayout,
			wibox.widget.systray(),
			s.textclock,
			s.layoutbox,
		},
	})
end

return {
	setup = function()
		awful.screen.connect_for_each_screen(setup_screen)
	end,
}

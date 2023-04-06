local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

return {
	["request::wallpaper"] = function(s)
		awful.wallpaper({
			screen = s,
			widget = {
				{
					image = beautiful.wallpaper,
					upscale = true,
					downscale = true,
					widget = wibox.widget.imagebox,
				},

				valign = "center",
				halign = "center",
				tiled = false,
				widget = wibox.container.tile,
			},
		})
	end,

	["property::geometry"] = function(s)
		if beautiful.wallpaper then
			local wallpaper = beautiful.wallpaper

			-- if wallpaper is a function, call it with the screen screen as
			-- argument
			if type(wallpaper) == "function" then
				wallpaper = wallpaper(s)
			end

			gears.wallpaper.centered(wallpaper, s, "#282828")
		end
	end,
}

local beautiful = require("beautiful")
local gears = require("gears")
local tablex = require("tablex")

local opacity = beautiful.flash_start_opacity or 0.70
local step = beautiful.flash_step or 0.01

local flash = function(c)
	if c then
		c.opacity = opacity

		local q = opacity
		local g = gears.timer({
			autostart = true,
			call_now = false,
			timeout = step,
		})

		g:connect_signal("timeout", function()
			if not c.valid then
				return
			end

			if q >= 1 then
				c.opacity = 1
				g:stop()
				return
			end

			c.opacity = q
			q = q + step
		end)

		c:raise()
	end
end

local enable = function()
	client.connect_signal("focus", flash)
end

local disable = function()
	client.disconnect_signal("unfocus", flash)
end

local setup = function(overrides)
	local defaults = {
		opacity = opacity,
		step = step,
	}

	local options = tablex.deep_extend("force", defaults, overrides or {})

	opacity = options.opacity
	step = options.step

	enable()
end

return {
	enable = enable,
	disable = disable,
	setup = setup,
	flash = flash,
}

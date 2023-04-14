return {
	setup = function()
		local xresources = require("beautiful.xresources")
		local naughty = require("naughty")

		local dpi = xresources.apply_dpi

		naughty.config.defaults.border_width = dpi(0)
		naughty.config.defaults.margin = dpi(16)
		naughty.config.padding = dpi(16)
		naughty.config.spacing = dpi(16)
	end,
}

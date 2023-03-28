local awful = require("awful")
local widgets = require("widgets")

return {

	["mouse::global::toggle main menu"] = {
		modifiers = {},
		button = 3,
		on_press = function()
			widgets.menu.mainmenu:toggle()
		end,
	},

	["mouse::tag::view previous"] = {
		modifiers = {},
		button = 4,
		on_press = awful.tag.viewprev,
	},

	["mouse::tag::view next"] = {
		modifiers = {},
		button = 5,
		on_press = awful.tag.viewnext,
	},
}

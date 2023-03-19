local awful = require("awful")
local mod = require("bindings.mod")

return {

	["keyboard::client::toggle fullscreen"] = {
		modifiers = { mod.super },
		key = "f",
		description = "toggle fullscreen",
		group = "client",
		on_press = function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
	},

	["keyboard::client::close"] = {
		modifiers = { mod.super, mod.shift },
		key = "c",
		description = "close",
		group = "client",
		on_press = function(c)
			c:kill()
		end,
	},

	["keyboard::client::toggle floating"] = {
		modifiers = { mod.super, mod.ctrl },
		key = "space",
		description = "toggle floating",
		group = "client",
		on_press = awful.client.floating.toggle,
	},

	["keyboard::client::move to master"] = {
		modifiers = { mod.super, mod.ctrl },
		key = "Return",
		description = "move to master",
		group = "client",
		on_press = function(c)
			c:swap(awful.client.getmaster())
		end,
	},

	["keyboard::client::move to screen"] = {
		modifiers = { mod.super },
		key = "o",
		description = "move to screen",
		group = "client",
		on_press = function(c)
			c:move_to_screen()
		end,
	},

	["keyboard::client::toggle keep on top"] = {
		modifiers = { mod.super },
		key = "t",
		description = "toggle keep on top",
		group = "client",
		on_press = function(c)
			c.ontop = not c.ontop
		end,
	},

	["keyboard::client::minimize"] = {
		modifiers = { mod.super },
		key = "n",
		description = "minimize",
		group = "client",
		on_press = function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end,
	},

	["keyboard::client::(un)maximize"] = {
		modifiers = { mod.super },
		key = "m",
		description = "(un)maximize",
		group = "client",
		on_press = function(c)
			c.maximized = not c.maximized
			c:raise()
		end,
	},

	["keyboard::client::(un)maximize vertically"] = {
		modifiers = { mod.super, mod.ctrl },
		key = "m",
		description = "(un)maximize vertically",
		group = "client",
		on_press = function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end,
	},

	["keyboard::client::(un)maximize horizontally"] = {
		modifiers = { mod.super, mod.shift },
		key = "m",
		description = "(un)maximize horizontally",
		group = "client",
		on_press = function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end,
	},
}

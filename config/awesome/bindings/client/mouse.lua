local awful = require("awful")
local gears = require("gears")
local mod = require("bindings.mod")

return gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),

	awful.button({ mod.super }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),

	awful.button({ mod.super }, 2, function(c)
		local naughty = require("naughty")
		naughty.notify({
			preset = naughty.config.presets.low,
			title = "Client inspection",
			text = string.format(
				table.concat({
					"name: %s",
					"instance: %s",
					"role: %s",
					"class: %s",
					"type: %s",
					"modal: %s",
				}, "\n"),
				c.name,
				c.instance,
				c.role,
				c.class,
				c.type,
				c.modal
			),
		})
	end),

	awful.button({ mod.super }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

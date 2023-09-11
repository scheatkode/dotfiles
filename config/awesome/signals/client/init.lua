local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

require("awful.autofocus")

return {

	-- signal function to execute when a new client appears.
	["manage"] = function(c)
		-- set the windows at the slave, i.e. put it at the end of others instead
		-- of setting it as master.
		-- if not awesome.startup then awful.client.setslave(c) end

		if
			awesome.startup
			and not c.size_hints.user_position
			and not c.size_hints.program_position
		then
			-- prevent clients from being unreachable after screen count changes.
			awful.placement.no_offscreen(c)
		end
	end,

	["focus"] = function(c)
		c.border_color = beautiful.border_focus
	end,

	["unfocus"] = function(c)
		c.border_color = beautiful.border_normal
	end,

	-- add a titlebar if `titlebars_enabled` is set to `true` in the rules.
	["request::titlebars"] = function(c)
		-- buttons for the titlebar
		local buttons = gears.table.join(

			awful.button({
				modifiers = {},
				button = 1,
				on_press = function()
					c:emit_signal("request_activate", "titlebar", { raise = true })
					awful.mouse.client.move(c)
				end,
			}),

			awful.button({
				modifiers = {},
				button = 3,
				on_press = function()
					c:emit_signal("request_activate", "titlebar", { raise = true })
					awful.mouse.client.resize(c)
				end,
			})
		)

		awful.titlebar(c):setup({
			-- left
			{
				awful.titlebar.widget.iconwidget(c),
				buttons = buttons,
				layout = wibox.layout.fixed.horizontal,
			},

			-- middle
			{
				-- title
				{
					align = "center",
					widget = awful.titlebar.widget.titlewidget(c),
				},

				buttons = buttons,
				layout = wibox.layout.flex.horizontal,
			},

			-- right
			{
				awful.titlebar.widget.floatingbutton(c),
				awful.titlebar.widget.maximizedbutton(c),
				awful.titlebar.widget.stickybutton(c),
				awful.titlebar.widget.ontopbutton(c),
				awful.titlebar.widget.closebutton(c),

				layout = wibox.layout.fixed.horizontal(),
			},

			layout = wibox.layout.align.horizontal,
		})
	end,
}

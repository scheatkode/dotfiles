local awful = require("awful")
local beautiful = require("beautiful")

-- Rules to apply to new clients (through the 'manage' signal).

return {
	setup = function()
		awful.rules.rules = {

			-- All clients will match this rule.
			{
				rule = {},
				properties = {
					border_width = beautiful.border_width,
					border_color = beautiful.border_color,
					focus = awful.client.focus.filter,
					keys = require("bindings.client.keyboard"),
					buttons = require("bindings.client.mouse"),
					screen = awful.screen.preferred,
					placement = awful.placement.no_overlap
						+ awful.placement.no_offscreen,
				},
			},

			{
				rule_any = {
					instance = {
						"DTA", -- Firefox addon DownThemAll.
						"copyq", -- Includes session name in class.
						"pinentry",
					},

					class = {
						"Arandr",
						"Blueman-manager",
						"Gpick",
						"Kruler",
						"MessageWin", -- kalarm.
						"Sxiv",
						"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
						"Wpa_gui",
						"veromix",
						"xtightvncviewer",
					},

					-- Note that the name property shown in xprop might be set slightly
					-- after creation of the client and the name shown there might not
					-- match defined rules here.
					name = {
						"Event Tester", -- xev.
						"anydesk", -- AnyDesk's remote address field.
					},

					role = {
						"AlarmWindow", -- Thunderbird's calendar.
						"ConfigManager", -- Thunderbird's about:config.
						"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
					},
				},
				properties = {
					floating = true,
				},
			},

			-- Disable titlebars to normal clients and dialogs.
			{
				rule_any = {
					type = {
						"normal",
					},
				},
				properties = {
					titlebars_enabled = false,
				},
			},

			-- Disable titlebars to normal clients and dialogs.
			{
				rule_any = {
					instance = {
						"copyq", -- Includes session name in class.
						"pinentry",
					},

					type = {
						"dialog",
					},
				},
				properties = {
					sticky = true,
					placement = awful.placement.centered,
					titlebars_enabled = false,
				},
			},

			-- Set Firefox to always map on the tag named '2' on screen 1.
			{
				rule = { class = "Firefox" },
				properties = { screen = 1, tag = 2 },
			},
		}
	end,
}

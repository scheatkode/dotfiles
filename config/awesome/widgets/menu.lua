local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local apps = require("apps")

local m = {}

m.awesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", apps.manual_cmd },
	{ "edit config", apps.editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{ "quit", awesome.quit },
}

m.mainmenu = awful.menu({
	items = {
		{ "awesome", m.awesomemenu, beautiful.awesome_icon },
		{ "open terminal", apps.terminal },
	},
})

m.launcher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = m.mainmenu,
})

return m

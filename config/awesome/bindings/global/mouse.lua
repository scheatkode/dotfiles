return {
	setup = function()
		local awful = require("awful")
		local gears = require("gears")
		local widgets = require("widgets")

		return root.buttons(
			gears.table.join(
				awful.button({}, 3, function()
					widgets.menu.mainmenu:toggle()
				end),
				awful.button({}, 4, awful.tag.viewprev),
				awful.button({}, 5, awful.tag.viewnext)
			)
		)
	end,
}

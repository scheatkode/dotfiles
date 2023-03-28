local awful = require("awful")
-- local volume = require('components.volume')

return function(s, filter, buttons)
	return awful.widget.tasklist({
		screen = s,
		-- filter  = awful.widget.tasklist.filter.currenttags,
		filter = filter,
		buttons = buttons,

		-- volume()
	})
end

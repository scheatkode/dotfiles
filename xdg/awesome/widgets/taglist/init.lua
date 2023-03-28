local awful = require("awful")

return function(s, filter, buttons)
	return awful.widget.taglist({
		screen = s,
		-- filter  = awful.widget.taglist.filter.all,
		filter = filter,
		buttons = buttons,
	})
end

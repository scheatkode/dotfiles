local awful = require("awful")

return function(s, buttons)
	return awful.widget.prompt({
		screen = s,
		buttons = buttons,
	})
end

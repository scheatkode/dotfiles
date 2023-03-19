local telescope = require("telescope")

return function(options)
	options = options or {}

	return telescope.extensions.file_browser.file_browser(options)
end

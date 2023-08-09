return function()
	local lookup = require("lsp.utilities.find_ancestor")

	return {
		autostart = false,

		filetypes = {
			"yaml",
		},

		root_dir = lookup(".git"),

		single_file_support = true,
	}
end

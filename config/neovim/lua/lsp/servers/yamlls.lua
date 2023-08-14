return function()
	local lookup = require("user.lsp.utils.find_ancestor")

	return {
		autostart = false,

		filetypes = {
			"yaml",
		},

		root_dir = lookup(".git"),

		single_file_support = true,
	}
end

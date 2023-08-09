return function()
	local lookup = require("lsp.utilities.find_ancestor")

	return {
		filetypes = {
			"rust",
		},
		settings = {
			["rust-analyzer"] = {},
		},
		root_dir = lookup(".git"),
		single_file_support = true,
	}
end

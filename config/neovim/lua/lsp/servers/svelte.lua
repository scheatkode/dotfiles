return function()
	local lookup = require("user.lsp.utils.find_ancestor")

	return {
		filetypes = {
			"svelte",
		},

		root_dir = lookup(
			"svelte.config.js",
			"tsconfig.json",
			"jsconfig.json",
			"package.json",
			"pnpm-lock.yaml",
			"yarn.lock",
			"package-lock.json",
			"pnpm-workspace.yaml",
			".git"
		),

		settings = {
			svelte = {
				["enable-ts-plugin"] = true,
			},
		},
	}
end

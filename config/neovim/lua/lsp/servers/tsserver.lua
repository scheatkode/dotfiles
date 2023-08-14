return function()
	local lookup = require("user.lsp.utils.find_ancestor")

	return {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},

		root_dir = lookup(
			"pnpm-workspace.yaml",
			"pnpm-lock.yaml",
			"yarn.lock",
			"package-lock.json",
			"tsconfig.json",
			"jsconfig.json",
			"package.json",
			".git"
		),
	}
end

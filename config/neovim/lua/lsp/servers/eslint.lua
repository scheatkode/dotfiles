return function()
	local lookup = require("user.lsp.utils.find_ancestor")

	return {
		filetypes = {
			"javascript",
			"javascript.jsx",
			"javascriptreact",
			"svelte",
			"typescript",
			"typescript.jsx",
			"typescriptreact",
			"vue",
		},

		root_dir = lookup(
			"pnpm-workspace.yaml",
			"pnpm-lock.yaml",
			"yarn.lock",
			"package-lock.json",
			".git",
			"tsconfig.json",
			"jsconfig.json",
			"package.json",
			"eslint.config.js",
			".eslintrc.js",
			".eslintrc.json",
			".eslintrc.yaml"
		),
	}
end

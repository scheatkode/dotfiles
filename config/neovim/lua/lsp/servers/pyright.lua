return {
	filetypes = {
		"python",
	},

	settings = {
		python = {
			disableOrganizeImports = false,
			disableLanguageServices = false,

			analysis = {
				autoSearchPaths = true,
				autoImportCompletions = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "strict",
			},

			exclude = {
				"**/node_modules",
				"**/__pycache__",
				"**/plz-out",
			},
		},
	},
}

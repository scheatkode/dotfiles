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
		},
	},
}

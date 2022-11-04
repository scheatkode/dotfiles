local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for pyright ... unsuccessfully.')
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
	autostart = false,

	filetypes = {
		'python'
	},

	settings = {
		python = {
			disableOrganizeImports  = false,
			disableLanguageServices = false,

			analysis = {
				autoSearchPaths        = true,
				autoImportCompletions  = true,
				diagnosticMode         = 'workspace',
				useLibraryCodeForTypes = true,
				typeCheckingMode       = 'strict',
			},
		},
	},
}

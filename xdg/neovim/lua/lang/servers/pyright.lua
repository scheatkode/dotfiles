local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for pyright ... unsuccessfully.')
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
	filetypes = {
		'python'
	},

	root_dir = function(filename)
		return lspconfig.util.root_pattern(
			'.git',
			'pyproject.toml',
			'requirements.txt',
			'setup.py'
		)(filename) or lspconfig.util.dirname(filename)
	end,

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

local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for denols ... unsuccessfully.')
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
	filetypes = {
		'dart',
	},

	init_options = {
		closingLabels = false,
		flutterOutline = false,
		onlyAnalyzeProjectsWithOpenFiles = false,
		outline = false,
		suggestFromUnimportedLibraries = true,
	},

	root_dir = lspconfig.util.root_pattern("pubspec.yaml")
}

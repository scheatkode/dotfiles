local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for phpactor ... unsuccessfully.')
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
	filetypes = { 'php' },
	root_dir  = lspconfig.util.root_pattern('.git', 'composer.json')
}

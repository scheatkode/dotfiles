local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for salt_ls ... unsuccessfully.')
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {}

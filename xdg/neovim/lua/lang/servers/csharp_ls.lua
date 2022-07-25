local has_lspconfig, _ = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for csharp-ls ... unsuccessfully.')
	return has_lspconfig
end

return {}

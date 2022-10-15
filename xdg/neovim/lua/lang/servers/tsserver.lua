local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for tsserver ... unsuccessfully.')
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
	},

	root_dir = lspconfig.util.root_pattern(
		'.git',
		'pnpm-workspace.yaml',
		'tsconfig.json',
		'jsconfig.json',
		'package.json'
	)
}

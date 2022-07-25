local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

local constant = require('f.function.constant')
local ternary  = require('f.function.ternary')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for jsonls ... unsuccessfully.')
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

local has_schemastore, schemastore = pcall(require, 'schemastore')

if not has_schemastore then
	print('! Schemastore not found, autocompletion will be unavailable.')
end

return {
	filetypes = {
		'json',
		'jsonc',
	},

	root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),

	settings = ternary(
		has_schemastore,
		constant({ json = { schemas = schemastore.json.schemas() } }),
		constant(nil)
	)
}

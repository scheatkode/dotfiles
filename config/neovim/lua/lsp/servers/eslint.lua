local has_lspconfig, lspconfig = pcall(require, "lspconfig")

if not has_lspconfig then
	print("‼ Tried loading lspconfig for eslint ... unsuccessfully.")
	return has_lspconfig
end

return {
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"svelte",
		"typescript",
		"typescriptreact",
		"typescript.jsx",
		"vue",
	},

	root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
}

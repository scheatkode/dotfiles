local has_lspconfig, lspconfig = pcall(require, "lspconfig")

if not has_lspconfig then
	print("‼ Tried loading lspconfig for rust_analyzer ... unsuccessfully.")
	return has_lspconfig
end

return {
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {},
	},
	root_dir = lspconfig.util.root_pattern(".git"),
	single_file_support = true,
}

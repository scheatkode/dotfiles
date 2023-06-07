local has_lspconfig, lspconfig = pcall(require, "lspconfig")

if not has_lspconfig then
	print("‼ Tried loading lspconfig for vtsls ... unsuccessfully.")
	return has_lspconfig
end

return {
	root_dir = lspconfig.util.root_pattern(
		"pnpm-workspace.yaml",
		"pnpm-lock.yaml",
		"yarn.lock",
		"package-lock.json",
		".git"
	),

	single_file_support = false,
}

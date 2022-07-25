local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
	print()
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
	filetypes = {
		'cmake'
	},

	init_options = {
		buildDirectory = 'build',
	},

	root_dir = lspconfig.util.root_pattern(
		'.git',
		'compile_commands.json',
		'build'
	),

	single_file_support = true,
}

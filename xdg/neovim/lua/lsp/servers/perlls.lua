local has_lspconfig, lspconfig = pcall(require, "lspconfig")

if not has_lspconfig then
	print("‼ Tried loading lspconfig for perlls ... unsuccessfully.")
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
	filetypes = {
		"perl",
	},

	settings = {
		perl = {
			fileFilter = {
				".pm",
				".pl",
			},
			ignoreDirs = ".git",
			perlCmd = "perl",
			perlInc = {
				"local/lib/perl5",
				"local/bin/",
				"src",
			},
		},
	},

	root_dir = function(filename)
		return lspconfig.util.root_pattern(
			"cpanfile",
			"cpanfile.snapshot",
			".git"
		)(filename)
	end,
}

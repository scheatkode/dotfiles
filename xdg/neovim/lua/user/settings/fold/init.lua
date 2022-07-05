return {
	---Setup folding behaviour.
	setup = function()
		vim.opt.foldlevelstart = 3
		vim.opt.foldnestmax    = 3
		vim.opt.foldminlines   = 1

		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
		vim.opt.foldtext   = "getline(v:foldstart) . ' ... ' . trim(getline(v:foldend))"

		vim.opt.foldopen:append('search')
	end
}

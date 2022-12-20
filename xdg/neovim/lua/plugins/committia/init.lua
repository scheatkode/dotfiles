return {
	'rhysd/committia.vim',

	ft = 'gitcommit',

	init = function()
		vim.g.committia_open_only_vim_starting = 1
		vim.g.committia_min_window_width       = 100

		vim.api.nvim_exec(
			[[
            nnoremap <PgUp> <Plug>(committia-scroll-diff-up-half)
            nnoremap <PgDn> <Plug>(committia-scroll-diff-down-half)
         ]],
			false
		)
	end,
}

return {
	---Highlight yanked text.
	setup = function()
		vim.api.nvim_create_autocmd('TextYankPost', {
			group    = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
			callback = function()
				vim.highlight.on_yank({
					timeout   = 100,
					on_visual = false,
				})
			end
		})
	end
}

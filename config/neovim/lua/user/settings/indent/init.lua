return {
	---Setup indentation behaviour.
	setup = function()
		vim.opt.expandtab = false -- Don't expand tabs
		vim.opt.copyindent = true -- Copy the structure of existing lines when indenting.
		vim.opt.autoindent = true -- Copy indent from current line
		-- vim.opt.cindent        = true -- C-style indentation
		vim.opt.smartindent = true -- Follow previous indentation level
		vim.opt.preserveindent = true -- Preserve as much of the indentation as possible

		vim.opt.shiftround = true -- Round indentation to multiple of `shiftwidth`
		vim.opt.smarttab = true -- Be smart when using tabs
		vim.opt.tabstop = 3 -- 1 tab = 3 spaces
		vim.opt.softtabstop = 0 -- Remove 3 spaces when hitting backspace
		vim.opt.shiftwidth = 3 -- `>>` inserts 3 spaces
	end,
}

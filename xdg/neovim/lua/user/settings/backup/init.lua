return {
	---Setup backup and persistence behaviour.
	setup = function()
		vim.opt.backup = false
		vim.opt.writebackup = false

		if vim.fn.isdirectory(vim.o.undodir) ~= 1 then
			vim.fn.mkdir(vim.o.undodir, "p")
		end

		vim.opt.swapfile = false
		vim.opt.undofile = true
	end,
}

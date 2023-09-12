return {
	---Setup timing behaviour.
	setup = function()
		vim.opt.updatetime = 2000 -- Inactivity delay of 2 seconds
		vim.opt.timeout = true -- Wait `timeoutlen` milliseconds before applying mapping
		vim.opt.ttimeout = true -- Same for TUI
		vim.opt.timeoutlen = 500 -- Delay before keystroke timeout
		vim.opt.ttimeoutlen = 10 -- Same but for terminal
	end,
}

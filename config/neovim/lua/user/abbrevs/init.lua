return {
	---setup abbreviations for common fat-fingered mistypes.
	setup = function()
		vim.cmd({ cmd = "inoreabbrev", args = { "!+", "!=" } })
		vim.cmd({ cmd = "inoreabbrev", args = { "_>", "->" } })
		vim.cmd({ cmd = "inoreabbrev", args = { "+>", "=>" } })
	end,
}

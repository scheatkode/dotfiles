return {
	---setup abbreviations for common fat-fingered mistypes.
	setup = function()
		vim.cmd.inoreabbrev({ "!+", "!=" })
		vim.cmd.inoreabbrev({ "_>", "->" })
		vim.cmd.inoreabbrev({ "+>", "=>" })

		vim.cmd.inoreabbrev({ ";//", "://" })
		vim.cmd.cnoreabbrev({ ";//", "://" })
		vim.cmd.inoreabbrev({ ";;", "::" })
		vim.cmd.inoreabbrev({ ";=", "::" })
		vim.cmd.inoreabbrev({ ",-", "<-" })
	end,
}

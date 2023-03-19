return {
	setup = function()
		vim.api.nvim_create_autocmd("QuickFixCmdPost", {
			group = vim.api.nvim_create_augroup(
				"QuickFixAutoOpen",
				{ clear = true }
			),
			command = "cwindow",
		})
	end,
}

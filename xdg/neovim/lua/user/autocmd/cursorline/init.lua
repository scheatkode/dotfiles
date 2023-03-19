return {
	---Show the cursorline only in the active window.
	setup = function()
		local cursor_line_augroup =
			vim.api.nvim_create_augroup("CursorLine", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "BufWinEnter" }, {
			group = cursor_line_augroup,
			callback = function()
				if -- should we show the cursorline ?
					not vim.wo.previewwindow
					and vim.bo.buftype ~= "terminal"
					and vim.bo.filetype ~= ""
					and vim.wo.winhighlight == ""
				then
					vim.wo.cursorline = true
				end
			end,
		})

		vim.api.nvim_create_autocmd("WinLeave", {
			group = cursor_line_augroup,
			callback = function()
				vim.wo.cursorline = false
			end,
		})
	end,
}

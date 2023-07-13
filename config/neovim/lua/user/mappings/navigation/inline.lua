return {
	---better inline navigation
	setup = function()
		local function super_caret()
			local col = vim.api.nvim_win_get_cursor(0)[2]
			local line = vim.api.nvim_get_current_line()

			if line:find("%S") == col + 1 then
				return "0"
			end

			return "^"
		end

		vim.keymap.set({ "n", "x", "o" }, "H", super_caret, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "L", "$")
	end,
}

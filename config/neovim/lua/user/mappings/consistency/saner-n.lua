return {
	---saner behavior of n and N (search forward and backward,
	---respectively)
	---@see https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
	setup = function()
		local search = function(forward)
			return function()
				return string.format(
					"%szzzv",
					vim.v.searchforward == forward and "n" or "N"
				)
			end
		end

		vim.keymap.set({ "n", "x", "o" }, "n", search(1), { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "N", search(0), { expr = true })
	end,
}

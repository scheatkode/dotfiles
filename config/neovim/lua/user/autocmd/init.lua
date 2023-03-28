return {
	setup = function()
		require("user.autocmd.cursorline").setup()
		require("user.autocmd.yank").setup()
		require("user.autocmd.quickfix").setup()
		require("user.autocmd.whitespace").setup()
	end,
}

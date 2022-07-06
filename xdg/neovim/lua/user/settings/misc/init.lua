return {
	---Setup miscellaneous behaviour.
	setup = function()
		-- Mice are for the weak

		vim.opt.mouse      = ''
		vim.opt.mousefocus = false

		-- No more annoying sounds on errors

		vim.opt.errorbells = false
		vim.opt.visualbell = false

		vim.opt.sessionoptions = {
			'globals',
			'buffers',
			'curdir',
			'help',
			'winpos',
		}

		vim.opt.viewoptions = {
			'cursor',
			'folds'
		}

		vim.opt.clipboard = {
			'unnamedplus', -- unified clipboard, yay ~
		}
	end
}

return {
	---Setup miscellaneous behaviour.
	setup = function()
		local flags = require('compat.flags')

		-- Mice are for the weak

		vim.opt.mouse      = ''
		vim.opt.mousefocus = false

		-- No more annoying sounds on errors

		vim.opt.errorbells = false
		vim.opt.visualbell = false

		-- No need to spawn a heavy shell most of the time

		if not flags.is_windows then
			vim.opt.shell = '/bin/sh'
		end

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

return {
	---Setup file encoding behaviour and external modification
	---detection.
	setup = function()
		vim.opt.autoread     = true -- Detect external file modifications
		vim.opt.autowrite    = false -- Don't auto write buffer when not focused
		vim.opt.autowriteall = true -- Automatically save files before running commands
		vim.opt.confirm      = true -- Prompt to save before being destructive

		vim.opt.bomb        = false -- Don't prepend bom byte, what is this, Winblows ?
		vim.opt.encoding    = 'UTF-8' -- Utf8 as standard encoding
		vim.opt.fileformats = { -- Simple line feed as standard line ending
			'unix',
			'dos',
			'mac',
		}
	end
}

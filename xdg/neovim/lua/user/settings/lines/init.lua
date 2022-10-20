return {
	---Setup line length, line numbering, breaking, etc.
	setup = function()
		vim.opt.textwidth      = 78 -- Wrap when line reaches 78 characters
		vim.opt.relativenumber = true -- Use line numbers relative to the current line
		vim.opt.number         = true -- ... but show the actual current line number
		vim.opt.linebreak      = true -- Lines wrap at words rather than random characters
		vim.opt.ruler          = false
		vim.opt.cursorline     = false -- Cursorline is highlighted conditionally through autocmd
		vim.opt.cursorlineopt  = 'screenline,number'
		vim.opt.synmaxcol      = 200 -- Don't highlight after the 200th character
		vim.opt.signcolumn     = 'auto:1' -- Resize to accomodate the signcolumn

		vim.opt.breakindent    = true -- Keep visual blocks indented when wrapping
		vim.opt.breakindentopt = 'sbr'
		vim.opt.showbreak      = '↪'

		vim.opt.wrap = false -- Don't visually wrap lines

		vim.opt.showmatch = true -- Show matching brackets
		vim.opt.matchtime = 3 -- Tenths of a second to blink when matching brackets
	end
}

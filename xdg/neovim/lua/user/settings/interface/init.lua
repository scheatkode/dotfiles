return {
	---Configure user interface behaviour.
	setup = function()
		-- Colors
		vim.opt.termguicolors = true -- Enable true colors, we're not in 1984 anymore
		vim.opt.syntax        = 'off' -- Overridden by Treesitter
		vim.opt.lazyredraw    = true -- Don't redraw when executing macros
		vim.opt.pumheight     = 15 -- Limit completion items
		vim.opt.pumblend      = 15 -- Make popup window translucient
		vim.opt.winblend      = 10 -- Floating window transparency
		vim.opt.conceallevel  = 2 -- Hide text unless it has a custom replacement

		-- Statusline & Cmdline
		vim.opt.history    = 1000 -- Number of commands to remember
		vim.opt.cmdheight  = 1 -- Height of the command bar
		vim.opt.laststatus = 2 -- Always enable the status line
		vim.opt.showcmd    = true -- Show me keystrokes
		vim.opt.showmode   = false -- Disable showing modes below the statusline

		vim.opt.shortmess = {
			s = true, -- Ignore 'search hit BOTTOM' kind of messages
			t = true, -- Truncate long messages
			I = true, -- No need for vim's intro message
			c = true, -- Don't give 'ins-completion-menu' messages
			q = true, -- I know what macro I'm recording, thank you
		}

		-- Scrolling
		vim.opt.scrolloff     = 10 -- 10 lines to the cursor vertically
		vim.opt.sidescrolloff = 15 -- ... and 15 charactors horizontally
		vim.opt.sidescroll    = 1 -- Minimal number of columns to scroll horizontally

		-- The emoji setting is true by default but makes NeoVim
		-- treat all emoji characters as double width which breaks
		-- rendering. This is turned off to avoid said breakages.
		vim.opt.emoji = false

		vim.opt.virtualedit = 'block' -- Allow cursor to move freely in visual block mode
	end
}
return {
	---saner `ctrl-l`
	---https://github.com/mhinz/vim-galore#saner-ctrl-l
	setup = function ()
		vim.keymap.set('n', '<C-l>', ':nohlsearch<CR>:diffupdate<CR>')
	end
}

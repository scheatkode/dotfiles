local function setup()
	local harpoonui   = require('harpoon.ui')
	local harpoonmark = require('harpoon.mark')

	local function nav_file(n)
		return function() harpoonui.nav_file(n) end
	end

	vim.keymap.set('n', '<leader>hh', harpoonui.toggle_quick_menu, { desc = 'Open harpoon window' })
	vim.keymap.set('n', '<leader>ha', harpoonmark.add_file,        { desc = 'Add file to harpoon' })
	vim.keymap.set('n', '<leader>hn', harpoonui.nav_next,          { desc = 'Harpoon to next' })
	vim.keymap.set('n', '<leader>hp', harpoonui.nav_prev,          { desc = 'Harpoon to previous' })

	vim.keymap.set('n', '<leader>h1', nav_file(1), { desc = 'Harpoon to file 1' })
	vim.keymap.set('n', '<leader>h2', nav_file(2), { desc = 'Harpoon to file 2' })
	vim.keymap.set('n', '<leader>h3', nav_file(3), { desc = 'Harpoon to file 3' })
	vim.keymap.set('n', '<leader>h4', nav_file(4), { desc = 'Harpoon to file 4' })
	vim.keymap.set('n', '<leader>h5', nav_file(5), { desc = 'Harpoon to file 5' })
	vim.keymap.set('n', '<leader>h6', nav_file(6), { desc = 'Harpoon to file 6' })
	vim.keymap.set('n', '<leader>h7', nav_file(7), { desc = 'Harpoon to file 7' })
	vim.keymap.set('n', '<leader>h8', nav_file(8), { desc = 'Harpoon to file 8' })
	vim.keymap.set('n', '<leader>h9', nav_file(9), { desc = 'Harpoon to file 9' })
end

return {
	setup = setup
}

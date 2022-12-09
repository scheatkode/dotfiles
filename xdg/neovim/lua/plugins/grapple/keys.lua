return {
	setup = function()
		local grapple = require('grapple')

		local function nav_file(n)
			return function() grapple.select({ key = n }) end
		end

		vim.keymap.set('n', '<leader>hh', grapple.popup_tags, {
			desc = 'Open the grappling window',
		})

		vim.keymap.set('n', '<leader>ha', grapple.tag, {
			desc = 'Add a grappling anchor',
		})

		vim.keymap.set('n', '<leader>hd', grapple.untag, {
			desc = 'Delete the current grappling anchor',
		})

		vim.keymap.set('n', '<leader>hq', grapple.quickfix, {
			desc = 'List the stored grappling anchors in the quickfix window',
		})

		vim.keymap.set('n', '<leader>h1', nav_file(1), { desc = 'Grapple to file 1' })
		vim.keymap.set('n', '<leader>h2', nav_file(2), { desc = 'Grapple to file 2' })
		vim.keymap.set('n', '<leader>h3', nav_file(3), { desc = 'Grapple to file 3' })
		vim.keymap.set('n', '<leader>h4', nav_file(4), { desc = 'Grapple to file 4' })
		vim.keymap.set('n', '<leader>h5', nav_file(5), { desc = 'Grapple to file 5' })
		vim.keymap.set('n', '<leader>h6', nav_file(6), { desc = 'Grapple to file 6' })
		vim.keymap.set('n', '<leader>h7', nav_file(7), { desc = 'Grapple to file 7' })
		vim.keymap.set('n', '<leader>h8', nav_file(8), { desc = 'Grapple to file 8' })
		vim.keymap.set('n', '<leader>h9', nav_file(9), { desc = 'Grapple to file 9' })
	end
}

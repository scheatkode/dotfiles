local function setup()
	vim.keymap.set('n', '<F1>', '<cmd>Neotree<CR>', { desc = 'Toggle file explorer' })
end

return {
	setup = setup
}

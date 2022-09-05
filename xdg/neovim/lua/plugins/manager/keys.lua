local function setup()
	local has_packer, packer = pcall(require, 'packer')

	if not has_packer then
		error('Expected packer to be installed')
	end

	vim.keymap.set('n', '<leader>Pc', packer.compile)
	vim.keymap.set('n', '<leader>PC', packer.clean)
	vim.keymap.set('n', '<leader>Pi', packer.install)
	vim.keymap.set('n', '<leader>PI', packer.install)
	vim.keymap.set('n', '<leader>Pu', packer.update)
	vim.keymap.set('n', '<leader>PU', packer.update)
	vim.keymap.set('n', '<leader>Ps', packer.status)

	vim.keymap.set('n', '<leader>PS', function()
		packer.snapshot(os.date('!%Y-%m-%d_%T'))
		packer.sync()
	end)
end

return {
	setup = setup
}

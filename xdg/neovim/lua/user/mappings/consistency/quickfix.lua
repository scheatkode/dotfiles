return {
   ---setup quickfix toggle. internally sets up autocommands  to
   ---follow the quickfix window  state  as  well  to  keep  the
   ---functionality consistent.
	setup = function()
		local qf_is_open = false

		local function toggle_quickfix()
			if qf_is_open then
				vim.cmd('cclose')
				return
			end

			vim.cmd('copen')
		end

		local augroup = vim.api.nvim_create_augroup('QuickFixToggle', { clear = true })

		vim.api.nvim_create_autocmd('BufWinEnter', {
			group    = augroup,
			pattern  = 'quickfix',
			callback = function() qf_is_open = true end,
		})

		vim.api.nvim_create_autocmd('BufWinLeave', {
			group    = augroup,
			callback = function() qf_is_open = false end,
		})

		vim.keymap.set('n', '<leader>qf', toggle_quickfix, { desc = 'Toggle quickfix list' })
		vim.keymap.set('n', '<leader>qo', '<cmd>copen<CR>', { desc = 'Open quickfix list' })

		vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Go to next quickfix item' })
		vim.keymap.set('n', '[q', '<cmd>cprevious<CR>', { desc = 'Go to previous quickfix item' })
	end
}

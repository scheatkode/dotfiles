return {
	setup = function()
		local lazy      = require('load.on_member_call')
		local ok, hydra = pcall(require, 'hydra')

		if not ok then
			require('log').error('Tried loading plugin ... unsuccessfully ‼', 'hydra')
			return ok
		end

		hydra({
			name  = 'Side scroll',
			mode  = 'n',
			body  = 'z',
			heads = {
				{ 'h', '5zh' },
				{ 'l', '5zl', { desc = '←/→' } },
				{ 'H', 'zH' },
				{ 'L', 'zL', { desc = 'half screen ←/→' } },
			},
		})

		hydra({
			name  = 'Window resizing',
			mode  = 'n',
			body  = '<C-w>',
			heads = {
				{ '<', '5<C-w><' },
				{ '>', '5<C-w>>', { desc = '5 × ←/→' } },
				{ ',', '<C-w><' },
				{ '.', '<C-w>>', { desc = '←/→' } },
				{ '+', '5<C-w>+' },
				{ '-', '5<C-w>-', { desc = '5 × ↑/↓' } },
			},
		})

		local dap   = lazy('dap')
		local dapui = lazy('dapui')

		hydra({
			name   = 'Debug',
			body   = '<leader>D',
			config = {
				color = 'pink',
				invoke_on_body = true,
				hint = {
					type = 'window',
					position = 'top',
					border = 'rounded'
				},
				on_enter = function()
					dap.continue()
					dapui.open({})
				end,
				on_exit = function()
					dap.clear_breakpoints()
					dapui.close({})
				end,
			},
			heads  = {
				{ 'C', dap.continue, { desc = 'continue' } },
				{ '-', dap.toggle_breakpoint, { desc = 'toggle breakpoint' } },
				{ 'I', dap.step_into, { desc = 'step into' } },
				{ 'O', dap.step_over, { desc = 'step over' } },
				{ 'K', dapui.eval, { desc = 'evaluate variable' } },
				{ 'q', dap.terminate, { desc = 'terminate', exit = true } },
			}
		})
	end,
}

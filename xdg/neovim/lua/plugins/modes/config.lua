return {
	setup = function()
		local ok, hydra = pcall(require, 'hydra')

		if not ok then
			require('log').error('Tried loading plugin ... unsuccessfully ‼', 'null-ls')
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
			name = 'Window resizing',
			mode = 'n',
			body = '<C-w>',
			heads = {
				{ '<', '5<C-w><' },
				{ '>', '5<C-w>>', { desc = '5 × ←/→' } },
				{ ',', '<C-w><' },
				{ '.', '<C-w>>', { desc = '←/→' } },
				{ '+', '5<C-w>+' },
				{ '-', '5<C-w>-', { desc = '5 × ↑/↓' } },
			},
		})
	end
}

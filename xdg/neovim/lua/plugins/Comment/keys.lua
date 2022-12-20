return {
	setup = function()
		local constant = require('f.function.constant')
		local when     = require('f.function.when')

		---Return `consequence` when no count is given,
		---`alternative` otherwise.
		local function whether(consequence, alternative)
			return when(function()
				return vim.v.count == 0
			end, constant(consequence), constant(alternative))
		end

		-- toggle in normal mode
		vim.keymap.set(
			'n',
			'<leader>/',
			whether(
				'<Plug>(comment_toggle_linewise_current)',
				'<Plug>(comment_toggle_linewise_count)'
			),
			{
				desc  = 'Comment current line(s)',
				expr  = true,
				remap = true,
			}
		)

		vim.keymap.set(
			'n',
			'gcc',
			whether(
				'<Plug>(comment_toggle_linewise_current)',
				'<Plug>(comment_toggle_linewise_count)'
			),
			{
				desc  = 'Comment current line(s)',
				expr  = true,
				remap = true,
			}
		)

		vim.keymap.set(
			'n',
			'gbc',
			whether(
				'<Plug>(comment_toggle_linewise_blockwise)',
				'<Plug>(comment_toggle_blockwise_count)'
			),
			{
				desc  = 'Comment current line(s)',
				expr  = true,
				remap = true,
			}
		)

		-- toggle in operator pending mode
		vim.keymap.set(
			'n',
			'<leader>//',
			'<Plug>(comment_toggle_linewise)',
			{ remap = true }
		)
		vim.keymap.set(
			'n',
			'gc',
			'<Plug>(comment_toggle_linewise)',
			{ remap = true }
		)
		vim.keymap.set(
			'n',
			'gb',
			'<Plug>(comment_toggle_blockwise)',
			{ remap = true }
		)

		-- toggle in visual mode
		vim.keymap.set(
			'x',
			'<leader>/',
			'<Plug>(comment_toggle_linewise_visual)',
			{
				remap = true,
				desc = 'Comment lines',
			}
		)
		vim.keymap.set('x', 'gc', '<Plug>(comment_toggle_linewise_visual)', {
			remap = true,
			desc  = 'Comment lines',
		})
		vim.keymap.set('x', 'gb', '<Plug>(comment_toggle_blockwise_visual)', {
			remap = true,
			desc  = 'Comment lines',
		})
	end,
}

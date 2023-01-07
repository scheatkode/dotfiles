return {
	setup = function()
		local signature = require('lsp_signature')

		vim.keymap.set({ 'i', 's' }, '<M-s>', signature.toggle_float_win, {
			desc = 'Toggle signature help',
		})

		vim.keymap.set({ 'i' }, '<M-n>', function()
			return signature.signature({ trigger = 'NextSignature' })
		end, {
			desc = 'Cycle signature help overloads',
		})
	end,
}

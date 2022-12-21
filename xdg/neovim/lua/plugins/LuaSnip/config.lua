return {
	setup = function()
		local snippets = require('luasnip')
		local types    = require('luasnip.util.types')

		snippets.config.set_config({
			history = false,

			delete_check_events = 'InsertLeave',
			region_check_events = 'InsertEnter',
			update_events       = 'TextChanged,TextChangedI',

			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { ' ⇋ ', 'DiagnosticWarn' } },
						hl_mode = 'combine',
					},
				},
				[types.insertNode] = {
					active = {
						virt_text = { { ' ⇁ ', 'DiagnosticInfo' } },
						hl_mode = 'combine',
					},
				},
			},
		})

		require('snip').setup()
	end,
}

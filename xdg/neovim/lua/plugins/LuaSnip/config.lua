return {
	setup = function()
		local snippets = require('luasnip')
		local types    = require('luasnip.util.types')

		local ft_func = require('luasnip.extras.filetype_functions')

		snippets.config.set_config({
			history = false,

			delete_check_events = 'InsertLeave',
			region_check_events = 'InsertEnter',
			update_events       = 'TextChanged,TextChangedI',

			load_ft_func = ft_func.extend_load_ft({
				svelte     = { 'css', 'html', 'typescript' },
				typescript = { 'javascript' },
			}),

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

		require('luasnip.loaders.from_lua').lazy_load({
			paths = { './snippets' },
		})
	end,
}

return {
	setup = function()
		local ok, snippets = pcall(require, 'luasnip')

		if not ok then
			require('log').error('Tried loading plugin ... unsuccessfully ‼', 'luasnip')
			return ok
		end

		local types = require('luasnip.util.types')

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

		for _, ft in ipairs(vim.api.nvim_get_runtime_file('lua/plugins/snippets/*/init.lua', true)) do
			loadfile(ft)().setup()
		end
	end
}

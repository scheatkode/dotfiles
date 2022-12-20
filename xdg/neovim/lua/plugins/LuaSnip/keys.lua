return {
	setup = function()
		local snippet = require('luasnip')

		local function choice()
			if snippet.choice_active() then
				snippet.change_choice(1)
			end
		end

		vim.keymap.set({ 'i' }, '<M-CR>', snippet.expand_or_jump, {
			desc = 'Expand current snippet or jump',
		})
		vim.keymap.set({ 'i', 's' }, '<M-e>', choice, {
			desc = 'Toggle a choice node',
		})
	end,
}

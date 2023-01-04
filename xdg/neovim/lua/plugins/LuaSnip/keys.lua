return {
	setup = function()
		local snippets = require('luasnip')

		local function choice()
			if snippets.choice_active() then
				snippets.change_choice(1)
			end
		end

		local function jump(direction)
			return function()
				if snippets.in_snippet() and snippets.jumpable(direction) then
					return snippets.jump(direction)
				end
			end
		end

		vim.keymap.set({ 'i' }, '<M-CR>', snippets.expand_or_jump, {
			desc = 'Expand current snippet or jump',
		})
		vim.keymap.set({ 'i', 's' }, '<M-e>', choice, {
			desc = 'Toggle a choice node',
		})
		vim.keymap.set({ 'i', 's' }, '<C-a>', jump(1), { -- mnemonic for "after"
			desc = 'Jump to next snippet node',
		})
		vim.keymap.set({ 'i', 's' }, '<C-b>', jump(-1), { -- mnemonic for "before"
			desc = 'Jump to previous snippet node',
		})
	end,
}

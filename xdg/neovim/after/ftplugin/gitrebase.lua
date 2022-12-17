local function with_count(command)
	return function()
		return string.format(
			[[<cmd>.,.+%s%s<CR>]],
			vim.v.count1 - 1,
			command
		)
	end
end

vim.keymap.set('n', '<Tab>', '<cmd>Cycle<CR>', {
	desc   = 'Cycle commit action',
	buffer = 0,
})

vim.keymap.set('n', 'ge', with_count('Edit'), {
	desc   = 'Edit commit',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('n', 'gf', with_count('Fixup'), {
	desc   = 'Fixup commit',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('n', 'gp', with_count('Pick'), {
	desc   = 'Pick commit',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('n', 'gr', with_count('Reword'), {
	desc   = 'Reword commit',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('n', 'gs', with_count('Squash'), {
	desc   = 'Squash commit',
	buffer = 0,
	expr   = true,
})

local function with_range(command)
	return function()
		return string.format(
			[[<cmd>%s,%s%s<CR><Esc>]],
			vim.fn.getpos('v')[2],
			vim.fn.getcurpos('.')[2],
			command
		)
	end
end

vim.keymap.set('x', 'ge', with_range('Edit'), {
	desc   = 'Edit selected commits',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('x', 'gf', with_range('Fixup'), {
	desc   = 'Fixup selected commits',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('x', 'gp', with_range('Pick'), {
	desc   = 'Pick selected commits',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('x', 'gr', with_range('Reword'), {
	desc   = 'Reword selected commits',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('x', 'gs', with_range('Squash'), {
	desc   = 'Squash commits',
	buffer = 0,
	expr   = true,
})

vim.keymap.set('n', '<C-j>',
	function()
		vim.cmd.move({
			args = { '.+' .. vim.v.count1 },
			mods = { emsg_silent = true },
		})
	end,
	{ buffer = 0, desc = 'Swap current line with the one below' }
)

vim.keymap.set('n', '<C-k>',
	function()
		vim.cmd.move({
			args = { '.-' .. vim.v.count1 + 1 },
			mods = { emsg_silent = true },
		})
	end,
	{ buffer = 0, desc = 'Swap current line with the one above' }
)

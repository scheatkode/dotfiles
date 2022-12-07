local function with_count(command)
	return function()
		return string.format(
			'<Cmd>.,.+%s%s<CR>',
			vim.v.count1 - 1,
			command
		)
	end
end

vim.keymap.set('n', '<Tab>', '<Cmd>Cycle<CR>', {
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
			[[<Cmd>%s,%s%s<CR><Esc>]],
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

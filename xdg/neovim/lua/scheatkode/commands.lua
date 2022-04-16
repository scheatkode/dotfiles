local function setup ()
	-- delete all open buffers.
	--
	-- this avoids  using `bufdo` to delete  buffers as per
	-- its documentation and uses  the `%` operator instead
	-- while also deleting the `[No name]` buffer that gets
	-- created.
	vim.api.nvim_create_user_command(
		'BufOnly',
		'silent! execute "%bdelete|edit#|bdelete#"',
		{}
	)

	-- jump to a random line.
	vim.api.nvim_create_user_command(
		'RandomLine',
		[[execute 'normal! '.(matchstr(system('od -vAn -N3 -tu4 /dev/urandom'), '^\_s*\zs.\{-}\ze\_s*$') % line('$')).'G']],
		{}
	)
end

return {
	setup = setup
}

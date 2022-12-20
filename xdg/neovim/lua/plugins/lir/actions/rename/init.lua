return function()
	local context  = require('lir').get_context()
	local old_name = string.gsub(context:current_value(), '/$', '')
	local new_name = vim.fn.input('Rename: ', old_name)

	if new_name == '' or new_name == old_name then
		return
	end

	if new_name == '.'
		 or new_name == '..'
		 -- it looks like a spaceship :D
		 or string.match(new_name, [=[[/\]]=])
	then
		error('Invalid name: ' .. new_name)
	end

	if not vim.loop.fs_rename(
		context.dir .. old_name,
		context.dir .. new_name
	) then
		error('Could not rename ' .. old_name)
	end

	require('lir.actions').reload()

	local lnum = context:indexof(new_name)
	if lnum then
		vim.cmd(tostring(lnum))
	end
end

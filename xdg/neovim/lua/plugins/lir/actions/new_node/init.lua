local function action(name)
	if name == nil or name == '' then
		return
	end

	if name == '.' or name == '..' then
		error('Invalid file name: ', name)
	end

	local lir     = require('lir')
	local context = lir.get_context()
	local path    = require('plenary.path'):new(context.dir .. name)

	if string.match(name, '/$') then
		name = name:gsub('/$', '')
		path:mkdir({ parents = true, exists_ok = false })
	else
		path:touch({ parents = true })
	end

	-- if the first character is '.' and `show_hidden_files` is
	-- false, set it to true.
	if name:match('^%.') and not lir.config.values.show_hidden_files then
		lir.config.values.show_hidden_files = true
	end

	require('lir.actions').reload()

	-- jump to a line in the parent directory of the created file.
	local l = context:indexof(name:match('^[^/]+'))
	if l then
		vim.cmd(tostring(l))
	end
end

return function()
	vim.ui.input(
		{
			completion = 'file',
			prompt     = 'New file: ',
		},
		action
	)
end

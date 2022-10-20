local f      = require('f')
local pipe   = require('f.function.pipe')
local extend = require('tablex.extend')

local builtin = require('telescope.builtin')


return function(options)
	options = options or {}

	--- `buf_get_clients()` most likely won't return a contiguous list. This
	--- gets the most "generic" LSP client for the current buffer, using a dumb
	--- string length comparison of the `root_dir` property.
	local clients = f
		 .iterate(vim.lsp.buf_get_clients())
		 :filter(function( x)
		    return x and x.config ~= nil
		 end)

	local has_clients, client = pcall(
		f.minimum_by,
		function(x, y)
			return #x.config.root_dir < #y.config.root_dir
		end,
		clients
	)

	if has_clients and type(client) ~= 'boolean' then
		return pipe(
			extend(
				{
					---@diagnostic disable-next-line: undefined-field
					cwd          = client.config.root_dir,
					prompt_title = 'Find Files in Project',
				},
				options
			),
			builtin.find_files
		)
	end

	local git_dir = vim.fn.finddir('.git', ';')

	if git_dir ~= '' then
		local git_root = vim.fn.fnamemodify(git_dir, ':h')

		return pipe(
			extend(
				{
					prompt_title = 'Find Files in Repository',
					cwd          = git_root,
				},
				options
			),
			builtin.find_files
		)
	end

	return builtin.find_files(options)
end

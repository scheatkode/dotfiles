local pipe    = require('f.function.pipe')
local extend  = require('tablex.extend')
local builtin = require('telescope.builtin')

return function(options)
	options = options or {}

	return pipe(
		extend(
			{
				prompt_title = ' Notes ',
				cwd          = '~/brain/',
			},
			options
		),
		builtin.find_files
	)
end

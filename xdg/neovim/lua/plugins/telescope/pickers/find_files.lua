local pipe    = require('f.function.pipe')
local extend  = require('tablex.extend')
local builtin = require('telescope.builtin')

return function(options)
	options = options or {}

	options.hidden    = options.hidden or false
	options.no_ignore = options.no_ignore or false

	local prompt_title

	if options.hidden and options.no_ignore then
		prompt_title = 'Find Hidden & Ignored Files'
	elseif options.hidden then
		prompt_title = 'Find Hidden Files'
	elseif options.no_ignore then
		prompt_title = 'Find Ignored Files'
	else
		prompt_title = 'Find Files'
	end

	return pipe(
		extend({ prompt_title = prompt_title }, options),
		builtin.find_files
	)
end

local pipe = require("f.function.pipe")
local extend = require("tablex.extend")
local builtin = require("telescope.builtin")

return function(options)
	options = options or {}
	options.grep_open_files = options.grep_open_files or false

	return pipe(
		extend({
			max_results = 50,
			prompt_title = options.grep_open_files and "Live Grep Open Files"
				or "Live Grep",
		}, options),
		builtin.live_grep
	)
end

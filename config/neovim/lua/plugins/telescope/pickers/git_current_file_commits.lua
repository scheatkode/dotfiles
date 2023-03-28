local pipe = require("f.function.pipe")
local extend = require("tablex.extend")
local builtin = require("telescope.builtin")

return function(options)
	options = options or {}

	return pipe(
		extend({ prompt_title = "Git Commits involving Current File" }, options),
		builtin.git_bcommits
	)
end

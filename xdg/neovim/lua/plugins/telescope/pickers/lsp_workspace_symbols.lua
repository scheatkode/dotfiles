local pipe = require("f.function.pipe")
local extend = require("tablex.extend")

local builtin = require("telescope.builtin")

return function(options)
	options = options or {}

	return pipe(
		extend({ show_line = true }, options),
		builtin.lsp_workspace_symbols
	)
end

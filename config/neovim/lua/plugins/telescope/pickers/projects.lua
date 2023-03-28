local pipe = require("f.function.pipe")
local extend = require("tablex.extend")

local telescope = require("telescope")

return function(options)
	options = options or {}

	return pipe(
		extend({
			display_type = "full",
			layout_stategy = "vertical",
			layout_config = {
				width = function(_, max_columns, _)
					return math.min(max_columns, 90)
				end,
				height = function(_, _, max_lines)
					return math.min(max_lines, 40)
				end,
			},
		}, options),
		telescope.extensions.project.project
	)
end

local lazy = require('lazy.on_module_call')
local deep_extend = lazy('tablex.deep_extend')

local function get_vertical(options)
	local defaults = {
		layout_strategy = 'vertical',
		sorting_strategy = 'descending',
		results_title = false,

		layout_config = {
			prompt_position = 'bottom',
			preview_cutoff = 1,

			width = function(_, max_columns, _)
				return math.min(max_columns, 90)
			end,

			height = function(_, _, max_lines)
				return math.min(max_lines, 40)
			end,
		},
	}

	return deep_extend('force', defaults, options or {})
end

local function get_command(options)
	local defaults = {
		layout_strategy = 'vertical',
		sorting_strategy = 'descending',
		results_title = false,

		layout_config = {
			prompt_position = 'top',
			preview_cutoff = 1,

			width = function(_, max_columns, _)
				return math.min(max_columns, 80)
			end,

			height = function(_, _, max_lines)
				return math.min(max_lines, 15)
			end,
		},
	}

	return deep_extend('force', defaults, options or {})
end

return {
	get_command = get_command,
	get_vertical = get_vertical,
}

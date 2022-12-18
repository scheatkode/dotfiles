local mmin   = math.min
local themes = require('telescope.themes')

function themes.get_vertical(opts)
	opts = opts or {}

	local theme_opts = {
		layout_strategy  = 'vertical',
		sorting_strategy = 'descending',
		results_title    = false,

		layout_config = {
			prompt_position = 'bottom',
			preview_cutoff  = 1,

			width = function(_, max_columns, _)
				return mmin(max_columns, 90)
			end,

			height = function(_, _, max_lines)
				return mmin(max_lines, 40)
			end,
		},
	}

	return vim.tbl_deep_extend('force', theme_opts, opts)
end

function themes.get_better_cursor(opts)
	opts = opts or {}

	local theme_opts = {
		layout_strategy  = 'cursor',
		sorting_strategy = 'ascending',
		results_title    = false,

		layout_config = {
			prompt_position = 'bottom',
			preview_cutoff  = 1,

			width = function(_, max_columns, _)
				return mmin(max_columns, 80)
			end,

			height = function(_, _, max_lines)
				return mmin(max_lines, 7)
			end,
		},
	}

	return vim.tbl_deep_extend('force', theme_opts, opts)
end

local function get_command(options)
	local lazy = require('lazy.on_module_call')
	local deep_extend = lazy('tablex.deep_extend')

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
	get_vertical = themes.get_vertical,
}

local pipe = require("f.function.pipe")
local extend = require("tablex.extend")

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local themes = require("plugins.telescope.themes")

return function(options)
	options = options or {}

	options.show_all_buffers = options.show_all_buffers or false

	return pipe(
		extend({
			ignore_current_buffer = true,
			sort_lastused = true,

			attach_mappings = function(_, map)
				map("i", "<C-x>", actions.delete_buffer)
				map("n", "<C-x>", actions.delete_buffer)

				return true
			end,
		}, options),
		themes.get_vertical,
		builtin.buffers
	)
end

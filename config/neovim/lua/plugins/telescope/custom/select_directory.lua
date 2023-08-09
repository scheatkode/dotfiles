return function(operation)
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	return function()
		local current_line = action_state.get_current_line()

		telescope.extensions.file_browser.file_browser({
			depth = false,
			files = false,
			attach_mappings = function()
				actions.select_default:replace(function()
					local entry_path = action_state.get_selected_entry().Path
					local directory = entry_path:is_dir() and entry_path
						or entry_path:parent()

					local absolute = directory:absolute()
					local relative = directory:make_relative(vim.loop.cwd())

					operation({
						cwd = absolute,
						default_text = current_line,
						results_title = relative .. "/",
					})
				end)

				return true
			end,
		})
	end
end

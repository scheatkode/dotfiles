---@class PickProcessOptions
---@field prompt_title string
---@field command table

---Creates a function that, when called, starts a Telescope
---picker if Telescope is loaded to select a running process.
---@param options? PickProcessOptions
---@return function
return function(options)
	local extend = require("tablex.extend")

	local defaults = {
		prompt_title = "Select a process to debug",
		command = { "ps", "ah" },
	}

	local settings = extend(defaults, options or {})

	return function()
		if not package.loaded["telescope"] then
			return require("dap.utils").pick_process()
		end

		return coroutine.create(function(co)
			local opts = {}

			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local config = require("telescope.config").values
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			pickers
				.new(opts, {
					prompt_title = settings.prompt_title,
					finder = finders.new_oneshot_job(settings.command, opts),
					sorter = config.generic_sorter(opts),
					attach_mappings = function(bufnr)
						actions.select_default:replace(function()
							actions.close(bufnr)
							coroutine.resume(
								co,
								action_state.get_selected_entry()[1]
							)
						end)

						return true
					end,
				})
				:find()
		end)
	end
end

return {
	setup = function()
		local has_porcelain, porcelain = pcall(require, 'neogit')

		if not has_porcelain then
			vim.notify('neogit: Tried loading plugin ... unsuccessfully ‼', vim.log.levels.warn)
			return has_porcelain
		end

		porcelain.setup({
			disable_builtin_notifications = false,
			disable_commit_confirmation   = true,
			disable_context_highlighting  = false,
			disable_hint                  = false,
			disable_signs                 = false,

			auto_refresh = true,

			commit_popup = {
				kind = 'split',
			},

			kind = 'tab',

			signs = {
				section = { '', '' },
				item    = { '', '' },
				hunk    = { '', '' },
			},

			integrations = {
				diffview = true,
			},

			mappings = {
				status = {
					-- staging
					['S']  = '',
					['s']  = '',
					['gs'] = 'Stage',

					-- popups
					['p'] = 'PushPopup',
					['F'] = 'PullPopup',
				}
			}
		})

		vim.notify('neogit: Plugin loaded', vim.log.levels.info)

		return true
	end
}

return {
	setup = function()
		local neorg = require('neorg')

		neorg.setup({
			load = {
				['core.defaults'] = {},

				['core.norg.esupports.metagen'] = {
					config = {
						type = 'auto',
					},
				},

				['core.norg.concealer'] = {
					config = {
						icons = {
							heading = {
								level_1 = { enabled = true, icon = '█' },
								level_2 = { enabled = true, icon = '██' },
								level_3 = { enabled = true, icon = '███' },
								level_4 = { enabled = true, icon = '████' },
								level_5 = { enabled = true, icon = '█████' },
								level_6 = {
									enabled = true,
									icon = '██████',
								},
							},
							todo = {
								enable = true,
								pending = {
									icon = '',
								},
								uncertain = {
									icon = '?',
								},
								urgent = {
									icon = '',
								},
								on_hold = {
									icon = '',
								},
								cancelled = {
									icon = '',
								},
							},
						},
					},
				},

				['core.keybinds'] = {
					config = {
						default_keybinds = false,
						neorg_leader = '<leader>o',
					},
				},

				['core.norg.dirman'] = {
					config = {
						workspaces = {
							brain = '~/brain',
						},
					},
				},

				['core.norg.completion'] = {
					config = {
						engine = 'nvim-cmp',
					},
				},

				['core.norg.qol.toc'] = {
					config = {
						close_split_on_jump = false,
						toc_split_placement = 'right',
					},
				},

				['core.export'] = {},
				['core.export.markdown'] = {},
			},

			hook = function()
				-- This sets the leader for all Neorg keybinds. It is separate from the
				-- regular <Leader>, And allows you to shove every Neorg keybind under
				-- one "umbrella".
				local neorg_leader = '<Leader>n'

				-- Require the user callbacks module, which allows us to tap into the core of
				-- Neorg.
				-- local has_neorg, neorg = pcall(require, 'neorg')
				local neorg_callbacks = require('neorg.callbacks')

				-- Listen for the `enable_keybinds` event, which signals a `ready` state
				-- meaning we can bind keys. This hook will be called several times,
				-- e.g. whenever the Neorg Mode changes or an event that needs to
				-- reevaluate all the bound keys is invoked.
				neorg_callbacks.on_event(
					'core.keybinds.events.enable_keybinds',
					function(_, keybinds)
						-- Map all the below keybinds only when the 'norg' mode is active.
						keybinds.map_event_to_mode('norg', {
							n = { -- Bind keys in normal mode.

								-- Keys for managing `TODO` items and setting their states.
								{
									'gtu',
									'core.norg.qol.todo_items.todo.task_undone',
								},
								{
									'gtp',
									'core.norg.qol.todo_items.todo.task_pending',
								},
								{ 'gtd', 'core.norg.qol.todo_items.todo.task_done' },
								{
									'gth',
									'core.norg.qol.todo_items.todo.task_on_hold',
								},
								{
									'gtc',
									'core.norg.qol.todo_items.todo.task_cancelled',
								},
								{
									'gtr',
									'core.norg.qol.todo_items.todo.task_recurring',
								},
								{
									'gti',
									'core.norg.qol.todo_items.todo.task_important',
								},
								{
									'<C-Space>',
									'core.norg.qol.todo_items.todo.task_cycle',
								},

								-- Keys for managing GTD
								{ neorg_leader .. 'c', 'core.gtd.base.capture' },
								{ neorg_leader .. 'v', 'core.gtd.base.views' },
								{ neorg_leader .. 'e', 'core.gtd.base.edit' },

								{ '<CR>', 'core.norg.esupports.hop.hop-link' },
								{
									'<M-CR>',
									'core.norg.esupports.hop.hop-link',
									'vsplit',
								},
							},
						}, { silent = true, noremap = true })
					end
				)
			end,
		})
	end,
}

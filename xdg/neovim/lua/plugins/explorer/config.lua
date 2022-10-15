local function setup()
	local has_tree, tree = pcall(require, 'neo-tree')

	if not has_tree then
		print('Tried loading plugin ... unsuccessfully ‼', 'neo-tree')
		return has_tree
	end

	tree.setup({
		---close neo-tree if it is the last window left in the tab
		---@type boolean
		close_if_last_window = false,

		---@type boolean
		close_floats_on_escape_key = true,

		---@type 'filesystem' | 'buffers' | 'git_status'
		default_source = 'filesystem',

		---@type boolean
		enable_diagnostics = true,

		---@type boolean
		enable_git_status = true,

		---show markers for files with unsaved changes.
		---@type boolean
		enable_modified_markers = true,

		---refresh the tree when a file is written. only used if
		---`use_libuv_file_watcher` is false.
		---@type boolean
		enable_refresh_on_write = true,

		---@type boolean
		git_status_async = true,

		-- these options are for people with very large git repos.
		git_status_async_options = {

			-- how many lines of git status results to process at
			-- a time.
			---@type number
			batch_size = 1000,

			---delay in ms between batches. spreads out the workload
			---to let other processes run.
			---@type number
			batch_delay = 10,

			---how many lines of git status results to process.
			---anything after this will be dropped. anything before
			---this will be used. the last items to be processed are
			---the untracked files.
			---@type number
			max_lines = 10000,

		},

		---@type 'trace'|'debug'|'info'|'warn'|'error'|'fatal'
		log_level = 'info',

		---use `:NeoTreeLogs` to show the file.
		---@type boolean|string
		log_to_file = false,

		---when false, will open files in the top left window.
		---@type boolean
		open_files_in_last_window = true,

		---`popup_border_style` is for input and confirmation dialogs.
		---configuration of floating window is done in the individual
		---source sections. `NC` is a special style that works well
		---with `NormalNC` set.
		---@type 'double'|'none'|'rounded'|'shadow'|'single'|'solid'
		popup_border_style = 'NC',

		---in ms, needed for containers to redraw right aligned and
		---faded content set to -1 to disable the resize timer
		---entirely.
		---NOTE: this will speed up to 50 ms for 1 second following
		---a resize.
		---@type number
		resize_timer_interval = 500,

		---used when sorting files and directories in the tree.
		---@type boolean
		sort_case_insensitive = false,

		---if false, inputs will use `vim.ui.input()` instead of
		---custom floats.
		---@type boolean
		use_popups_for_input = true,

		---@type boolean
		use_default_mappings = false,

		event_handlers = { {
			event = 'file_opened',
			---auto close
			handler = function()
				require('neo-tree').close_all()
			end
		}, {
			event   = 'file_renamed',
			handler = function(args)
				print(args.source, ' renamed to ', args.destination)
			end
		}, {
			event   = 'file_moved',
			handler = function(args)
				print(args.source, ' moved to ', args.destination)
			end
		} },

		default_component_configs = {
			container = {
				---@type boolean
				enable_character_fade = true
			},

			indent = {
				---@type number
				indent_size = 3,

				---@type number
				padding = 1,

				-- indent guides

				---@type boolean
				with_markers = true,

				---@type string
				indent_marker = '│',

				---@type string
				last_indent_marker = '└',

				---@type string
				highlight = 'NeoTreeIndentMarker',

				-- expander config, needed for nesting files

				---if nil and file nesting is enabled, will enable
				--expanders.
				---@type nil|true
				with_expanders = true,

				---@type string
				expander_collapsed = '',

				---@type string
				expander_expanded = '',

				---@type string
				expander_highlight = 'NeoTreeExpander',
			},

			icon = {

				---@type string
				folder_closed = '',

				---@type string
				folder_open = '',

				---@type string
				folder_empty = 'ﰊ',

				---the next two settings are only a fallback, if you
				---use `nvim-web-devicons` and configure default icons
				---there then these will never be used.
				---@type string
				default = '*',

				---@type string
				highlight = 'NeoTreeFileIcon'
			},

			modified = {

				---@type string
				symbol = '[+]',

				---@type string
				highlight = 'NeoTreeModified',

			},

			name = {

				---@type boolean
				trailing_slash = false,

				---@type boolean
				use_git_status_colors = true,

				---@type string
				highlight = 'NeoTreeFileName',

			},

			git_status = {
				symbols = {

					-- change type
					-- NOTE: you can set any of these to an empty string
					-- to not show them

					added    = '✚',
					deleted  = '✖',
					modified = '',
					renamed  = '',

					-- status type

					untracked = '',
					ignored   = '',
					unstaged  = '',
					staged    = '',
					conflict  = '',

				},

				align = 'right',
			},
		},

		-- The renderer section provides the renderers that will be used to render the tree.
		--   The first level is the node type.
		--   For each node type, you can specify a list of components to render.
		--       Components are rendered in the order they are specified.
		--         The first field in each component is the name of the function to call.
		--         The rest of the fields are passed to the function as the "config" argument.
		renderers = {
			directory = {
				{ 'indent' },
				{ 'icon' },
				{ 'current_filter' },
				{
					'container',
					width = '100%',
					right_padding = 1,
					--max_width = 60,
					content = {
						{ 'name', zindex = 10 },
						-- {
						--   'symlink_target',
						--   zindex = 10,
						--   highlight = 'NeoTreeSymbolicLinkTarget',
						-- },
						{ 'clipboard', zindex = 10 },
						{ 'diagnostics', zindex = 20, errors_only = true, align = 'right' },
					},
				},
			},

			file = {
				{ 'indent' },
				{ 'icon' },
				{
					'container',
					width = '100%',
					right_padding = 1,
					--max_width = 60,
					content = {
						{
							'name',
							use_git_status_colors = true,
							zindex = 10
						},
						-- {
						--   'symlink_target',
						--   zindex = 10,
						--   highlight = 'NeoTreeSymbolicLinkTarget',
						-- },
						{ 'clipboard', zindex = 10 },
						{ 'bufnr', zindex = 10 },
						{ 'modified', zindex = 20, align = 'right' },
						{ 'diagnostics', zindex = 20, align = 'right' },
						{ 'git_status', zindex = 20, align = 'right' },
					},
				},
			},

			message = {
				{ 'indent', with_markers = false },
				{ 'name', highlight = 'NeoTreeMessage' },
			},

			terminal = {
				{ 'indent' },
				{ 'icon' },
				{ 'name' },
				{ 'bufnr' }
			}
		},

		nesting_rules = {},

		-- see https://github.com/muniftanjim/nui.nvim/tree/main/lua/nui/popup
		-- for possible options. these can also be functions that
		-- return these options.
		window = {
			---@type 'left'|'right'|'float'|'current'
			position = 'left',

			---applies to left and right positions.
			---@type number
			width = 40,

			-- settings that apply to float position only.
			popup = {
				size = {
					---@type string
					height = '80%',

					---@type string
					width = '50%',
				},

				---50% means center it.
				---@type string
				position = '50%',

				-- you can also specify border here, if you want a different setting from
				-- the global popup_border_style.
			},

			-- mappings for tree window. see `:h neo-tree-mappings`
			-- for a list of built-in commands. you can also create
			-- your own commands by providing a function instead of
			-- a string.
			mapping_options = {
				noremap = true,
				nowait  = true,
			},

			mappings = {
				['<Tab>'] = 'toggle_node',
				['<CR>']  = 'open',
				['o']     = 'open',
				['<C-s>'] = 'open_split',
				['<C-v>'] = 'open_vsplit',
				['C']     = 'close_node',
				['Z']     = 'close_all_nodes',
				['R']     = 'refresh',

				['a'] = {
					'add',

					-- some commands may take optional config options,
					-- see `:h neo-tree-mappings` for details.
					config = {
						show_path = 'none' -- 'none', 'relative', 'absolute'
					}
				},

				['A']    = 'add_directory', -- also accepts the config.show_path option.
				['dd']    = 'delete',
				['r']    = 'rename',
				['y']    = 'copy_to_clipboard',
				['d']    = 'cut_to_clipboard',
				['p']    = 'paste_from_clipboard',
				['c']    = 'copy', -- takes text input for destination
				['m']    = 'move', -- takes text input for destination
				['q']    = 'close_window',
				['<F1>'] = 'close_window',
				['?']    = 'show_help',
			},
		},

		filesystem = {

			commands = {
				run_command = function(state)
					local path = state.tree:get_node():get_id()
					vim.api.nvim_input(': ' .. path .. '<Home>')
				end
			},

			window = {
				mappings = {
					['H']     = 'toggle_hidden',
					['/']     = 'fuzzy_finder',
					['f']     = 'filter_on_submit',
					['<C-x>'] = 'clear_filter',
					['<BS>']  = 'navigate_up',
					['.']     = 'set_root',
					['[g']    = 'prev_git_modified',
					[']g']    = 'next_git_modified',
					[';']     = 'run_command',
				}
			},

			-- 'auto' means refreshes are async, but it's synchronous
			-- when called from the neotree commands.
			-- 'always' means directory scans are always async.
			-- 'never'  means directory scans are never async.
			async_directory_scan = 'auto',

			---true creates a 2-way binding between vim's cwd and
			---neo-tree's root.
			---@type boolean
			bind_to_cwd = true,

			filtered_items = {

				---when true, they will just be displayed differently
				---than normal items.
				---@type boolean
				visible = false,

				---when true, hidden files will be shown if the root
				---folder is otherwise empty.
				---@type boolean
				force_visible_in_empty_folder = false,

				---when true, the number of hidden items in each folder
				---will be shown as the last entry.
				---@type boolean
				show_hidden_count = false,

				hide_dotfiles   = true,
				hide_gitignored = true,
				hide_hidden     = true, -- only works on Windows for hidden files/directories

				---@type string[]
				hide_by_name = {
					'.DS_Store',
					'thumbs.db',
					'node_modules',
				},

				hide_by_pattern = { -- uses glob style patterns
					--'*.meta'
				},

				-- remains hidden even if visible is toggled to true.
				never_show = {
					'.DS_Store',
					'thumbs.db'
				},

			},

			---`false` means it only searches the tail of a path.
			---`true` will change the filter into a full path search
			---with space as an implicit '.*', so
			---`fi init` will match: `./sources/filesystem/init.lua
			---@type boolean
			find_by_full_path_words = true,

			---when true, empty folders will be grouped together.
			---@type boolean
			group_empty_dirs = false,

			---max number of search results when using filters.
			---@type number
			search_limit = 50,

			---this will find and focus the file in the active buffer
			---every time the current file is changed while the tree
			---is open.
			---@type boolean
			follow_current_file = true,

			---`netrw` disabled, opening a directory opens `neotree`
			---in whatever position is specified in `window.position`.
			---
			--- - 'open_current': netrw disabled, opening a directory
			---                   opens within the window like `netrw`
			---                   would, regardless of `window.position`
			--- - 'disabled':     netrw left alone, `neotree` does not
			---                   handle opening dirs
			---
			---@type 'open_current'|'disabled'
			hijack_netrw_behavior = 'open_default',

			---this will use the os level file watchers to detect
			---changes instead of relying on nvim autocmd events.
			---@type boolean
			use_libuv_file_watcher = false,
		},

		buffers = {

			bind_to_cwd = true,

			---this will find and focus the file in the active buffer
			---every time the current file is changed while the tree
			---is open.
			---@type boolean
			follow_current_file = true,

			---when true, empty directories will be grouped together.
			---@type boolean
			group_empty_dirs = true,

			window = {
				mappings = {
					['<BS>'] = 'navigate_up',
					['.']    = 'set_root',
					['bd']   = 'buffer_delete',
				},
			},

		},

		git_status = {
			window = {
				mappings = {
					['A']  = 'git_add_all',
					['gu'] = 'git_unstage_file',
					['ga'] = 'git_add_file',
					['gr'] = 'git_revert_file',
					['gc'] = 'git_commit',
					['gp'] = 'git_push',
					['gg'] = 'git_commit_and_push',
				},
			},
		},
	})
end

return {
	setup = setup
}

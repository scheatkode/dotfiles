--- telescope configuration

return {
	setup = function()
		local has_telescope, telescope = pcall(require, 'telescope')

		if not has_telescope then
			require('log').error('Tried loading plugin ... unsuccessfully ‼', 'telescope')
			return has_telescope
		end

		local actions    = require('telescope.actions')
		local layout     = require('telescope.actions.layout')
		local previewers = require('telescope.previewers')

		local custom_actions = require('plugins.telescope.custom')
		local custom_pickers = require('plugins.telescope.pickers')

		--- setup {{{1

		telescope.setup({

			--- defaults {{{2

			defaults = {

				file_previewer   = previewers.vim_buffer_cat.new,
				grep_previewer   = previewers.vim_buffer_vimgrep.new,
				qflist_previewer = previewers.vim_buffer_qflist.new,

				entry_prefix    = '  ',
				prompt_prefix   = '❯ ',
				selection_caret = '❯ ',

				initial_mode = 'insert',

				color_devicons = true,

				scroll_strategy    = 'cycle',
				selection_strategy = 'reset',
				sorting_strategy   = 'descending',
				layout_stategy     = 'flex',

				winblend = 5,

				dynamic_preview_title = true,

				path_display = {
					truncate = 2,
				},

				borderchars = { -- rounded corners
					'─', '│', '─', '│', '╭', '╮', '╯', '╰',
				},

				-- borderchars = { -- angled corners
				--    '─', '│', '─', '│', '┌', '┐', '┘', '└',
				-- },

				layout_config = {
					horizontal = {
						width         = { padding = 0.05 },
						height        = { padding = 0.05 },
						preview_width = 0.6
					},

					vertical = {
						width          = { padding = 0.3 },
						height         = { padding = 0.05 },
						preview_height = 0.5
					}
				},

				mappings = {
					i = {
						['<c-h>'] = actions.which_key,

						['<c-j>'] = actions.move_selection_next,
						['<c-k>'] = actions.move_selection_previous,

						['<cr>']  = actions.select_default,
						['<c-v>'] = actions.select_vertical,
						['<c-s>'] = actions.select_horizontal,
						['<c-x>'] = false,

						['<c-n>'] = actions.cycle_history_next,
						['<c-p>'] = actions.cycle_history_prev,

						['<c-u>'] = actions.preview_scrolling_up,
						['<c-d>'] = actions.preview_scrolling_down,

						['<c-q>'] = actions.smart_send_to_qflist + actions.open_qflist,

						['<c-a>'] = actions.toggle_all,
						['<tab>'] = actions.toggle_selection + actions.move_selection_next,

						['<c-t>'] = actions.move_to_top,
						['<c-z>'] = actions.move_to_middle,
						['<c-b>'] = actions.move_to_bottom,

						['<c-c>'] = actions.close,
						['<esc>'] = actions.close,

						['<M-p>'] = layout.toggle_preview
					},

					n = {
						['<c-h>'] = actions.which_key,
						['?']     = actions.which_key,

						['<c-j>'] = actions.move_selection_next,
						['<c-k>'] = actions.move_selection_previous,
						['j']     = actions.move_selection_next,
						['k']     = actions.move_selection_previous,

						['<cr>']  = actions.select_default + actions.center,
						['<c-v>'] = actions.select_vertical,
						['<c-s>'] = actions.select_horizontal,
						['<c-x>'] = false,

						['<c-n>'] = actions.cycle_history_next,
						['<c-p>'] = actions.cycle_history_prev,

						['<c-u>'] = actions.preview_scrolling_up,
						['<c-d>'] = actions.preview_scrolling_down,

						['<c-q>'] = actions.smart_send_to_qflist + actions.open_qflist,

						['<c-a>'] = actions.toggle_all,
						['<tab>'] = actions.toggle_selection + actions.move_selection_next,

						['<c-t>'] = actions.move_to_top,
						['gg']    = actions.move_to_top,
						['<c-z>'] = actions.move_to_middle,
						['zz']    = actions.move_to_middle,
						['<c-b>'] = actions.move_to_bottom,
						['G']     = actions.move_to_bottom,

						['<c-c>'] = actions.close,
						['<esc>'] = actions.close,
						['q']     = actions.close,

						['<M-p>'] = layout.toggle_preview
					},
				},
			},

			--- pickers {{{2

			vimgrep_arguments = (function()
				if vim.fn.executable('rg') then
					return {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
					}
				end

				if vim.fn.executable('grep') then
					return {
						'grep',
						'-I',
						'--with-filename',
						'--line-number',
						'--ignore-case',
						'--recurse',
					}
				end
			end)(),

			file_ignore_patterns = {
				'%.git'
			},

			pickers = {
				find_files = {
					file_ignore_patterns = { '%.png', '%.jpg', '%webp' },
					mappings = {
						i = {
							['<C-f>'] = custom_actions.select_directory(custom_pickers.find_files),
						},
						n = {
							['<C-f>'] = custom_actions.select_directory(custom_pickers.find_files),
						}
					}
				},

				live_grep = {
					mappings = {
						i = {
							['<C-f>'] = custom_actions.select_directory(custom_pickers.live_grep),
						},
						n = {
							['<C-f>'] = custom_actions.select_directory(custom_pickers.live_grep),
						}
					}
				}
			},

			--- extensions {{{2

			extensions = {
				fzf = {
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter    = true, -- override the file sorter
					case_mode               = 'smart_case', -- or "ignore_case" or "respect_case"
					fuzzy                   = true, -- false will only do exact matching
				},

				media_files = {
					filetypes = { 'jpg', 'jpeg', 'png', 'webp', 'pdf', 'mkv' },
					find_cmd  = 'rg',
				},
			}
			--- }}}
		})

		pcall(telescope.load_extension, 'file_browser') -- file browser
		pcall(telescope.load_extension, 'fzf') -- other superfast sorter
		pcall(telescope.load_extension, 'project') -- project picker
	end
}

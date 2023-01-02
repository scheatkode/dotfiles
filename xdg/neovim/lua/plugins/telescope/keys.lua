return {
	setup = function()
		local lazy    = require('load.on_member_call')
		local themes  = lazy('plugins.telescope.themes')
		local pickers = lazy('plugins.telescope.pickers')

		-- project
		vim.keymap.set('n', '<leader>sp', pickers.projects)

		-- file browser
		vim.keymap.set('n', '<leader>se', pickers.file_browser)
		vim.keymap.set('n', '<leader>sE', function()
			pickers.file_browser({ depth = false, files = false })
		end)

		-- live grep
		vim.keymap.set('n', '<leader>sg', pickers.live_grep)
		vim.keymap.set('n', '<leader>sG', function()
			pickers.live_grep({ grep_open_files = true })
		end)
		vim.keymap.set('n', '<leader>st', pickers.current_buffer_fuzzy_find)

		-- grep string
		vim.keymap.set('n', '<leader>ss', pickers.grep_string)

		-- find files
		vim.keymap.set('n', '<leader><leader>', pickers.project_or_find_files)
		vim.keymap.set('n', '<leader>sf', pickers.find_files)
		vim.keymap.set('n', '<leader>sF', function()
			pickers.find_files({ hidden = true, no_ignore = true })
		end)
		vim.keymap.set('n', '<leader>sn', pickers.find_notes)

		-- find buffers
		vim.keymap.set('n', '<leader>sb', pickers.buffers)
		vim.keymap.set('n', '<leader>sB', function()
			pickers.buffers({ show_all_buffers = true })
		end)

		-- git commit
		vim.keymap.set('n', '<leader>sgc', pickers.git_commits)
		vim.keymap.set('n', '<leader>sgf', pickers.git_current_file_commits)
		vim.keymap.set('n', '<leader>sgb', pickers.git_branches)

		-- commands
		vim.keymap.set('n', '<leader>sc', pickers.commands)
		vim.keymap.set('n', '<leader>;', function()
			pickers.commands(themes.get_command())
		end)

		-- qflist & loclist
		vim.keymap.set('n', '<leader>sq', pickers.quickfix)
		vim.keymap.set('n', '<leader>sl', pickers.loclist)

		-- vim options
		vim.keymap.set('n', '<leader>so', pickers.vim_options)

		-- help tags
		vim.keymap.set('n', '<leader>sh', pickers.help_tags)

		-- man pages
		vim.keymap.set('n', '<leader>sM', pickers.man_pages)

		-- marks
		vim.keymap.set('n', '<leader>sm', pickers.marks)

		-- registers
		vim.keymap.set('n', '<leader>sR', pickers.registers)
		vim.keymap.set('n', '<leader>svr', pickers.registers)

		-- keymaps
		vim.keymap.set('n', '<leader>sk', pickers.keymaps)

		-- autocommands
		vim.keymap.set('n', '<leader>sva', pickers.autocommands)

		-- spell
		vim.keymap.set('n', '<leader>sS', pickers.spell_suggest)

		-- lsp

		-- references
		vim.keymap.set('n', '<leader>sr', pickers.lsp_references)

		-- definitions
		vim.keymap.set('n', '<leader>sd', pickers.lsp_definitions)

		-- type definitions
		vim.keymap.set('n', '<leader>sT', pickers.lsp_type_definitions)

		-- implementations
		vim.keymap.set('n', '<leader>si', pickers.lsp_implementations)

		-- document symbols
		vim.keymap.set('n', '<leader>sds', pickers.lsp_document_symbols)

		-- workspace symbols
		vim.keymap.set('n', '<leader>sws', pickers.lsp_workspace_symbols)

		-- diagnostics
		vim.keymap.set('n', '<leader>sdd', pickers.diagnostics)

		-- command history
		vim.keymap.set('c', '<C-r><C-r>', '<Plug>(TelescopeFuzzyCommandSearch)', {
			remap = true,
			nowait = true,
		})
	end,
}

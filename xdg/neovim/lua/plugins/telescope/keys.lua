return {
	setup = function()
		local pickers = require('plugins.telescope.pickers')

		-- project
		vim.keymap.set('n', '<leader>fp', pickers.projects)
		vim.keymap.set('n', '<leader>Fp', pickers.projects)
		-- shorthand
		vim.keymap.set('n', '<leader>pp', pickers.projects)
		vim.keymap.set('n', '<leader>Pp', pickers.projects)

		-- live grep
		vim.keymap.set('n', '<leader>fg', pickers.live_grep)
		vim.keymap.set('n', '<leader>Fg', pickers.live_grep)
		vim.keymap.set('n', '<leader>fG', function() pickers.live_grep({ grep_open_files = true }) end)
		vim.keymap.set('n', '<leader>FG', function() pickers.live_grep({ grep_open_files = true }) end)
		vim.keymap.set('n', '<leader>ft', pickers.buffer_fuzzy)
		vim.keymap.set('n', '<leader>Ft', pickers.buffer_fuzzy)

		-- grep string
		vim.keymap.set('n', '<leader>f/', pickers.grep_string)
		vim.keymap.set('n', '<leader>F/', pickers.grep_string)

		-- find files
		vim.keymap.set('n', '<leader><leader>', pickers.project_or_find_files)
		vim.keymap.set('n', '<leader>ff', pickers.find_files)
		vim.keymap.set('n', '<leader>Ff', pickers.find_files)
		vim.keymap.set('n', '<leader>fF', function() pickers.find_files({ hidden = true }) end)
		vim.keymap.set('n', '<leader>FF', function() pickers.find_files({ hidden = true }) end)
		vim.keymap.set('n', '<leader>fn', pickers.find_notes)
		vim.keymap.set('n', '<leader>Fn', pickers.find_notes)

		-- find buffers
		vim.keymap.set('n', '<leader>fb', pickers.buffers)
		vim.keymap.set('n', '<leader>Fb', pickers.buffers)
		vim.keymap.set('n', '<leader>fB', function() pickers.buffers({ show_all_buffers = true }) end)
		vim.keymap.set('n', '<leader>FB', function() pickers.buffers({ show_all_buffers = true }) end)
		-- shorthand
		vim.keymap.set('n', '<leader>bb', pickers.buffers)
		vim.keymap.set('n', '<leader>Bb', pickers.buffers)
		vim.keymap.set('n', '<leader>bB', function() pickers.buffers({ show_all_buffers = true }) end)
		vim.keymap.set('n', '<leader>BB', function() pickers.buffers({ show_all_buffers = true }) end)

		-- git commit
		vim.keymap.set('n', '<leader>fgc', pickers.git_commits)
		vim.keymap.set('n', '<leader>fgf', pickers.git_current_file_commits)
		vim.keymap.set('n', '<leader>fgb', pickers.git_branches)
		-- shorthand
		vim.keymap.set('n', '<leader>gc', pickers.git_commits)
		vim.keymap.set('n', '<leader>Gc', pickers.git_commits)
		vim.keymap.set('n', '<leader>gf', pickers.git_current_file_commits)
		vim.keymap.set('n', '<leader>Gf', pickers.git_current_file_commits)
		vim.keymap.set('n', '<leader>gb', pickers.git_branches)
		vim.keymap.set('n', '<leader>Gb', pickers.git_branches)

		-- commands
		vim.keymap.set('n', '<leader>fc', pickers.commands)
		vim.keymap.set('n', '<leader>Fc', pickers.commands)

		-- qflist & loclist
		vim.keymap.set('n', '<leader>fq', pickers.quickfix)
		vim.keymap.set('n', '<leader>Fq', pickers.quickfix)
		vim.keymap.set('n', '<leader>fl', pickers.loclist)
		vim.keymap.set('n', '<leader>Fl', pickers.loclist)

		-- vim options
		vim.keymap.set('n', '<leader>fo', pickers.vim_options)
		vim.keymap.set('n', '<leader>Fo', pickers.vim_options)

		-- help tags
		vim.keymap.set('n', '<leader>fh', pickers.help_tags)
		vim.keymap.set('n', '<leader>Fh', pickers.help_tags)

		-- man pages
		vim.keymap.set('n', '<leader>fM', pickers.man_pages)
		vim.keymap.set('n', '<leader>FM', pickers.man_pages)

		-- marks
		vim.keymap.set('n', '<leader>fm', pickers.marks)
		vim.keymap.set('n', '<leader>Fm', pickers.marks)

		-- registers
		vim.keymap.set('n', '<leader>fvr', pickers.registers)
		vim.keymap.set('n', '<leader>Fvr', pickers.registers)
		-- shorthand
		vim.keymap.set('n', '<leader>vr', pickers.registers)
		vim.keymap.set('n', '<leader>Vr', pickers.registers)
		vim.keymap.set('n', '<leader>vR', pickers.registers)
		vim.keymap.set('n', '<leader>VR', pickers.registers)

		-- keymaps
		vim.keymap.set('n', '<leader>fvk', pickers.keymaps)
		vim.keymap.set('n', '<leader>Fvk', pickers.keymaps)
		-- shorthand
		vim.keymap.set('n', '<leader>vk', pickers.keymaps)
		vim.keymap.set('n', '<leader>Vk', pickers.keymaps)
		vim.keymap.set('n', '<leader>vK', pickers.keymaps)
		vim.keymap.set('n', '<leader>VK', pickers.keymaps)

		-- autocommands
		vim.keymap.set('n', '<leader>fva', pickers.autocommands)
		vim.keymap.set('n', '<leader>Fva', pickers.autocommands)
		-- shorthand
		vim.keymap.set('n', '<leader>va', pickers.autocommands)
		vim.keymap.set('n', '<leader>Va', pickers.autocommands)
		vim.keymap.set('n', '<leader>vA', pickers.autocommands)
		vim.keymap.set('n', '<leader>VA', pickers.autocommands)

		-- spell
		vim.keymap.set('n', '<leader>fS', pickers.spell_suggest)
		vim.keymap.set('n', '<leader>FS', pickers.spell_suggest)

		-- lsp

			-- references
			vim.keymap.set('n', '<leader>fr', pickers.lsp_references)
			vim.keymap.set('n', '<leader>Fr', pickers.lsp_references)

			-- definitions
			vim.keymap.set('n', '<leader>fd', pickers.lsp_definitions)
			vim.keymap.set('n', '<leader>Fd', pickers.lsp_definitions)

			-- type definitions
			vim.keymap.set('n', '<leader>fT', pickers.lsp_type_definitions)
			vim.keymap.set('n', '<leader>FT', pickers.lsp_type_definitions)

			-- implementations
			vim.keymap.set('n', '<leader>fi', pickers.lsp_implementations)
			vim.keymap.set('n', '<leader>Fi', pickers.lsp_implementations)

			-- document symbols
			vim.keymap.set('n', '<leader>fds', pickers.lsp_document_symbols)
			vim.keymap.set('n', '<leader>Fds', pickers.lsp_document_symbols)

			-- workspace symbols
			vim.keymap.set('n', '<leader>fws', pickers.lsp_workspace_symbols)
			vim.keymap.set('n', '<leader>Fws', pickers.lsp_workspace_symbols)

		-- diagnostics
		vim.keymap.set('n', '<leader>fdd', pickers.diagnostics)
		vim.keymap.set('n', '<leader>Fdd', pickers.diagnostics)

		-- command history
		vim.keymap.set('c', '<C-r><C-r>', '<Plug>(TelescopeFuzzyCommandSearch)', { remap = true, nowait = true })

	end
}

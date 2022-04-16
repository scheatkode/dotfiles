local function setup ()
   local actions = require('plugins.telescope.actions')

   -- project
   vim.keymap.set('n', '<leader>fp', actions.projects)
   vim.keymap.set('n', '<leader>Fp', actions.projects)
   -- shorthand
   vim.keymap.set('n', '<leader>pp', actions.projects)
   vim.keymap.set('n', '<leader>Pp', actions.projects)

   -- live grep
   vim.keymap.set('n', '<leader>fg', actions.live_grep)
   vim.keymap.set('n', '<leader>Fg', actions.live_grep)
   vim.keymap.set('n', '<leader>fG', function () actions.live_grep(true) end)
   vim.keymap.set('n', '<leader>FG', function () actions.live_grep(true) end)
   vim.keymap.set('n', '<leader>ft', actions.buffer_fuzzy)
   vim.keymap.set('n', '<leader>Ft', actions.buffer_fuzzy)

   -- grep string
   vim.keymap.set('n', '<leader>f/', actions.grep_string)
   vim.keymap.set('n', '<leader>F/', actions.grep_string)

   -- find files
   vim.keymap.set('n', '<leader><leader>', actions.project_or_find_files)
   vim.keymap.set('n', '<leader>ff', actions.find_files)
   vim.keymap.set('n', '<leader>Ff', actions.find_files)
   vim.keymap.set('n', '<leader>fF', function () actions.find_files(true) end)
   vim.keymap.set('n', '<leader>FF', function () actions.find_files(true) end)
   vim.keymap.set('n', '<leader>fn', actions.find_notes)
   vim.keymap.set('n', '<leader>Fn', actions.find_notes)
   vim.keymap.set('n', '<leader>fe', actions.file_explorer)
   vim.keymap.set('n', '<leader>Fe', actions.file_explorer)
   vim.keymap.set('n', '<leader>fR', actions.frecency)
   vim.keymap.set('n', '<leader>FR', actions.frecency)
   vim.keymap.set('n', '<leader>fH', actions.oldfiles)
   vim.keymap.set('n', '<leader>FH', actions.oldfiles)

   -- find files
   vim.keymap.set('n', '<leader>fb', actions.buffers)
   vim.keymap.set('n', '<leader>Fb', actions.buffers)
   vim.keymap.set('n', '<leader>fB', function () actions.buffers(true) end)
   vim.keymap.set('n', '<leader>FB', function () actions.buffers(true) end)
   -- shorthand
   vim.keymap.set('n', '<leader>bb', actions.buffers)
   vim.keymap.set('n', '<leader>Bb', actions.buffers)
   vim.keymap.set('n', '<leader>bB', function () actions.buffers(true) end)
   vim.keymap.set('n', '<leader>BB', function () actions.buffers(true) end)

   -- git commit
   vim.keymap.set('n', '<leader>fgc', actions.git_commits)
   vim.keymap.set('n', '<leader>fgf', actions.git_current_file_commits)
   vim.keymap.set('n', '<leader>fgb', actions.git_branches)
   -- shorthand
   vim.keymap.set('n', '<leader>gc', actions.git_commits)
   vim.keymap.set('n', '<leader>Gc', actions.git_commits)
   vim.keymap.set('n', '<leader>gf', actions.git_current_file_commits)
   vim.keymap.set('n', '<leader>Gf', actions.git_current_file_commits)
   vim.keymap.set('n', '<leader>gb', actions.git_branches)
   vim.keymap.set('n', '<leader>Gb', actions.git_branches)

   -- commands
   vim.keymap.set('n', '<leader>fc', actions.commands)
   vim.keymap.set('n', '<leader>Fc', actions.commands)

   -- qflist & loclist
   vim.keymap.set('n', '<leader>fq', actions.quickfix)
   vim.keymap.set('n', '<leader>Fq', actions.quickfix)
   vim.keymap.set('n', '<leader>fl', actions.loclist)
   vim.keymap.set('n', '<leader>Fl', actions.loclist)

   -- vim options
   vim.keymap.set('n', '<leader>fo', actions.vim_options)
   vim.keymap.set('n', '<leader>Fo', actions.vim_options)

   -- help tags
   vim.keymap.set('n', '<leader>fh', actions.help_tags)
   vim.keymap.set('n', '<leader>Fh', actions.help_tags)

   -- man pages
   vim.keymap.set('n', '<leader>fM', actions.man_pages)
   vim.keymap.set('n', '<leader>FM', actions.man_pages)

   -- marks
   vim.keymap.set('n', '<leader>fm', actions.marks)
   vim.keymap.set('n', '<leader>Fm', actions.marks)

   -- registers
   vim.keymap.set('n', '<leader>fvr', actions.registers)
   vim.keymap.set('n', '<leader>Fvr', actions.registers)
   -- shorthand
   vim.keymap.set('n', '<leader>vr', actions.registers)
   vim.keymap.set('n', '<leader>Vr', actions.registers)
   vim.keymap.set('n', '<leader>vR', actions.registers)
   vim.keymap.set('n', '<leader>VR', actions.registers)

   -- keymaps
   vim.keymap.set('n', '<leader>fvk', actions.keymaps)
   vim.keymap.set('n', '<leader>Fvk', actions.keymaps)
   -- shorthand
   vim.keymap.set('n', '<leader>vk', actions.keymaps)
   vim.keymap.set('n', '<leader>Vk', actions.keymaps)
   vim.keymap.set('n', '<leader>vK', actions.keymaps)
   vim.keymap.set('n', '<leader>VK', actions.keymaps)

   -- autocommands
   vim.keymap.set('n', '<leader>fva', actions.autocommands)
   vim.keymap.set('n', '<leader>Fva', actions.autocommands)
   -- shorthand
   vim.keymap.set('n', '<leader>va', actions.autocommands)
   vim.keymap.set('n', '<leader>Va', actions.autocommands)
   vim.keymap.set('n', '<leader>vA', actions.autocommands)
   vim.keymap.set('n', '<leader>VA', actions.autocommands)

   -- spell
   vim.keymap.set('n', '<leader>fS', actions.spell_suggest)
   vim.keymap.set('n', '<leader>FS', actions.spell_suggest)

   -- lsp

      -- references
      vim.keymap.set('n', '<leader>fr', actions.lsp_references)
      vim.keymap.set('n', '<leader>Fr', actions.lsp_references)

      -- definitions
      vim.keymap.set('n', '<leader>fd', actions.lsp_definitions)
      vim.keymap.set('n', '<leader>Fd', actions.lsp_definitions)

      -- type definitions
      vim.keymap.set('n', '<leader>fT', actions.lsp_type_definitions)
      vim.keymap.set('n', '<leader>FT', actions.lsp_type_definitions)

      -- implementations
      vim.keymap.set('n', '<leader>fi', actions.lsp_implementations)
      vim.keymap.set('n', '<leader>Fi', actions.lsp_implementations)

      -- code_actions
      vim.keymap.set('n', '<leader>ca', actions.lsp_code_actions)
      vim.keymap.set('n', '<leader>Ca', actions.lsp_code_actions)
      vim.keymap.set('n', '<leader>cA', actions.lsp_code_actions)
      vim.keymap.set('n', '<leader>CA', actions.lsp_code_actions)

      -- document symbols
      vim.keymap.set('n', '<leader>fds', actions.lsp_document_symbols)
      vim.keymap.set('n', '<leader>Fds', actions.lsp_document_symbols)

      -- workspace symbols
      vim.keymap.set('n', '<leader>fws', actions.lsp_workspace_symbols)
      vim.keymap.set('n', '<leader>Fws', actions.lsp_workspace_symbols)

      -- document diagnostics
      vim.keymap.set('n', '<leader>fdd', actions.lsp_document_diagnostics)
      vim.keymap.set('n', '<leader>Fdd', actions.lsp_document_diagnostics)

      -- workspace diagnostics
      vim.keymap.set('n', '<leader>fws', actions.lsp_workspace_diagnostics)
      vim.keymap.set('n', '<leader>Fws', actions.lsp_workspace_diagnostics)

   -- command history
   vim.keymap.set('c', '<C-r><C-r>', '<Plug>(TelescopeFuzzyCommandSearch)', {remap = true, nowait = true})

end

return {
   setup = setup
}

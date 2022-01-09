return require('util').register_keymaps({
   --- project {{{1

   {
      mode    = 'n',
      keys    = '<leader>fp',
      command = '<cmd>lua require("plugins.telescope.actions").projects()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fp',
      command = '<cmd>lua require("plugins.telescope.actions").projects()<CR>',
   },

   --- shorthand keymaps

   {
      mode    = 'n',
      keys    = '<leader>pp',
      command = '<cmd>lua require("plugins.telescope.actions").projects()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Pp',
      command = '<cmd>lua require("plugins.telescope.actions").projects()<CR>',
   },

   --- live grep {{{1

   {
      mode    = 'n',
      keys    = '<leader>fg',
      command = '<cmd>lua require("plugins.telescope.actions").live_grep()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fg',
      command = '<cmd>lua require("plugins.telescope.actions").live_grep()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>fG',
      command = '<cmd>lua require("plugins.telescope.actions").live_grep(true)<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>FG',
      command = '<cmd>lua require("plugins.telescope.actions").live_grep(true)<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>ft',
      command = '<cmd>lua require("plugins.telescope.actions").buffer_fuzzy()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Ft',
      command = '<cmd>lua require("plugins.telescope.actions").buffer_fuzzy()<CR>',
   },

   --- grep string {{{1

   {
      mode    = 'n',
      keys    = '<leader>f/',
      command = '<cmd>lua require("plugins.telescope.actions").grep_string()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>F/',
      command = '<cmd>lua require("plugins.telescope.actions").grep_string()<CR>',
   },

   --- find files {{{1

   {
      mode    = 'n',
      keys    = '<leader><leader>',
      command = '<cmd>lua require("plugins.telescope.actions").project_or_find_files()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>ff',
      command = '<cmd>lua require("plugins.telescope.actions").find_files()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Ff',
      command = '<cmd>lua require("plugins.telescope.actions").find_files()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fF',
      command = '<cmd>lua require("plugins.telescope.actions").find_files(true)<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>FF',
      command = '<cmd>lua require("plugins.telescope.actions").find_files(true)<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fn',
      command = '<cmd>lua require("plugins.telescope.actions").find_notes()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Fn',
      command = '<cmd>lua require("plugins.telescope.actions").find_notes()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fe',
      command = '<cmd>lua require("plugins.telescope.actions").file_explorer()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Fe',
      command = '<cmd>lua require("plugins.telescope.actions").file_explorer()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fR',
      command = '<cmd>lua require("plugins.telescope.actions").frecency()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>FR',
      command = '<cmd>lua require("plugins.telescope.actions").frecency()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fH',
      command = '<cmd>lua require("plugins.telescope.actions").oldfiles()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>FH',
      command = '<cmd>lua require("plugins.telescope.actions").oldfiles()<CR>'
   },

   --- buffers {{{1

   {
      mode    = 'n',
      keys    = '<leader>fb',
      command = '<cmd>lua require("plugins.telescope.actions").buffers()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Fb',
      command = '<cmd>lua require("plugins.telescope.actions").buffers()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fB',
      command = '<cmd>lua require("plugins.telescope.actions").buffers(true)<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>FB',
      command = '<cmd>lua require("plugins.telescope.actions").buffers(true)<CR>'
   },

   --- shorthand keymaps

   {
      mode    = 'n',
      keys    = '<leader>bb',
      command = '<cmd>lua require("plugins.telescope.actions").buffers()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Bb',
      command = '<cmd>lua require("plugins.telescope.actions").buffers()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>bB',
      command = '<cmd>lua require("plugins.telescope.actions").buffers(true)<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>BB',
      command = '<cmd>lua require("plugins.telescope.actions").buffers(true)<CR>'
   },

   --- git commit {{{1

   {
      mode    = 'n',
      keys    = '<leader>fgc',
      command = '<cmd>lua require("plugins.telescope.actions").git_commits()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>fgf',
      command = '<cmd>lua require("plugins.telescope.actions").git_current_file_commits()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>fgb',
      command = '<cmd>lua require("plugins.telescope.actions").git_branches()<CR>',
   },

   -- shortened keymaps

   {
      mode    = 'n',
      keys    = '<leader>gc',
      command = '<cmd>lua require("plugins.telescope.actions").git_commits()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Gc',
      command = '<cmd>lua require("plugins.telescope.actions").git_commits()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>gf',
      command = '<cmd>lua require("plugins.telescope.actions").git_current_file_commits()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Gf',
      command = '<cmd>lua require("plugins.telescope.actions").git_current_file_commits()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>gb',
      command = '<cmd>lua require("plugins.telescope.actions").git_branches()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Gb',
      command = '<cmd>lua require("plugins.telescope.actions").git_branches()<CR>',
   },

   --- commands {{{1

   {
      mode    = 'n',
      keys    = '<leader>fc',
      command = '<cmd>lua require("plugins.telescope.actions").commands()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fc',
      command = '<cmd>lua require("plugins.telescope.actions").commands()<CR>',
   },

   --- quickfix & loclist {{{1

   {
      mode    = 'n',
      keys    = '<leader>fq',
      command = '<cmd>lua require("plugins.telescope.actions").quickfix()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fq',
      command = '<cmd>lua require("plugins.telescope.actions").quickfix()<CR>',
   },

   {
      mode    = 'n',
      keys    = '<leader>fl',
      command = '<cmd>lua require("plugins.telescope.actions").loclist()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fl',
      command = '<cmd>lua require("plugins.telescope.actions").loclist()<CR>',
   },

   --- vim options {{{1

   {
      mode    = 'n',
      keys    = '<leader>fo',
      command = '<cmd>lua require("plugins.telescope.actions").vim_options()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fo',
      command = '<cmd>lua require("plugins.telescope.actions").vim_options()<CR>',
   },

   --- help tags {{{1

   {
      mode    = 'n',
      keys    = '<leader>fh',
      command = '<cmd>lua require("plugins.telescope.actions").help_tags()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fh',
      command = '<cmd>lua require("plugins.telescope.actions").help_tags()<CR>',
   },

   --- man pages {{{1

   {
      mode    = 'n',
      keys    = '<leader>fM',
      command = '<cmd>lua require("plugins.telescope.actions").man_pages()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>FM',
      command = '<cmd>lua require("plugins.telescope.actions").man_pages()<CR>',
   },

   --- marks {{{1

   {
      mode    = 'n',
      keys    = '<leader>fm',
      command = '<cmd>lua require("plugins.telescope.actions").marks()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fm',
      command = '<cmd>lua require("plugins.telescope.actions").marks()<CR>',
   },

   --- registers {{{1

   {
      mode    = 'n',
      keys    = '<leader>fvr',
      command = '<cmd>lua require("plugins.telescope.actions").registers()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fvr',
      command = '<cmd>lua require("plugins.telescope.actions").registers()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>vr',
      command = '<cmd>lua require("plugins.telescope.actions").registers()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Vr',
      command = '<cmd>lua require("plugins.telescope.actions").registers()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>vR',
      command = '<cmd>lua require("plugins.telescope.actions").registers()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>VR',
      command = '<cmd>lua require("plugins.telescope.actions").registers()<CR>',
   },

   --- keymaps {{{1

   {
      mode    = 'n',
      keys    = '<leader>fvk',
      command = '<cmd>lua require("plugins.telescope.actions").keymaps()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fvk',
      command = '<cmd>lua require("plugins.telescope.actions").keymaps()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>vk',
      command = '<cmd>lua require("plugins.telescope.actions").keymaps()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Vk',
      command = '<cmd>lua require("plugins.telescope.actions").keymaps()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>vK',
      command = '<cmd>lua require("plugins.telescope.actions").keymaps()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>VK',
      command = '<cmd>lua require("plugins.telescope.actions").keymaps()<CR>',
   },

   --- autocommands {{{1

   {
      mode    = 'n',
      keys    = '<leader>fva',
      command = '<cmd>lua require("plugins.telescope.actions").autocommands()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fva',
      command = '<cmd>lua require("plugins.telescope.actions").autocommands()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>va',
      command = '<cmd>lua require("plugins.telescope.actions").autocommands()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Va',
      command = '<cmd>lua require("plugins.telescope.actions").autocommands()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>vA',
      command = '<cmd>lua require("plugins.telescope.actions").autocommands()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>VA',
      command = '<cmd>lua require("plugins.telescope.actions").autocommands()<CR>',
   },

   --- autocommands {{{1

   {
      mode    = 'n',
      keys    = '<leader>fS',
      command = '<cmd>lua require("plugins.telescope.actions").spell_suggest()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>FS',
      command = '<cmd>lua require("plugins.telescope.actions").spell_suggest()<CR>',
   },

   --- lsp {{{1
   --- references {{{2

   {
      mode    = 'n',
      keys    = '<leader>fr',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_references()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fr',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_references()<CR>',
   },

   --- definitions {{{2

   {
      mode    = 'n',
      keys    = '<leader>fd',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_definitions()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fd',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_definitions()<CR>',
   },

   --- type definitions {{{2

   {
      mode    = 'n',
      keys    = '<leader>fT',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_type_definitions()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>FT',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_type_definitions()<CR>',
   },

   --- implementations {{{2

   {
      mode    = 'n',
      keys    = '<leader>fi',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_implementations()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fi',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_implementations()<CR>',
   },

   --- code_actions {{{2

   {
      mode    = 'n',
      keys    = '<leader>ca',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_code_actions()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Ca',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_code_actions()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>cA',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_code_actions()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>CA',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_code_actions()<CR>',
   },

   --- document symbols {{{2

   {
      mode    = 'n',
      keys    = '<leader>fds',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_document_symbols()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fds',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_document_symbols()<CR>',
   },

   --- workspace symbols {{{2

   {
      mode    = 'n',
      keys    = '<leader>fws',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_workspace_symbols()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fws',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_workspace_symbols()<CR>',
   },

   --- document diagnostics {{{2

   {
      mode    = 'n',
      keys    = '<leader>fdd',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_document_diagnostics()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fdd',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_document_diagnostics()<CR>',
   },

   --- workspace diagnostics {{{2

   {
      mode    = 'n',
      keys    = '<leader>fwd',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_workspace_diagnostics()<CR>',
   },
   {
      mode    = 'n',
      keys    = '<leader>Fwd',
      command = '<cmd>lua require("plugins.telescope.actions").lsp_workspace_diagnostics()<CR>',
   },

   {
      mode    = 'c',
      keys    = '<c-r><c-r>',
      command = '<Plug>(TelescopeFuzzyCommandSearch)',
      options = {
         noremap = false,
         nowait  = true,
         silent  = false
      }
   },
})

require('util').register_variables('g', {
   -- nvim_tree_side                 = 'left',
   -- nvim_tree_width                = 40,
   -- nvim_tree_auto_open            = 0,
   -- nvim_tree_auto_close           = 1,
   nvim_tree_quit_on_open         = 1,
   nvim_tree_follow               = 1,
   nvim_tree_indent_markers       = 1,
   nvim_tree_hide_dotfiles        = 1,
   nvim_tree_git_hl               = 1,
   nvim_tree_root_folder_modifier = ':~',
   -- nvim_tree_tab_open             = 0,
   nvim_tree_width_allow_resize   = 1,
   -- nvim_tree_lsp_diagnostics      = 1,
   -- nvim_tree_update_cwd = 1,

   -- nvim_tree_disable_default_keybindings = 1,

   nvim_tree_ignore = {
      '.git',
      'node_modules',
      '.cache',
   },

   nvim_tree_auto_ignore_ft = {
      'startify',
      'dashboard',
   },

   nvim_tree_window_picker_exclude = {
      filetype = {
         'packer',
         'qf',
      },

      buftype = {
         'terminal',
      },
   },

   nvim_tree_special_files = {
      ['README.md'] = 1,
      ['Makefile']  = 1,
   },

   -- nvim_tree_bindings = {
   --    { key = {'<CR>', '<Tab>', 'o'}, cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('edit')<CR>" },
   --    { key = {'<C-v>'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('edit_vsplit')<CR>" },
   --    { key = {'<C-x>'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('edit_split')<CR>" },
   --    { key = {'<C-t>'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('edit_tab')<CR>" },
   --    { key = {'<'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('prev_sibling')<CR>" },
   --    { key = {'>'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('next_sibling')<CR>" },
   --    { key = {'<S-CR>', '<BS>'},     cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('close_node')<CR>" },
   --    { key = {'I'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('toggle_ignored')<CR>" },
   --    { key = {'H'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('toggle_dotfiles')<CR>" },
   --    { key = {'R'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('refresh')<CR>" },
   --    { key = {'P'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('preview')<CR>" },
   --    { key = {'<C-]>'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('cd')<CR>" },
   --    { key = {'a'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('create')<CR>" },
   --    { key = {'d'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('remove')<CR>" },
   --    { key = {'r'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('rename')<CR>" },
   --    { key = {'<C-r>'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('full_rename')<CR>" },
   --    { key = {'<C-r>'},              cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('full_rename')<CR>" },
   --    { key = {'x'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('cut')<CR>" },
   --    { key = {'c'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('copy')<CR>" },
   --    { key = {'p'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('paste')<CR>" },
   --    { key = {'[c'},                 cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('prev_git_item')<CR>" },
   --    { key = {']c'},                 cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('next_git_item')<CR>" },
   --    { key = {'-'},                  cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('dir_up')<CR>" },
   --    { key = {'<Esc>', 'q'},         cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('close')<CR>" },
   --    { key = {'g?'},                 cb = "<cmd>lua require('nvim-tree.config').nvim_tree_callback('toggle_help')<CR>" },
   -- }
})

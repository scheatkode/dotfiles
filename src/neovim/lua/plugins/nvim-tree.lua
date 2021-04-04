local apply_maps = require('lib.config').keymaps.use
local apply_conf = require('lib.config').variables.use

local configuration = {
   vim_tree_side    = 'left',
   nvim_tree_width  = 35,
   nvim_tree_ignore = {
      '.git',
      'node_modules',
      '.cache',
   },
   nvim_tree_auto_open            = 0,
   nvim_tree_auto_close           = 1,
   nvim_tree_auto_ignore_ft       = {'startify', 'dashboard'},
   nvim_tree_quit_on_open         = 1,
   nvim_tree_follow               = 1,
   nvim_tree_indent_markers       = 0,
   nvim_tree_hide_dotfiles        = 1,
   nvim_tree_git_hl               = 1,
   nvim_tree_root_folder_modifier = ':~',
   nvim_tree_tab_open             = 0,
   nvim_tree_width_allow_resize   = 1,

--   nvim_tree_bindings = {
--      edit            = {
--         '<CR>',
--         'o',
--      },
--      edit_vsplit     = '<C-v>',
--      edit_split      = '<C-x>',
--      edit_tab        = '<C-t>',
--      close_node      = {
--         '<S-CR>',
--         '<BS>',
--      },
--      toggle_ignored  = 'I',
--      toggle_dotfiles = 'H',
--      refresh         = 'R',
--      preview         = '<Tab>',
--      cd              = '<C-]>',
--      create          = 'a',
--      remove          = 'd',
--      rename          = 'r',
--      cut             = 'x',
--      copy            = 'c',
--      paste           = 'p',
--      prev_git_item   = '[c',
--      next_git_item   = ']c',
--      dir_up          = '-',
--      close           = 'q',
--   },
}

local keymaps = {
   {'n', '<leader>ft', ':NvimTreeToggle<CR>', {silent = true, noremap = true}},
}

apply_conf('g', configuration)
apply_maps(keymaps)

-- vim: set sw=3 ts=3 sts=3 et tw=81 fmr={{{,}}} fdl=0 fdm=marker:

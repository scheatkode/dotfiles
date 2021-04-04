require('gitsigns').setup({
   signs = {
      add          = {hl = 'DiffAdd',    text = ' █', numhl='GitSignsAddNr',    linehl='GitSignsAddLn'},
      change       = {hl = 'DiffChange', text = ' █', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'DiffDelete', text = ' █', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'DiffDelete', text = ' █', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'DiffChange', text = ' █', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
   },
   keymaps = {
      -- Default keymap options
      noremap = true,
      buffer  = true,

      ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
      ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

      ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

      -- Text objects
      ['o ig'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ['x ig'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
   },
   numhl              = false,
   sign_priority      = 5,
   status_formatter   = nil,
   use_decoration_api = true,
})

require('neogit').setup {
   disable_signs = false,
   disable_context_highlighting = false,
   -- customize displayed signs
   signs = {
      section = {'▸', '▾'},
      item    = {'▸', '▾'},
      hunk    = {' ▸', ' ▾'},
   },
}

local apply = require('lib.config').keymaps.use

local keymaps = {
   {'n', '<leader>gg', '<cmd>Neogit kind=split<cr>', {noremap = true, silent = true}},
}

apply(keymaps)

-- vim: set sw=3 ts=3 sts=3 et tw=81 fmr={{{,}}} fdl=0 fdm=marker:

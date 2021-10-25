local has_gitsigns, gitsigns = pcall(require, 'gitsigns')

if not has_gitsigns then
   print('‼ Tried loading gitsigns ... unsuccessfully.')
   return has_gitsigns
end

gitsigns.setup({
   signs = {
      -- add          = {hl = 'DiffAdd',    text = ' █', numhl='GitSignsAddNr',    linehl='GitSignsAddLn'},
      -- change       = {hl = 'DiffChange', text = ' █', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      -- delete       = {hl = 'DiffDelete', text = ' █', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      -- topdelete    = {hl = 'DiffDelete', text = ' █', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      -- changedelete = {hl = 'DiffChange', text = ' █', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      add          = {hl = 'DiffAdd',    text = ' ', numhl='GitSignsAddNr',    linehl='GitSignsAddLn'},
      change       = {hl = 'DiffChange', text = ' ', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'DiffDelete', text = ' ', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'DiffDelete', text = ' ', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'DiffChange', text = ' ', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
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
      ['o ig'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
      ['x ig'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
   },

   linehl = false,
   numhl  = false,

   trouble = true,

   watch_index = {
      interval = 1000,
   },

   update_debounce = 100,

   sign_priority      = 6,
   status_formatter   = nil,
   use_decoration_api = true,
   use_internal_diff  = true,
})

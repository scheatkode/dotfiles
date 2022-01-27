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

   -- TODO(scheatkode): activate this on v7.0
   -- on_attach = function (bufnr)
   --    local function map(mode, l, r, opts)
   --       opts = opts or {}
   --       opts.buffer = bufnr
   --       vim.keymap.set(mode, l, r, opts)
   --    end

   --    -- navigation
   --    map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'")
   --    map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'")

   --    -- actions
   --    map({'n', 'v'}, '<leader>gs', gitsigns.stage_hunk)
   --    map({'n', 'v'}, '<leader>gr', gitsigns.reset_hunk)
   --    map('n', '<leader>gu', gitsigns.undo_stage_hunk)
   --    map('n', '<leader>gS', gitsigns.stage_buffer)
   --    map('n', '<leader>gR', gitsigns.reset_buffer)
   --    map('n', '<leader>gp', gitsigns.preview_hunk)
   --    map('n', '<leader>gb', function () gitsigns.blame_line({full = true}) end)
   --    map('n', '<leader>gB', gitsigns.toggle_current_line_blame)
   --    map('n', '<leader>gd', gitsigns.diff_this)
   --    map('n', '<leader>gD', function () gitsigns.diff_this('~') end)

   --    -- text object
   --    map({'o', 'x'}, 'ih', ':<C-u>Gitsigns select_hunk<CR>')
   -- end,

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

   watch_gitdir = {
      interval = 1000,
   },

   update_debounce = 100,

   sign_priority      = 6,
   status_formatter   = nil,

   diff_opts = {
      internal = true,
   }
})

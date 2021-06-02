------------------------ the plumbing and the porcelain ------------------------
---------------------------------- xkcd #1597 ----------------------------------

--        _____
--       /      \
--      (____/\  )
--       |___  U?(____
--       _\L.   |      \     ___
--     / /"""\ /.-'     |   |\  |
--    ( /  _/u     |    \___|_)_|
--     \|  \\      /   / \_(___ __)
--      |   \\    /   /  |  |    |
--      |    )  _/   /   )  |    |
--      _\__/.-'    /___(   |    |
--   _/  __________/     \  |    |
--  //  /  (              ) |    |
-- ( \__|___\    \______ /__|____|
--  \    (___\   |______)_/
--   \   |\   \  \     /
--    \  | \__ )  )___/
--     \  \  )/  /__(    contemplation or constipation ?
-- ___ |  /_//___|   \_________
--   _/  ( /          \
--  `----'(____________)

local global = vim.g

local ok, gitsigns = pcall(require, 'gitsigns')

if not ok then
   print('‼ Tried loading gitsigns ... unsuccessfully.')
   return ok
end

gitsigns.setup({
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
      ['o ig'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
      ['x ig'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
   },

   numhl  = false,
   linehl = false,

   watch_index = {
      interval = 1000,
   },

   update_debounce = 100,

   sign_priority      = 6,
   status_formatter   = nil,
   use_decoration_api = true,
   use_internal_diff  = true,
})

--
--               .----------/ |<=== floppy disk
--              /           | |
--             /           /| |          _________
--            /           / | |         | .-----. |
--           /___________/ /| |         |=|     |-|
--          [____________]/ | |         |~|_____|~|
--          |       ___  |  | |         '-|     |-'
--          |      /  _) |  | |           |.....|
-- function ======>|.'   |  | |           |     |<=== application
--   key    |            |  | |    input  |.....|       software
--          |            |  | |            `--._|
--   main =>|            |  | |      |
--  storage |            |  | ;______|_________________
--          |            |  |.' ____\|/_______________ `.
--          |            | /|  (______________________)  )<== user
--          |____________|/ \___________________________/  interface
--          '--||----: `'''''.__                      |
--             ||     `""";"""-.'-._ <== normal flow  |    central
--             ||         |     `-. `'._of operation /<== processing
--     ||      ||         |        `\   '-.         /       unit
--   surge     ().-.      |         |      :      /`
-- control ==>(_((X))     |      .-.       : <======= output
--  device       '-'      \     |   \      ;      |________
--     ||                  `\  \|/   '-..-'       / /_\   /|
--     ||                   /`-.____             |       / /
--     ||                  /  _    /_____________|_     / /_
--     ||    peripherals ==>/_\___________________/_\__/ /~ )__
--     ||      (hardware) |____________________________|/  ~   )
--     ||                                     (__~  ~     ~(~~`
--     ||    overflow (input/output error) ===> (_~_  ~  ~_ `)
--   .-''-.                                         `--~-' '`
--  /______\                              _________
--   [____] <=== de-bugging tool       _|`---------`|
--                                    (C|           |
--                         back-up ===> \           /
--  |\\\ ///|                            `=========`
--  | \\V// |
--  |  |~|  |
--  |  |=|  | <=== supplemental data
--  |  | |  |
--  |  | |  |                          (()____
--   \ |=| /              mouse ===>  ('      `\_______,
--    \|_|/                            `,,---,,'

-- although i respect the effort that has been put into neogit, it is still very
-- much a new project, and not as mature as the infamous magit. to further break
-- the dependency on emacs, we'll use lazygit instead for the time being.
-- only thing left to port is org-mode.

-- require('neogit').setup({
--    disable_signs = false,
--    disable_context_highlighting = false,
--    -- customize displayed signs
--    signs = {
--       section = {'▸', '▾'},
--       item    = {'▸', '▾'},
--       hunk    = {' ▸', ' ▾'},
--    },
-- })

require('sol.vim').apply_variables('g', {
   lazygit_floating_window_winblend       = 0,     -- transparency of floating window
   lazygit_floating_window_scaling_factor = 0.8,   -- scaling factor of floating window
   lazygit_floating_window_corner_chars   = {'╭', '╮', '╰', '╯'}, -- customize lazygit popup window corner characters
   lazygit_floating_window_use_plenary    = true,  -- use plenary.vim to manage floating window if available
   lazygit_use_neovim_remote              = false, -- fallback to 0 if neovim-remote is not installed
})

require('sol.vim').apply_keymaps({
   {'n', '<leader>gg', '<cmd>LazyGit<cr>', {noremap = true, silent = true}},
})

-- require('lib.config').keymaps.use({
--    {'n', '<leader>gg', '<cmd>Neogit kind=split<cr>', {noremap = true, silent = true}},
-- })

--- whichkey configuration

local ok, whichkey = pcall(require, 'whichkey_setup')

if not ok then
   return ok
end

whichkey.register_keymap('leader', {
   g = {
      name = '+git',

      g = 'Git porcelain',

      b = 'Blame line',
      p = 'Preview hunk',
      r = 'Reset hunk',
      R = 'Reset buffer',
      s = 'Stage hunk',
      u = 'Undo stage hunk',
   },
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

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

return {'lewis6991/gitsigns.nvim', opt = true,
   event = {
      'BufReadPost',
      'FileReadPre',
   },

   requires = {
      {'nvim-lua/plenary.nvim'},
   },

   wants = {
      'plenary.nvim'
   },

   config = function ()
      require('plugins.gitsigns.config')
   end,
}

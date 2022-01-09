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

return {'TimUntersberger/neogit', opt = true,
   cmd = 'Neogit',

   keys = {
      '<leader>gg',
   },

   requires = {
      {'nvim-lua/plenary.nvim'},
      {'sindrets/diffview.nvim'},
   },

   wants = {
      'plenary.nvim',
   },

   config = function ()
      require('plugins.gitporcelain.config')
      require('plugins.gitporcelain.keys')
   end
}

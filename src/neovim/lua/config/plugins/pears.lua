--- pears.nvim configuration

local fn  = vim.fn
local api = vim.api

local sol = require('sol.vim')

local has_pears, pears = pcall(require, 'pears')

if not has_pears then
   print('‼ Tried loading pears.nvim ... unsuccessfully.')
   return has_pears
end

pears.setup(function (conf)
   conf.remove_pair_on_inner_backspace(true)
   conf.remove_pair_on_outer_backspace(true)

   conf.expand_on_enter(true)
   conf.on_enter(function (pears_handle)
      if fn.pumvisible() ~= 0 and fn.complete_info().selected ~= -1 then
         return fn['compe#confirm']('<CR>')
      else
         api.nvim_feedkeys(sol.escape_termcode('<C-g>u'), 'n', true)
         pears_handle()
      end
   end)
end)

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

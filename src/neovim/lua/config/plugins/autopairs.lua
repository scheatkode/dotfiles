--- nvim-autopairs configuration

local fn = vim.fn

local ok, npairs = pcall(require, 'nvim-autopairs')

if not ok then
   print('‼ Tried loading nvim-autopairs ... unsuccessfully.')
   return ok
end

-- set object globally for later callback

_G.autopair = {}

vim.g.completion_confirm_key = ''

autopair.completion_confirm = function ()
   if fn.pumvisible() ~= 0 then
      if fn.complete_info()['selected'] ~= -1 then
         return fn['compe#confirm'](npairs.esc('<CR>'))
      else
         return npairs.esc('<CR>')
      end
   else
      return npairs.autopairs_cr()
   end
end

-- keymaps

require('sol.vim').apply_keymaps({
   {'i', '<cr>', 'v:lua.autopair.completion_confirm()', {expr = true, noremap = true}},
})

npairs.setup({})
-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

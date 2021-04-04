local apply  = require('lib.config').keymaps.use
local npairs = require('nvim-autopairs')

-- set object globally
_G.autopair = {}

vim.g.completion_confirm_key = ''

autopair.completion_confirm = function ()
   if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info()['selected'] ~= -1 then
         require('completion').confirmCompletion()
         return npairs.esc('<c-y>')
      else
         vim.api.nvim_select_popupmenu_item(0, false, false, {})
         require('completion').confirmCompletion()
         return npairs.esc('<c-n><c-y>')
      end
   else
      return npairs.check_break_line_char()
   end
end

local keymap = {
   {'i', '<cr>', 'v:lua.autopair.completion_confirm()', {expr = true, noremap = true}},
}

apply(keymap)

npairs.setup({})

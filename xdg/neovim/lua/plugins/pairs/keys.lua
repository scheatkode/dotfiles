local fn  = vim.fn
local log = require('log')

local has_pairs, pairs = pcall(require, 'nvim-autopairs')
local has_completion, _ = pcall(require, 'cmp')

if not has_pairs then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-autopairs')
   return has_pairs
end

if has_completion then
   require('nvim-autopairs.completion.cmp').setup({
            map_cr = true, -- map <CR> in insert mode
      map_complete = true, -- will auto-insert `(` after selected function or method item
       auto_select = true, -- automatically select the first item
   })

   return has_completion
end

-- disable completion key so we can rebind it

vim.g.completion_confirm_key = ''

local completion_confirm = function ()
   if
          fn.pumvisible() ~= 0
      and fn.pumvisible() ~= false
      and fn.complete_info()['selected'] ~= -1
   then
      return fn['compe#confirm'](pairs.esc('<CR>'))
   end

   return pairs.autopairs_cr()
end

return require('util').register_keymaps({{
   mode        = 'i',
   keys        = '<CR>',
   command     = completion_confirm,
   description = 'which_key_ignore',
   options     = {
      expr    = true,
      noremap = true,
   }
}})

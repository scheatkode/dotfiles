local fn = vim.fn
local t  = require('util').escape_termcodes

local modifiers = {
   expr    = true,
   noremap = false,
}

local check_backspace = function ()
   local  col  = fn.col('.') - 1
   return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder

local tab_complete = function ()
   if
          fn.pumvisible() ~= 0
      and fn.pumvisible() ~= false
   then
      return t('<C-n>')
   elseif fn.call('luasnip#jumpable', {1}) == 1 then
      return t('<Plug>luasnip-expand-or-jump')
   elseif check_backspace() then
      return t('<Tab>')
   else
      return fn['compe#complete']()
   end
end

local s_tab_complete = function ()
   if
          fn.pumvisible() ~= 0
      and fn.pumvisible() ~= false
   then
      return t('<C-p>')
   elseif fn.call('luasnip#jumpable', {-1}) == 1 then
      return t('<Plug>luasnip-jump-prev')
   else
      return t('<S-Tab>')
   end
end


return require('util').register_keymaps {
   {
      mode        = 'i',
      keys        = '<Tab>',
      command     = tab_complete,
      description = 'which_key_ignore',
      options     = modifiers
   },

   {
      mode        = 's',
      keys        = '<Tab>',
      command     = tab_complete,
      description = 'which_key_ignore',
      options     = modifiers
   },

   {
      mode        = 'i',
      keys        = '<S-Tab>',
      command     = s_tab_complete,
      description = 'which_key_ignore',
      options     = modifiers
   },

   {
      mode        = 's',
      keys        = '<S-Tab>',
      command     = s_tab_complete,
      description = 'which_key_ignore',
      options     = modifiers
   },


   {
      mode        = 'i',
      keys        = '<C-e>',
      command     = 'pumvisible() ? compe#close("<C-e>") : "\\<C-e>"',
      description = 'which_key_ignore',
      options     = modifiers
   },

   {
      mode        = 'i',
      keys        = '<C-u>',
      command     = 'pumvisible() ? compe#scroll({"delta": +4}) : "\\<C-u>"',
      description = 'which_key_ignore',
      options     = modifiers
   },

   {
      mode        = 'i',
      keys        = '<C-d>',
      command     = 'pumvisible() ? compe#scroll({"delta": -4}) : "\\<C-d>"',
      description = 'which_key_ignore',
      options     = modifiers
   },
}

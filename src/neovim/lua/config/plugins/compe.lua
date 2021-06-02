--- nvim-compe configuration

local fn = vim.fn

local ok, compe = pcall(require, 'compe')

if not ok then
   print('‼ Tried loading nvim-compe ... unsuccessfully.')
   return ok
end

compe.setup({
   enabled          = true,
   autocomplete     = true,
   debug            = false,
   min_length       = 1,
   preselect        = 'enable',
   throttle_time    = 80,
   source_timeout   = 200,
   incomplete_delay = 400,
   max_abbr_width   = 100,
   max_kind_width   = 100,
   max_menu_width   = 100,
   documentation    = true,

   source = {
      path                  = {kind = '  '},
      buffer                = {kind = '  '},
      calc                  = {kind = '  '},
      vsnip                 = {kind = '  '},
      nvim_lsp              = {kind = '  '},
      -- nvim_lua              = {kind = '  '},
      nvim_lua              = false,
      spell                 = {kind = '  '},
      tags                  = false,
      vim_dadbod_completion = true,
      snippets_nvim         = {kind = '  '},
      ultisnips             = {kind = '  '},
      treesitter            = {kind = '  '},
   }
})

local t = function (s)
   return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local check_back_space = function ()
   local col = fn.col('.') - 1

   if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
      return true
   end

   return false
end

-- use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder

_G.tab_complete = function ()
   if fn.pumvisible() == 1 then
      return t '<C-n>'
   elseif fn.call('vsnip#available', {1}) == 1 then
      return t '<plug>(vsnip-expand-or-jump)'
   elseif check_back_space() then
      return t '<tab>'
   else
      return fn['compe#complete']()
   end
end

_G.s_tab_complete = function ()
   if fn.pumvisible() == 1 then
      return t '<c-p>'
   elseif fn.call('vsnip#jumpable', {-1}) == 1 then
      return t '<plug>(vsnip-jump-prev)'
   else
      return t '<s-tab>'
   end
end

-- keymaps

local modifiers = {
   expr   = true,
   silent = true,
}

require('sol.vim').apply_keymaps({
   {'i', '<Tab>',   'pumvisible() ? v:lua.tab_complete()   : "\\<tab>"',   modifiers},
   {'s', '<Tab>',   'pumvisible() ? v:lua.tab_complete()   : "\\<tab>"',   modifiers},
   {'i', '<S-Tab>', 'pumvisible() ? v:lua.s_tab_complete() : "\\<s-tab>"', modifiers},
   {'s', '<S-Tab>', 'pumvisible() ? v:lua.s_tab_complete() : "\\<s-tab>"', modifiers},

   --{'i', '<cr>',  'compe#confirm("<cr>")',       {expr = true, silent = true}},
   {'i', '<C-e>', 'pumvisible() ? compe#close("<C-e>") : "\\<C-e>"',        modifiers},
   {'i', '<C-u>', 'pumvisible() ? compe#scroll({"delta": +4}) : "\\<C-u>"', modifiers},
   {'i', '<C-d>', 'pumvisible() ? compe#scroll({"delta": -4}) : "\\<C-d>"', modifiers},
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

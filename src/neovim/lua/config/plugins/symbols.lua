--- symbols-outline configuration

local has_symbols_outline, symbols_outline = pcall(require, 'symbols-outline')

if not has_symbols_outline then
   vim.notify('‼ Tried loading symbols-outline ... unsuccessfully.')
   return has_symbols_outline
end

symbols_outline.setup({
   highlight_hovered_item = true, -- whether to highlight the currently hovered symbol
   show_guides            = true, -- whether to show outline guides
})

require('sol.vim').apply_keymaps({
   {'n', '<leader>cS', '<cmd>SymbolsOutline<CR>', {silent = true, noremap = true}}
})

--- whichkey configuration

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      S = {'Show LSP symbols'},
   },
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

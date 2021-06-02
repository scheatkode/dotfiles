--- configure treesitter

local has_treesitter, treesitter = pcall(require, 'nvim-treesitter.configs')

if not has_treesitter then
   print('‼ Tried loading treesitter ... unsuccessfully.')
   return has_treesitter
end

treesitter.setup({
   ensure_installed = 'maintained',

   autopairs             = { enable = true },
   autotag               = { enable = true },
   context_commentstring = { enable = true },
   highlight             = { enable = true },
   indent                = { enable = true },
   lsp_interop           = { enable = true },

   textobjects = {
      lsp_interop = {
         enable = true,
      },

      select = {
         enable  = true,
         keymaps = {
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
         },
      },

      swap = {
         enable    = true,
         swap_next = {
            ['<leader>cps'] = '@parameter.inner',
         },

         swap_previous = {
            ['<leader>cpS'] = '@parameter.inner',
         },
      },
   },

   -- playground specific
   -- playground = {
   --    enable          = true,
   --    updatetime      = 25,    -- debounced time for highlighting nodes
   --    persist_queries = false, -- persistence across vim sessions
   -- },

})

--- whichkey setup

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      p = {
         name = '+parameter',

         s = {'Swap next parameter'},
         S = {'Swap previous parameter'},
      }
   }
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

--- folke/which-key.nvim configuration

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   print('‼ Tried loading which-key.nvim ... unsuccessfully.')
   return has_whichkey
end

whichkey.setup({
   plugins = {
      marks     = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in normal or <C-r> in insert mode

      -- the presets plugin, adds help for a bunch of default keybindings in neovim
      -- no actual key bindings are created
      presets = {
         operators    = true, -- adds help for operators like d, y, ...
         motions      = true, -- adds help for motions
         text_objects = true, -- help for text objects triggered after entering an operator
         windows      = true, -- default bindings on <C-w>
         nav          = true, -- misc bindings to work with windows
         z            = true, -- bindings for folds, spelling and others prefixed with z
         g            = true, -- bindings for prefixed with g

         custom_operators = { gc = "Comments" }, -- add custom operators to get motion completion, like gc for commentary or kommentary
      },
   },

   icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator  = "→", -- symbol used between a key and it's label
      group      = "+", -- symbol prepended to a group
   },

   window = {
      border   = "single",       -- none, single, double, shadow
      position = "bottom",       -- bottom, top
      margin   = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding  = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
   },

   layout = {
      height  = { min = 4, max = 25 },  -- min and max height of the columns
      width   = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3,                      -- spacing between columns
      align   = 'center',
   },

   hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate

   show_help = true, -- show help message on the command line when the popup is visible

   triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = {'j','k',';','t','h','_'},
    v = {'j','k'},
   },
})

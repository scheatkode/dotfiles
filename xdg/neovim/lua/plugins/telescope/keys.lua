return require('util').register_keymaps({
   {
      mode    = 'n',
      keys    = '<leader>fF',
      command = '<cmd>lua require("plugins.telescope.config").files()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>FF',
      command = '<cmd>lua require("plugins.telescope.config").files()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader><leader>',
      command = '<cmd>lua require("plugins.telescope.config").files()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>nf',
      command = '<cmd>lua require("plugins.telescope.config").notes()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>nF',
      command = '<cmd>lua require("plugins.telescope.config").notes()<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>ff',
      command = '<cmd>Telescope file_browser<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Ff',
      command = '<cmd>Telescope file_browser<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fr',
      command = '<cmd>Telescope oldfiles<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Fr',
      command = '<cmd>Telescope oldfiles<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>fg',
      command = '<cmd>Telescope live_grep<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>Fg',
      command = '<cmd>Telescope live_grep<CR>'
   },

   {
      mode    = 'n',
      keys    = '<leader>pp',
      command = '<cmd>lua require("plugins.telescope.config").projects()<CR>'
   },

   {
      mode    = 'n',
      keys    = '<leader>bb',
      command = '<cmd>lua require("plugins.telescope.config").buffers()<CR>'
   },

   {
      mode    = 'n',
      keys    = '<leader>sh',
      command = '<cmd>Telescope help_tags<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>sl',
      command = '<cmd>Telescope current_buffer_fuzzy_find<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>sr',
      command = '<cmd>Telescope registers<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>sq',
      command = '<cmd>Telescope quickfix<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>sm',
      command = '<cmd>Telescope man_pages<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>st',
      command = '<cmd>Telescope treesitter<CR>'
   },

   {
      mode    = 'n',
      keys    = '<leader>clr',
      command = '<cmd>Telescope lsp_references<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>cld',
      command = '<cmd>Telescope lsp_document_symbols<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>clw',
      command = '<cmd>Telescope lsp_workspace_symbols<CR>'
   },
   {
      mode    = 'n',
      keys    = '<leader>clc',
      command = '<cmd>Telescope lsp_code_actions<CR>'
   },
   -- {'n', '<leader>clcr', '<cmd>Telescope lsp_range_code_actions<CR>'},

   {
      mode    = 'c',
      keys    = '<c-r><c-r>',
      command = '<Plug>(TelescopeFuzzyCommandSearch)',
      options = {
         noremap = false,
         nowait  = true,
         silent  = false
      }
   },
})

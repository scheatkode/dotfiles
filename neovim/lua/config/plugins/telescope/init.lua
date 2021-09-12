--- telescope configuration

local has_telescope, telescope = pcall(require, 'telescope')

if not has_telescope then
   print('‼ Tried loading telescope ... unsuccessfully.')
   return has_telescope
end

local actions    = require('telescope.actions')
local builtin    = require('telescope.builtin')
local previewers = require('telescope.previewers')
local themes     = require('telescope.themes')

local m = {}

-- setup

telescope.setup({
   defaults = {
      file_previewer     = previewers.vim_buffer_cat.new,
      grep_previewer     = previewers.vim_buffer_vimgrep.new,
      qflist_previewer   = previewers.vim_buffer_qflist.new,
      prompt_prefix      = '❯ ',
      shorten_path       = true,
      scroll_strategy    = 'cycle',
      selection_strategy = 'reset',
      layout_stategy     = 'flex',

      borderchars = { -- rounded corners
         '─', '│', '─', '│', '╭', '╮', '╯', '╰',
      },

      -- borderchars = { -- angled corners
      --    '─', '│', '─', '│', '┌', '┐', '┘', '└',
      -- },

      layout_config = {
         horizontal = {
            width_padding  = 0.1,
            height_padding = 0.1,
            preview_width  = 0.6
         },

         vertical = {
            width_padding  = 0.05,
            height_padding = 1,
            preview_height = 0.5
         }
      },

      mappings = {
         i = {
            ['<c-j>'] = actions.move_selection_next,
            ['<c-k>'] = actions.move_selection_previous,

            ['<cr>']  = actions.select_default,
            ['<c-v>'] = actions.select_vertical,
            ['<c-s>'] = actions.select_horizontal,
            ['<c-x>'] = false,

            -- ['<c-t>']  = actions.open_selected_files,
            -- ['<c-a>']  = actions.cycle_previewers_prev,
            -- ['<c-w>l'] = actions.preview_switch_window_right,

            ['<c-u>'] = actions.preview_scrolling_up,
            ['<c-d>'] = actions.preview_scrolling_down,

            -- ['<c-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            -- ['<a-q>'] = actions.smart_add_to_qflist  + actions.open_qflist,

            ['<tab>'] = actions.toggle_selection + actions.move_selection_next,

            -- ['<c-c>'] = actions.close,
            ['<esc>'] = actions.close,
         },

         n = {
            ['<c-j>'] = actions.move_selection_next,
            ['<c-k>'] = actions.move_selection_previous,
            ['j']     = actions.move_selection_next,
            ['k']     = actions.move_selection_previous,

            ['<cr>']  = actions.select_default + actions.center,
            ['<c-v>'] = actions.select_vertical,
            ['<c-s>'] = actions.select_horizontal,
            ['<c-x>'] = false,

            ['<c-d>'] = actions.preview_scrolling_down,
            ['<c-u>'] = actions.preview_scrolling_up,

            ['<c-q>'] = actions.send_to_qflist,

            ['<c-c>'] = actions.close,
            ['<esc>'] = actions.close,
            ['q']     = actions.close,

            ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
         },
      },
   },

   pickers = {
      buffers = {
         sort_mru  = true,
         theme     = 'dropdown',
         previewer = false,
         mappings = {
            i = {
               ['<c-x>'] = actions.delete_buffer,
            },
            n = {
               ['<c-x>'] = actions.delete_buffer,
            },
         },
      },
   },

   extensions = {
      fzy_native = {
         override_generic_sorter = true,
         override_file_sorter    = true,
      },

      fzf = {
         override_generic_sorter = true,         -- override the generic sorter
         override_file_sorter    = true,         -- override the file sorter
         case_mode               = 'smart_case', -- or "ignore_case" or "respect_case"
         fuzzy                   = true,         -- false will only do exact matching
      },

      media_files = {
         filetypes = { 'jpg', 'jpeg', 'png', 'webp', 'pdf', 'mkv' },
         find_cmd  = 'rg',
      },

      frecency = {
         show_scores     = false,
         show_unindexed  = true,
         ignore_patterns = {
            '*.git/*',
            '*/tmp/*'
         },
         workspaces = {
            ['neovim'] = '~/.config/nvim',
         }
      },
   }
})

-- pcall(telescope.load_extension, 'fzy_native')  -- superfast sorter
pcall(telescope.load_extension, 'fzf')         -- other superfast sorter
pcall(telescope.load_extension, 'frecency')    -- frecency
pcall(telescope.load_extension, 'project')     -- project picker
pcall(telescope.load_extension, 'media_files') -- media preview

m.grep_prompt = function ()
   builtin.grep_string({
      shorten_path = true,
      search       = vim.fn.input('Grep string ❯ '),
   })
end

m.files = function ()
   builtin.find_files({
      file_ignore_patterns = { '%.png', '%.jpg', '%webp' },
      shorten_path         = false
   })
end

m.frecency = function ()
   telescope.extensions.frecency.frecency()
end

m.buffer_fuzzy = function ()
   builtin.current_buffer_fuzzy_find()
end

m.code_actions = function ()
   builtin.lsp_code_actions()
end

m.projects = function ()
   telescope.extensions.project.project({ display_type = 'full' })
end

m.filebrowser = function ()
   builtin.file_explorer({
      attach_mappings = function (_, map)
      end,
   })
end

--- picker-specific

m.buffers = function ()
   builtin.buffers({
      attach_mappings = function (_, map)
         -- map('i', '<C-x>', custom_actions.delete_selected)
         -- map('n', '<C-x>', custom_actions.delete_selected)
         map('i', '<C-x>', actions.delete_buffer)
         map('n', '<C-x>', actions.delete_buffer)
         return true
      end,
   })
end

--- keymaps

require('sol.vim').apply_keymaps({

   {'n', '<leader>fF', '<cmd>lua require("config.plugins.telescope").files()<CR>'},
   {'n', '<leader>FF', '<cmd>lua require("config.plugins.telescope").files()<CR>'},
   {'n', '<leader><leader>', '<cmd>lua require("config.plugins.telescope").files()<CR>'},
   {'n', '<leader>ff', '<cmd>Telescope file_browser<CR>'},
   {'n', '<leader>Ff', '<cmd>Telescope file_browser<CR>'},
   {'n', '<leader>fr', '<cmd>Telescope oldfiles<CR>'},
   {'n', '<leader>Fr', '<cmd>Telescope oldfiles<CR>'},
   {'n', '<leader>fg', '<cmd>Telescope live_grep<CR>'},
   {'n', '<leader>Fg', '<cmd>Telescope live_grep<CR>'},

   {'n', '<leader>pp', '<cmd>lua require("config.plugins.telescope").projects()<CR>'},

   {'n', '<leader>bb', '<cmd>lua require("config.plugins.telescope").buffers()<CR>'},

   {'n', '<leader>sh',  '<cmd>Telescope help_tags<CR>'},
   {'n', '<leader>sl',  '<cmd>Telescope current_buffer_fuzzy_find<CR>'},
   {'n', '<leader>sr',  '<cmd>Telescope registers<CR>'},
   {'n', '<leader>sq',  '<cmd>Telescope quickfix<CR>'},
   {'n', '<leader>sm',  '<cmd>Telescope man_pages<CR>'},
   {'n', '<leader>st',  '<cmd>Telescope treesitter<CR>'},

   {'n', '<leader>clr', '<cmd>Telescope lsp_references<CR>'},
   {'n', '<leader>cld', '<cmd>Telescope lsp_document_symbols<CR>'},
   {'n', '<leader>clw', '<cmd>Telescope lsp_workspace_symbols<CR>'},
   {'n', '<leader>clc', '<cmd>Telescope lsp_code_actions<CR>'},
   -- {'n', '<leader>clcr', '<cmd>Telescope lsp_range_code_actions<CR>'},

   {'c', '<c-r><c-r>', '<Plug>(TelescopeFuzzyCommandSearch)', {noremap = false, nowait = true}},

})

--- whichkey configuration

local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      b = {
         name = '+buffers',

         b = {'Buffer search'},
      },

      c = {
         name = '+code',

         l = {
            name = '+lsp',

            c = {'Code actions'},
            d = {'Document symbols'},
            r = {'References'},
            w = {'Workspace symbols'},
         },
      },

      f = {
         name = '+files',

         F = {'Find file from here'},
         f = {'Find file'},
         g = {'Grep live'},
         r = {'Recent files'},
      },

      p = {
         name = '+projects',

         p = 'Project switch',
      },

      s = {
         name = '+search',

         h = {'Help tags'},
         l = {'Lines in current buffer'},
         m = {'Man pages'},
         q = {'Quickfix'},
         r = {'Registers'},
         t = {'Treesitter'},
      },

      ['<leader>'] = 'which_key_ignore',
                 F = 'which_key_ignore',
   }, {
      prefix = '<leader>'
})
end

--- return configuration

return setmetatable({}, {
   __index = function(_, k)
      if m[k] then
         return m[k]
      else
         return builtin[k]
      end
   end
})

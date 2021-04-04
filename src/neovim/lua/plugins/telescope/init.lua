-- fail early if telescope isn't installed and skip running the below code.

local ok, telescope = pcall(require, 'telescope')

if not ok then
   print('‼ Tried importing telescope ... unsuccessfully.')
   return
end

local actions    = require('telescope.actions')
local builtin    = require('telescope.builtin')
local previewers = require('telescope.previewers')

local apply = require('lib.config').keymaps.use

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
      borderchars        = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      layout_defaults    = {
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

            ['<tab>'] = actions.toggle_selection,

            ['<c-c>'] = actions.close,
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

            ['<tab>'] = actions.toggle_selection,
         },
      },
   },
   extensions = {
      fzy_native = {
         override_generic_sorter = true,
         override_file_sorter    = true,
      },
      media_files = {
         filetypes = { 'jpg', 'jpeg', 'png', 'webp', 'pdf', 'mkv' },
         find_cmd  = 'rg',
      },
      frecency = {
         show_scores     = false,
         show_unindexed  = true,
         ignore_patterns = { '*.git/*', '*/tmp/*' },
         workspaces = {
            ['neovim'] = '~/.config/nvim',
         }
      },
   }
})

pcall(telescope.load_extension, 'fzy_native')  -- superfast sorter
pcall(telescope.load_extension, 'media_files') -- media preview
pcall(telescope.load_extension, 'frecency')    -- frecency

m.grep_prompt = function ()
   builtin.grep_string({
      shorten_path = true,
      search       = vim.fn.input('Grep string ❯ '),
   })
end

m.files = function ()
   builtin.find_files({
      file_ignore_patterns = { '%.png', '%.jpg', '%webp' },
   })
end

local themed_preview = function ()
   return require('telescope.themes').get_dropdown({
      width       = 0.8,
      previewer   = true,
      borderchars = {
                   { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
         prompt  = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
         results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
         preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
   })
end

m.frecency = function ()
   telescope.extensions.frecency.frecency(themed_preview())
end

m.buffer_fuzzy = function ()
   builtin.current_buffer_fuzzy_find(themed_preview())
end

m.code_actions = function ()
   builtin.lsp_code_actions(themed_preview())
end

-- keymaps

local keymaps = {

   {'n', '<leader>fF',   '<cmd>Telescope find_files                theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>ff',   '<cmd>Telescope file_browser              theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>fr',   '<cmd>Telescope oldfiles                  theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>fg',   '<cmd>Telescope live_grep                 theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>bb',   '<cmd>Telescope buffers                   theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>sh',   '<cmd>Telescope help_tags                 theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>sl',   '<cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>sr',   '<cmd>Telescope registers                 theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>sq',   '<cmd>Telescope quickfix                  theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>sm',   '<cmd>Telescope man_pages                 theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>lr',   '<cmd>Telescope lsp_references            theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>lsd',  '<cmd>Telescope lsp_document_symbols      theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>lsw',  '<cmd>Telescope lsp_workspace_symbols     theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>lca',  '<cmd>Telescope lsp_code_actions          theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>lrca', '<cmd>Telescope lsp_range_code_actions    theme=get_dropdown<CR>', {silent = true, noremap = true}},
   {'n', '<leader>lts',  '<cmd>Telescope treesitter                theme=get_dropdown<CR>', {silent = true, noremap = true}},

   {'c', '<c-r><c-r>', '<Plug>(TelescopeFuzzyCommandSearch)', {noremap = false, nowait = true}},

}

apply(keymaps)

return setmetatable({}, {
   __index = function(_, k)
      if m[k] then
         return m[k]
      else
         return builtin[k]
      end
   end
})



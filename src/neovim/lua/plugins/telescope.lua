local actions = require('telescope/actions')
local apply   = require('core/config').keymaps.use

-- setup

require('telescope').setup {
    defaults = {
        file_previewer     = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer     = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer   = require('telescope.previewers').vim_buffer_qflist.new,
        prompt_prefix = '❯',
        shorten_path = true,
        scroll_strategy    = 'cycle',
        selection_strategy = 'reset',
        layout_stategy     = 'flex',
        -- borderchars        = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
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
        default_mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,

                ['<CR>'] = actions.select_default,
                ['<C-v>'] = actions.select_vertical,
                ['<C-s>'] = actions.select_horizontal,
                ['<C-x>'] = false,

                ['<C-c>'] = actions.close,
                ['<Esc>'] = actions.close,

                ['<Tab>'] = actions.toggle_selection,
            },
            n = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['j'] = actions.move_selection_next,
                ['k'] = actions.move_selection_previous,

                ['<CR>'] = actions.select_default,
                ['<C-v>'] = actions.select_vertical,
                ['<C-s>'] = actions.select_horizontal,
                ['<C-x>'] = false,

                ['<C-c>'] = actions.close,
                ['<Esc>'] = actions.close,

                ['<Tab>'] = actions.toggle_selection,
            },
        }
    }
}


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


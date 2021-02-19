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

                ['<CR>'] = actions.goto_file_selection_edit,
                ['<C-v>'] = actions.goto_file_selection_vsplit,
                ['<C-s>'] = actions.goto_file_selection_split,
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

                ['<CR>'] = actions.goto_file_selection_edit,
                ['<C-v>'] = actions.goto_file_selection_vsplit,
                ['<C-s>'] = actions.goto_file_selection_split,
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
   {'n', '<leader>ff', '<cmd>Telescope find_files<CR>', {silent = true, noremap = true}},
   {'n', '<leader>fr', '<cmd>Telescope oldfiles<CR>',   {silent = true, noremap = true}},
   {'n', '<leader>fg', '<cmd>Telescope live_grep<CR>',  {silent = true, noremap = true}},
   {'n', '<leader>bb', '<cmd>Telescope buffers<CR>',    {silent = true, noremap = true}},
   {'n', '<leader>sh', '<cmd>Telescope help_tags<CR>',  {silent = true, noremap = true}},

   {'c', '<c-r><c-r>', '<Plug>(TelescopeFuzzyCommandSearch)', {noremap = false, nowait = true}},
}

apply(keymaps)


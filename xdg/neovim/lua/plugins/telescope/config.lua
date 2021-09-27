--- telescope configuration

local log = require('log')

local has_telescope, telescope = pcall(require, 'telescope')

if not has_telescope then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'telescope')
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
      -- shorten_path       = true,
      scroll_strategy    = 'cycle',
      selection_strategy = 'reset',
      layout_stategy     = 'flex',

      path_display = {
      },

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
         sort_lastused = true,
         theme         = 'dropdown',
         previewer     = false,
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
         db_root = vim.fn.stdpath('data') .. '/db',
         workspaces = {
            ['neovim'] = '~/.config/nvim',
            ['rep'] = '~/repositories',
         }
      },
   }
})

-- pcall(telescope.load_extension, 'fzy_native')  -- superfast sorter
pcall(telescope.load_extension, 'fzf')         -- other superfast sorter
pcall(telescope.load_extension, 'frecency')    -- frecency
pcall(telescope.load_extension, 'project')     -- project picker
-- pcall(telescope.load_extension, 'media_files') -- media preview

m.grep_prompt = function ()
   builtin.grep_string({
      search = vim.fn.input('Grep string ❯ '),
   })
end

m.files = function ()
   builtin.find_files({
      file_ignore_patterns = { '%.png', '%.jpg', '%webp' },
   })
end

m.notes = function ()
   builtin.find_files({
      prompt_title = '< Notes >',
               cwd = '~/brain/',
   })
end

m.file_explorer = function ()
   builtin.file_browser({
      file_ignore_patterns = { '%.png', '%.jpg', '%webp' },
      attach_mappings = function (_, _)
         -- map('i', actions.)
      end,
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

--- picker-specific

m.buffers = function ()
   builtin.buffers({
      attach_mappings = function (_, map)
         map('i', '<C-x>', actions.delete_buffer)
         map('n', '<C-x>', actions.delete_buffer)

         return true
      end,
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

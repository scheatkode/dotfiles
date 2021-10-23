local mmin   = math.min
local themes = require('telescope.themes')

function themes.get_vertical (opts)
   opts = opts or {}

   local theme_opts = {
      layout_strategy  = 'vertical',
      sorting_strategy = 'descending',
      results_title    = false,

      layout_config = {
         prompt_position = 'bottom',
         preview_cutoff  = 1,

         width = function (_, max_columns, _)
            return mmin(max_columns, 90)
         end,

         height = function (_, _, max_lines)
            return mmin(max_lines, 40)
         end,
      },

      border      = true,
      borderchars = {
         preview = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
         results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
         prompt  = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },
   }

   return vim.tbl_deep_extend('force', theme_opts, opts)
end

function themes.get_better_cursor (opts)
   opts = opts or {}

   local theme_opts = {
      layout_strategy  = 'cursor',
      sorting_strategy = 'ascending',
      results_title    = false,

      layout_config = {
         prompt_position = 'bottom',
         preview_cutoff  = 1,

         width = function (_, max_columns, _)
            return mmin(max_columns, 65)
         end,

         height = function (_, _, max_lines)
            return mmin(max_lines, 2)
         end,
      },

      border      = true,
      borderchars = {
         preview = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
         results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
         prompt  = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },
   }

   return vim.tbl_deep_extend('force', theme_opts, opts)
end

return themes

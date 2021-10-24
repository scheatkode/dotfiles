local f = require('lib.f')

local telescope = require('telescope')

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local themes  = require('plugins.telescope.themes')

local mmin = math.min

local m = {}

function m.live_grep (open_files)
   open_files = open_files or false

   return builtin.live_grep(themes.get_vertical({
      grep_open_files = open_files,
      max_results     = 200,
      prompt_title    = open_files
         and 'Live Grep Open Files'
         or  'Live Grep',
   }))
end

function m.grep_string ()
   return builtin.grep_string()
end

function m.find_files (hidden, no_ignore)
   local prompt_title

   hidden    = hidden    or false
   no_ignore = no_ignore or false

   if hidden and no_ignore then
      prompt_title = 'Find Hidden & Ignored Files'
   elseif hidden then
      prompt_title = 'Find Hidden Files'
   elseif no_ignore then
      prompt_title = 'Find Ignored Files'
   else
      prompt_title = 'Find Files'
   end

   return builtin.find_files({
            hidden = hidden,
         no_ignore = no_ignore,
      prompt_title = prompt_title,
   })
end

function m.project_or_find_files ()
   --- `buf_get_clients()` most likely won't return a contiguous list. This
   --- gets the most "generic" LSP client for the current buffer, using a dumb
   --- string length comparison of the `root_dir` property.
   local clients = f
      .iterate(vim.lsp.buf_get_clients())
      :filter(function (x) return x and x.config ~= nil end)

   local has_clients, client = pcall(
      f.minimum_by,
      function (x, y) return #x.config.root_dir < #y.config.root_dir end,
      clients
   )

   if has_clients then
      return builtin.find_files({
         prompt_title = 'Find Files in Project',
         cwd = client.config.root_dir,
      })
   end

   local git_dir = vim.fn.finddir('.git', ';')

   if git_dir ~= '' then
      return builtin.git_files({
         prompt_title = 'Find Files in Repository',
         -- recurse_submodules = true,
      })
   end

   return m.find_files()
end

function m.find_notes ()
   return builtin.find_files({
      prompt_title = ' Notes ',
               cwd = '~/brain/',
   })
end

function m.file_explorer ()
   return builtin.file_browser(themes.get_ivy())
end

function m.git_commits ()
   return builtin.git_commits(themes.get_vertical())
end

function m.git_current_file_commits ()
   return builtin.git_bcommits(themes.get_vertical({
      prompt_title = 'Git Commits involving Current File'
   }))
end

function m.git_branches ()
   return builtin.git_branches(themes.get_vertical())
end

function m.buffer_fuzzy ()
   return builtin.current_buffer_fuzzy_find(themes.get_vertical())
end

function m.commands ()
   return builtin.commands()
end

function m.quickfix ()
   return builtin.quickfix(themes.get_vertical())
end

function m.loclist ()
   return builtin.loclist(themes.get_vertical())
end

function m.oldfiles ()
   return builtin.loclist()
end

function m.vim_options ()
   return builtin.vim_options(themes.get_vertical())
end

function m.help_tags ()
   return builtin.help_tags(themes.get_vertical())
end

function m.man_pages ()
   return builtin.man_pages(themes.get_vertical())
end

function m.buffers (all_buffers)
   all_buffers = all_buffers or false

   return builtin.buffers(themes.get_vertical({
      ignore_current_buffer = true,
      show_all_buffers      = all_buffers,
      sort_lastused         = true,

      attach_mappings = function (_, map)
         map('i', '<C-x>', actions.delete_buffer)
         map('n', '<C-x>', actions.delete_buffer)

         return true
      end,
   }))
end

function m.marks ()
   return builtin.marks(themes.get_vertical())
end

function m.registers ()
   return builtin.registers(themes.get_vertical())
end

function m.keymaps ()
   return builtin.keymaps(themes.get_vertical())
end

function m.autocommands ()
   return builtin.autocommands(themes.get_vertical())
end

function m.spell_suggest ()
   return builtin.spell_suggest(themes.get_cursor())
end

function m.lsp_references ()
   return builtin.lsp_references(themes.get_vertical())
end

function m.lsp_definitions ()
   return builtin.lsp_definitions(themes.get_vertical())
end

function m.lsp_type_definitions ()
   return builtin.lsp_type_definitions(themes.get_vertical())
end

function m.lsp_implementations ()
   return builtin.lsp_type_definitions(themes.get_vertical())
end

function m.lsp_code_actions ()
   return builtin.lsp_code_actions(themes.get_better_cursor())
end

function m.lsp_range_code_actions ()
   return builtin.lsp_range_code_actions(themes.get_better_cursor())
end

function m.lsp_document_symbols ()
   return builtin.lsp_document_symbols(themes.get_vertical({
      show_line = true,
   }))
end

function m.lsp_workspace_symbols ()
   return builtin.lsp_workspace_symbols(themes.get_vertical({
      show_line = true,
   }))
end

function m.lsp_workspace_dynamic_symbols ()
   return builtin.lsp_workspace_dynamic_symbols(themes.get_vertical({
      show_line = true,
   }))
end

function m.lsp_document_diagnostics ()
   return builtin.lsp_document_diagnostics(themes.get_vertical({
      show_line = true,
   }))
end

function m.lsp_workspace_diagnostics ()
   return builtin.lsp_workspace_diagnostics(themes.get_vertical({
      show_line = true,
   }))
end

function m.frecency ()
   return telescope.extensions.frecency.frecency()
end

function m.projects ()
   return telescope.extensions.project.project({
      display_type   = 'full',
      layout_stategy = 'vertical',
      layout_config = {
         width  = function (_, max_columns, _)
            return mmin(max_columns, 90)
         end,
         height = function (_, _, max_lines)
            return mmin(max_lines, 40)
         end,
      }
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

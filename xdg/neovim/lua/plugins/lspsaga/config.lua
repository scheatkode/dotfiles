-- localize globals {{{

local log = require('log')

-- }}}
-- check for plugin existence {{{

local has_saga, saga = pcall(require, 'lspsaga')

if not has_saga then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'lsp-saga')
   return has_saga
end

-- }}}
-- configure plugin {{{

saga.init_lsp_saga({
   use_saga_diagnostic_sign = true,
   dianostic_header_icon    = '   ',

   error_sign = '⬤',
   warn_sign  = '⬤',
   hint_sign  = '⬤',
   infor_sign = '⬤',

   code_action_icon   = ' ',
   code_action_prompt = {
      enable        = true,
      sign          = true,
      sign_priority = 20,
      virtual_text  = true,
   },
   code_action_keys = {
      quit = {'q', '<Esc>'},
      exec = '<CR>',
   },

   max_preview_lines = 20, -- preview lines of lsp_finder and definition preview

   finder_definition_icon = '  ',
   finder_reference_icon  = '  ',
   finder_action_keys     = {
      open        = 'o',
      vsplit      = 's',
      split       = 'i',
      quit        = {'q', '<Esc>'}, -- quit can be a table
      scroll_down = '<C-u>',
      scroll_up   = '<C-d>',
   },

   rename_prompt_prefix = '❯ ',
   rename_action_keys   = {
      quit = {'<C-c>', '<Esc>'},  -- quit can be a table
      exec = '<CR>',
   },

   definition_preview_icon = '丨  ',

   border_style = 'round', -- "single" | "double" | "round" | "plus"

   -- if you don't use nvim-lspconfig you must pass your server name and
   -- the related filetypes into this table
   -- like server_filetype_map = {metals = {'sbt', 'scala'}}

   server_filetype_map = {},
})

-- }}}

log.info('Plugin loaded', 'lspsaga')

return true

-- vim: set fdm=marker fdl=0:

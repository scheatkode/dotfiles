--- indent guides configuration

local log = require('log')

require('indent_blankline')
local has_iguides, iguides = pcall(require, 'indent_blankline')

if not has_iguides then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'indent-guides')
   return has_iguides
end


iguides.setup {
   -- default configuration

              char = '│',
      indent_level = 10,
   viewport_buffer = 30,

   -- treesitter related configuration

                   use_treesitter = true,
             show_current_context = true,
   show_trailing_blankline_indent = false,

   context_patterns = {
      'arguments',
      'array',
      'block',
      'class',
      'for',
      'function',
      'if',
      'method',
      'object',
      'table',
      'while',
   },

   -- excludes

   buftype_exclude = {
      'nofile',
      'terminal',
   },

   filetype_exclude = {
      'LspTrouble',
      'Outline',
      'help',
      'norg',
      'packer',
      'startify',
   },
}

log.info('Plugin loaded', 'indent-guides')

return true

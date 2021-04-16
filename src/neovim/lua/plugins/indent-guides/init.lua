vim.g.indent_blankline_indent_level         = 5
vim.g.indent_blankline_char                 = '│'
-- vim.g.indent_blankline_char_list            = {'┊', '│'}
vim.g.indent_blankline_use_treesitter                 = true
vim.g.indent_blankline_show_current_context           = true -- requires treesitter
vim.g.indent_blankline_show_trailing_blankline_indent = false

vim.g.indentLine_bufTypeExclude  = { 'terminal', }
vim.g.indentLine_fileTypeExclude = {
   'startify',
   'help',
}

vim.g.indent_blankline_context_patterns = {
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
}

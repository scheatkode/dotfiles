local global = vim.g -- a table to access vim's global variables

-- leader key

-- it's generally a good idea to set this early on  and  before  any  mapping.
-- this is to avoid mapping with the old leader.

global.mapleader      = ' '
global.maplocalleader = ' '



vim.cmd('runtime macros.justify.vim') -- i simply cannot live without this
vim.cmd('set invlist') -- FIXME: find a way to integrate with other options

require('modules.lsp')

require('lsp.symbols')

require('config')

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80

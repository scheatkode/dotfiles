--[[
-- MODELINE, NOTES, AND SUMMARY
--
--  modeline :
--    vim: set sw=3 ts=3 sts=3 et tw=78 fmr={{{,}}} fdl=0 fdm=marker:
--
--  changelog :
--      - removed this section's fold to see the todo list every time the file
--        is opened
--      - removed the todo list to put it in org-mode
--]]

local global = vim.g   -- a table to access vim's global variables


-- leader key

-- it's generally a good idea to set this early on  and  before  any  mapping.
-- this is to avoid mapping with the old leader.

global.mapleader      = ' '
global.maplocalleader = ' '

-- plugins

-- load plugins using packer.

if not require('plugins') then
   return
end

require('lib.options')
require('lib.mappings')

vim.cmd('runtime macros.justify.vim') -- i simply cannot live without this
vim.cmd('set invlist') -- FIXME: find a way to integrate with other options

require('modules.visual')
require('modules.statusline')
require('modules.lsp')

require('plugins.align')
require('plugins.completion')
require('plugins.nvim-tree')
require('plugins.surround')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.sudo')
require('plugins.git')
require('plugins.autopairs')

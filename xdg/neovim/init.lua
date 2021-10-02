-- leader key

-- it's generally a good idea  to set this early on and
-- before any  mapping. this  is to avoid  mapping with
-- the old leader.

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- disable built-in plugins

local disabled_built_ins = {
   'netrw',
   'netrwPlugin',
   'netrwSettings',
   'netrwFileHandlers',
   'gzip',
   'zip',
   'zipPlugin',
   'tar',
   'tarPlugin',
   'getscript',
   'getscriptPlugin',
   'vimball',
   'vimballPlugin',
   '2html_plugin',
   'logipat',
   'rrhelper',
   'spellfile_plugin',
   'matchit'
}

for _, plugin in ipairs(disabled_built_ins) do
   vim.g['loaded_' .. plugin] = 1
end

-- miscellaneous

vim.cmd('runtime macros.justify.vim') -- i simply cannot live without this
vim.cmd('set invlist') -- FIXME: find a way to integrate with other options

vim.cmd([[:command! RandomLine execute 'normal! '.(matchstr(system('od -vAn -N3 -tu4 /dev/urandom'), '^\_s*\zs.\{-}\ze\_s*$') % line('$')).'G']])

-- configuration

require('scheatkode.global')
require('scheatkode.settings')
require('scheatkode.autocmds')
require('scheatkode.commands')
require('scheatkode.mappings')
require('config') -- user configuration
-- require('lsp')    -- lsp configuration

if not require('plugins') then
   return false
end

require('scheatkode.whitespace')
-- require('scheatkode.numbers')

-- garbage collection

collectgarbage('setpause',   260)
collectgarbage('setstepmul', 500)

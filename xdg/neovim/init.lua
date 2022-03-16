-- setup package path

-- to   prevent  code   duplication,  a   library  with
-- utilities commonly used in lua has been extracted to
-- a different location.

do
   local pack_path = (
         os.getenv('XDG_CONFIG_HOME')
      or os.getenv('HOME') .. '/.config'
   ) .. '/lib/lua'

   package.path = string.format(
      '%s;%s/?.lua;%s/?/init.lua',
      package.path,
      pack_path,
      pack_path
   )
end

-- startup improvement

do
   local has_impatient, _ = pcall(require, 'impatient')

   if not has_impatient then
      print('impatient.nvim not found, startup optimizations unavailable')
   end
end

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
   vim.g['loaded_' .. plugin] = 2
end

-- miscellaneous

vim.cmd('packadd justify') -- i simply cannot live without this
vim.cmd('set invlist') -- FIXME: find a way to integrate with other options

vim.cmd([[:command! RandomLine execute 'normal! '.(matchstr(system('od -vAn -N3 -tu4 /dev/urandom'), '^\_s*\zs.\{-}\ze\_s*$') % line('$')).'G']])

-- configuration

require('scheatkode.global')
require('scheatkode.settings')
require('scheatkode.autocmds')
require('scheatkode.commands')
require('scheatkode.mappings')

require('diagnostics').setup()

require('colors').load('gruvvy')

if not require('plugins') then
   return false
end

require('scheatkode.whitespace')
-- require('scheatkode.numbers')

-- garbage collection

collectgarbage('setpause',   260)
collectgarbage('setstepmul', 500)

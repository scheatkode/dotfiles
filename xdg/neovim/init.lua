-- Setup package path

-- To prevent code duplication, a library with utilities
-- commonly used in lua has been extracted to a different
-- location.

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

-- Leader key

-- It's generally a good idea  to set this early on and
-- before any  mapping. this  is to avoid  mapping with
-- the old leader.

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('', '<Space>', '<Nop>')

-- miscellaneous

vim.cmd('packadd justify') -- i simply cannot live without this
vim.cmd('set invlist') -- FIXME: find a way to integrate with other options

-- configuration

require('user.builtins').setup()

require('scheatkode.global')
require('user.settings').setup()
require('scheatkode.autocmds').setup()
require('scheatkode.commands').setup()
require('user.mappings').setup()

require('scheatkode.providers').disable()

require('diagnostics').setup()

require('colors').load('gruvvy')

require('plugins').setup()

require('scheatkode.whitespace')
-- require('scheatkode.numbers')

-- garbage collection

collectgarbage('setpause',   260)
collectgarbage('setstepmul', 500)

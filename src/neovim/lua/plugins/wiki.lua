local apply_conf = require('core/config').variables.use
local apply_maps = require('core/config').keymaps.use

local configuration = {
   vimwiki_list = {{
      path   = '~/brain/wiki',
      automatic_nested_syntaxes = 1,
      syntax = 'markdown',
      ext    = '.md',
   }}
}

local keymaps = {

   -- global mappings

   {'n', '<leader>oi',  '<Plug>VimwikiIndex',                  { noremap = true }},
   {'n', '<leader>os',  '<Plug>VimwikiUISelect',               { noremap = true }},
   {'n', '<leader>od',  '<Plug>VimwikiDiaryIndex',             { noremap = true }},
   {'n', '<leader>odt', '<Plug>VimwikiMakeDiaryNote',          { noremap = true }},
   {'n', '<leader>ody', '<Plug>VimwikiMakeYesterdayDiaryNote', { noremap = true }},
   {'n', '<leader>odm', '<Plug>VimwikiMakeTomorrowDiaryNote',  { noremap = true }},

   -- local mappings
}

apply_conf('g', configuration)
apply_maps(keymaps)


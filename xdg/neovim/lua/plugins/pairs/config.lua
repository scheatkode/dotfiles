local log = require('log')

local has_pairs,      pairs  = pcall(require, 'nvim-autopairs')
local has_engine,     engine = pcall(require, 'nvim-autopairs.completion.cmp')
local has_treesitter, _      = pcall(require, 'nvim-treesitter.configs')

if not has_pairs then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-autopairs')
   return has_pairs
end

if has_engine then
   engine.setup {
      map_cr       = true,
      map_complete = true,
      auto_select  = true,
   }
end

if has_treesitter then
   pairs.setup {
      disable_in_macro = true,
      check_ts = true,
   }
else
   pairs.setup {
      disable_in_macro = true,
   }

   log.warn(
      'Treesitter not found, autopairs will have limited functionality',
      'nvim-autopairs'
   )
end

log.info('Plugin loaded', 'nvim-autopairs')

return true

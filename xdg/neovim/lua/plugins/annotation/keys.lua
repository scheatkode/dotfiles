local function setup ()
   local annotation = require('neogen')

   vim.keymap.set('n', '<leader>cn', annotation.generate, {desc = 'Generate annotation for current node'})

   vim.keymap.set('n', '<leader>cnf', function () annotation.generate({type = 'func'}) end,  {desc = 'Generate annotation for current function'})
   vim.keymap.set('n', '<leader>cnc', function () annotation.generate({type = 'class'}) end, {desc = 'Generate annotation for current class'})
   vim.keymap.set('n', '<leader>cnt', function () annotation.generate({type = 'type'}) end,  {desc = 'Generate annotation for current type'})
end

return {
   setup = setup
}

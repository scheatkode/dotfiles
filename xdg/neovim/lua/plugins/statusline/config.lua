local has_statusline, statusline = pcall(require, 'lualine')

if not has_statusline then
   print('Tried loading plugin ... unsuccessfully ‼', 'lualine')
   return has_statusline
end


statusline.setup({
   options = {
      theme = require('colors').current().lualine()
   }
})

vim.g.format_options_uncrustify = require('format.defaults').uncrustify

return {
   formatCommand = ([[
      /usr/bin/uncrustify
		-c ]] .. vim.fn.stdpath('config') .. '/3rd/uncrustify.cfg' .. [[
      --no-backup
      -l ]] .. vim.bo.filetype .. [[
   ]]):gsub('\n', ' '),
   formatStdin = true,
}

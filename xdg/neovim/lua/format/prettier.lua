vim.g.format_options = require('format.defaults').prettier

return {
   formatCommand = ([[
      ~/.yarn/bin/prettier
      ${--no-semi:noSemi}
      ${--use-tabs:useTabs}
      ${--tab-width:tabWidth}
      ${--print-width:printWidth}
      ${--single-quote:singleQuote}
      ${--trailing-comma:trailingComma}
      ${--config-precedece:configPrecedence}
   ]]):gsub('\n', '')
}

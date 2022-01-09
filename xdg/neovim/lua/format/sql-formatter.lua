return {
   formatCommand = ([[
      ~/.yarn/bin/sql-formatter
      --indent 3
      --uppercase
      --lines-between-queries 2
   ]]):gsub('\n', '')
}

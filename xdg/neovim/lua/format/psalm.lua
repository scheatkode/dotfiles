return {
   lintCommand = ([[
      ./vendor/bin/psalm
      --output-format=emacs
      --no-progress
   ]]):gsub('\n', ''),
   lintFormats = {
      '%f:%l:%c:%trror - %m',
      '%f:%l:%c:%tarning - %m',
   }
}

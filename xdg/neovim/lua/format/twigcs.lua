return {
   lintCommand = ([[
      '/vendor/bin/twigcs
      --exclude vendor
      --reporter emacs
      --no-interaction
   ]]):gsub('\n', ''),
   lintFormats = {
      '%f:%l:%c:%trror - %m',
      '%f:%l:%c:%tarning - %m',
   }
}

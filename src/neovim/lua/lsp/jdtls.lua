local fn = vim.fn
local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for jdtls ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd = {
      fn.stdpath('config')
         .. '/scripts/launch_jdtls.sh',
      fn.stdpath('cache')
         .. '/workspace/'
         .. fn.fnamemodify(fn.getcwd(), ':p:h:t')
   },

   filetypes = { 'java' },

   root_dir = lspconfig.util.root_pattern(
      'gradle.build',
      'gradlew',
      'pom.xml',
      '.git'
   )
}

-- return jdtls.start_or_attach({
--    cmd = {
--       fn.stdpath('config')
--          .. '/scripts/launch_jdtls.sh',
--       fn.stdpath('cache')
--          .. '/workspace'
--          .. fn.fnamemodify(fn.getcwd(), ':p:h:t')
--    },

--    root_dir = require('jdtls.setup').find_root({
--       'gradle.build',
--       'gradlew',
--       'pom.xml',
--       '.git'
--    })
-- })

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

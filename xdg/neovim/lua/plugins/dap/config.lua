-- dependencies

local sign_define  = vim.fn.sign_define
local has_dap, dap = pcall(require, 'dap')

local log = require('log')

-- globals

local debuggers = {
   'php',
}

-- debugger configuration

local configure_debuggers = function (debugger_list)
   for _, debugger in ipairs(debugger_list) do
      local has_settings, settings = pcall(require, 'dap.' .. debugger)

      if not has_settings then
         log.error(
            'Missing configuration for debugger ' .. debugger,
            '‼ dap'
         )
         goto continue
      end

      if type(settings.before) == 'function' then
         settings.before()
      end

      dap.adapters[debugger]       = settings.adapter
      dap.configurations[debugger] = settings.configuration

      ::continue::
   end
end

local customize_signs = function ()
   sign_define('DapBreakpointRejected', {
      text   = '🛑',
      texthl = '',
      linehl = '',
      numhl  = '',
   })

   sign_define('DapBreakpoint', {
      text   = '→',
      texthl = 'Error',
      linehl = '',
      numhl  = '',
   })

   sign_define('DapStopped', {
      text   = '→',
      texthl = 'Success',
      linehl = '',
      numhl  = '',
   })

   sign_define('DapLogPoint', {
      text   = '',
      texthl = 'Question',
      linehl = '',
      numhl  = '',
   })
end

-- main {{{

if not has_dap then
   log.error('Tried loading plugin ... unsuccessfully', '‼ dap')
   return has_dap
end

dap.defaults.fallback.terminal_win_cmd = 'belowright 15new'
dap.defaults.fallback.force_external_terminal = false
-- dap.defaults.fallback.external_terminal = false

customize_signs()
configure_debuggers(debuggers)

vim.api.nvim_exec([[
   augroup repl
   autocmd! *                <buffer>
   autocmd FileType dap-repl <buffer> lua require('dap.ext.autocompl').attach()
   augroup End
]], false)

log.info('Plugin loaded', ' dap')

return true

-- }}}

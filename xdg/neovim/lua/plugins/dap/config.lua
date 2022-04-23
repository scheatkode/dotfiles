-- dependencies

local sign_define  = vim.fn.sign_define
local has_dap, dap = pcall(require, 'dap')

local log = require('log')

-- globals

local debuggers = {
	'go'
}

-- debugger configuration

local configure_debuggers = function (debugger_list)
   for _, debugger in ipairs(debugger_list) do
      local has_settings, settings = pcall(require, 'dbg.' .. debugger)

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

customize_signs()
configure_debuggers(debuggers)

log.info('Plugin loaded', ' dap')

return true

-- }}}

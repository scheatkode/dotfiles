-------------------------------- util namespace --------------------------------

local fn = vim.fn
local m  = {}

--- confirm user approval.
--
-- shows a prompt asking the user to press either 'y' or 'n'
--
-- @param message string → message to be printed to the user.
-- @return boolean       → user approval.

m.confirm = nil
m.confirm = function(message)
   print(message .. ' (y/n): ')

   local answer = string.char(fn.getchar())
   -- local answer = io.read(1)

   if     'y' == answer then return true
   elseif 'n' == answer then return false
   else
      print('Please enter either "y" or "n"')
      return m.confirm(message)
   end
end

-------------------------------- module exports --------------------------------

-- the module is exported here.

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80

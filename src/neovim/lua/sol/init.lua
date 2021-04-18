------------------------------------- sol --------------------------------------
--                                                                            --
--   contains miscellaneous functionality for dealing with lua shortcomings.  --
--                                                                            --
--------------------------------------------------------------------------------

return setmetatable({}, {
   __index = function (table, file)
      local ok, library = pcall(require, 'sol.', .. file)

      if not ok then
         error('Library ' .. file .. ' not found.')
         return ok
      end

      return library
   end,
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80

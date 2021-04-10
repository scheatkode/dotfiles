local m = setmetatable({}, {
   __index = function (table, file)
      local ok, icons = pcall(require, 'icons.' .. file)

      if not ok then
         error('Icon set ' .. file .. ' not found.')
         return ok
      end

      return icons
   end,
})

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:

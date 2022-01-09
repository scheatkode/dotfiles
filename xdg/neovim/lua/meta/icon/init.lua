return setmetatable({}, {
   __index = function (table, file)
      local ok, icons = pcall(require, 'meta.icon.' .. file)

      if not ok then
         error('Icon set ' .. file .. ' not found.')
         return ok
      end

      return icons
   end,
})

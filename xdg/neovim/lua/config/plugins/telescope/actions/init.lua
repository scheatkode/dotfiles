return setmetatable({}, {
   __index = function (_, file)
      local ok, action = pcall(require, 'config.plugins.telescope.actions.' .. file)

      if not ok then
         error('Telescope action ' .. file .. ' not found.')
         return ok
      end

      return action
   end,
})

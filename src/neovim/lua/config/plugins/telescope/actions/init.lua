return setmetatable({}, {
   __index = function (_, file)
      local ok, action = pcall(require, 'config.telescope.actions.' .. file)

      if not ok then
         error('Telescope action ' .. file .. ' not found.')
         return ok
      end

      return action
   end,
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80

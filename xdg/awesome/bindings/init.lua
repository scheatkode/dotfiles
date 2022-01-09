local awful = require('awful')

local f      = require('f')
local tablex = require('tablex')

return {
   setup  = function (overrides)
      overrides = overrides or {}

      local keyboard_bindings = tablex.deep_extend(
         'force',
         require('bindings.global.keyboard'),
         overrides.keyboard or {}
      )

      local mouse_bindings = tablex.deep_extend(
         'force',
         require('bindings.global.mouse'),
         overrides.mouse or {}
      )

      root.keys(
         f
            .iterate(keyboard_bindings)
            :map(function (_, v) return v end)
            :map(awful.key)
            :totable()
      )

      root.buttons(
         f
            .iterate(mouse_bindings)
            :map(function (_, v) return v end)
            :map(awful.button)
            :totable()
      )
   end
}

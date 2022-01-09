local f      = require('f')
local tablex = require('tablex')

return {
   setup = function (overrides)
      overrides        = overrides or {}
      overrides.screen = tablex.deep_extend(
         'force',
         require('signals.screen'),
         overrides.screen or {}
      )

      overrides.client = tablex.deep_extend(
         'force',
         require('signals.client'),
         overrides.client or {}
      )

      f.iterate(overrides.screen):foreach(screen.connect_signal)
      f.iterate(overrides.client):foreach(client.connect_signal)
   end
}

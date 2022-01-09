local awful = require('awful')
local mod   = require('bindings.mod')

return {

   ['mouse::client::click'] = {
      modifiers = {},
      button    = 1,
      on_press  = function (c)
         c:emit_signal(
            'request::activate',
            'mouse_click',
            { raise = true }
         )
      end,
   },

   ['mouse::client::move'] = {
      modifiers = { mod.super },
      button    = 1,
      on_press  = function (c)
         c:emit_signal(
            'request::activate',
            'mouse_click',
            { raise = true }
         )
         awful.mouse.client.move(c)
      end,
   },

   ['mouse::client::resize'] = {
      modifiers = { mod.super },
      button    = 3,
      on_press  = function (c)
         c:emit_signal(
            'request::activate',
            'mouse_click',
            { raise = true }
         )
         awful.mouse.client.resize(c)
      end,
   }

}

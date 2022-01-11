local f = require('f')

local awful         = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')

require('awful.hotkeys_popup.keys')

local menubar = require('menubar')

local apps    = require('apps')
local mod     = require('bindings.mod')
local vars    = require('config.vars')
local widgets = require('widgets')

menubar.utils.terminal = apps.terminal

local keys = {}

--- awesome {{{1

keys['keyboard::awesome::show help'] = {
   modifiers   = { mod.super },
   key         = 's',
   description = 'show help',
   group       = 'awesome',
   on_press    = hotkeys_popup.show_help,
}

keys['keyboard::awesome::show main menu'] = {
   modifiers   = { mod.super },
   key         = 'w',
   description = 'show main menu',
   group       = 'awesome',
   on_press    = function ()
      widgets.menu.mainmenu:show()
   end,
}

keys['keyboard::awesome::reload awesome'] = {
   modifiers   = { mod.super, mod.ctrl },
   key         = 'r',
   description = 'reload awesome',
   group       = 'awesome',
   on_press    = awesome.restart,
}

keys['keyboard::awesome::quit awesome'] = {
   modifiers   = { mod.super, mod.shift },
   key         = 'q',
   description = 'quit awesome',
   group       = 'awesome',
   on_press    = awesome.quit,
}

keys['keyboard::awesome::lua execute prompt'] = {
   modifiers   = { mod.super },
   key         = 'x',
   description = 'lua execute prompt',
   group       = 'awesome',
   on_press    = function ()
      awful.prompt.run({
         prompt       = 'Run Lua code: ',
         textbox      = awful.screen.focused().promptbox.widget,
         exe_callback = awful.util.eval,
         history_path = awful.util.get_cache_dir() .. '/history_eval',
      })
   end,
}

--- launcher {{{1

keys['keyboard::launcher::run prompt'] = {
   modifiers   = { mod.super },
   key         = 'r',
   description = 'run prompt',
   group       = 'launcher',
   on_press    = function ()
      awful.screen.focused().promptbox:run()
   end,
}

keys['keyboard::launcher::show the menubar'] = {
   modifiers   = { mod.super },
   key         = 'p',
   description = 'show the menubar',
   group       = 'launcher',
   on_press    = function ()
      menubar.show()
   end,
}

keys['keyboard::launcher::open a terminal'] = {
   modifiers   = { mod.super },
   key         = 'Return',
   description = 'open a terminal',
   group       = 'launcher',
   on_press    = function ()
      awful.spawn(apps.terminal)
   end,
}

--- tag {{{1

keys['keyboard::tag::view previous'] = {
   modifiers   = { mod.super },
   key         = 'Left',
   description = 'view previous',
   group       = 'tag',
   on_press    = awful.tag.viewprev,
}

keys['keyboard::tag::view next'] = {
   modifiers   = { mod.super },
   key         = 'Right',
   description = 'view next',
   group       = 'tag',
   on_press    = awful.tag.viewnext,
}

keys['keyboard::tag::go back'] = {
   modifiers   = { mod.super },
   key         = 'Escape',
   description = 'go back',
   group       = 'tag',
   on_press    = awful.tag.history.restore,
}

f.enumerate(vars.tags):foreach(function (i, v)
   keys['keyboard::tag::view tag #' .. v] = {
      modifiers   = { mod.super },
      key         = '#' .. v + 9,
      description = 'view tag #' .. v,
      group       = 'tag',
      on_press    = function ()
         local screen = awful.screen.focused()
         local tag    = screen.tags[i]

         if tag then
            tag:view_only()
         end
      end,
   }

   keys['keyboard::tag::toggle tag #' .. v] = {
      modifiers   = { mod.super, mod.ctrl },
      key         = '#' .. v + 9,
      description = 'toggle tag #' .. v,
      group       = 'tag',
      on_press    = function ()
         local screen = awful.screen.focused()
         local tag    = screen.tags[i]

         if tag then
            awful.tag.viewtoggle(tag)
         end
      end,
   }

   keys['keyboard::tag::move focused client to tag #' .. v] = {
      modifiers   = { mod.super, mod.shift },
      key         = '#' .. v + 9,
      description = 'move focused client to tag #' .. v,
      group       = 'tag',
      on_press    = function ()
         if client.focus then
            local tag = client.focus.screen.tags[i]

            if tag then
               client.focus:move_to_tag(tag)
            end
         end
      end,
   }

   keys['keyboard::tag::toggle focused client to tag #' .. v] = {
      modifiers   = { mod.super, mod.ctrl, mod.shift },
      key         = '#' .. v + 9,
      description = 'toggle focused client to tag #' .. v,
      group       = 'tag',
      on_press    = function ()
         if client.focus then
            local tag = client.focus.screen.tags[i]

            if tag then
               client.focus:toggle_tag(tag)
            end
         end
      end,
   }
end)

--- client {{{1

keys['keyboard::client::focus next by index'] = {
   modifiers   = { mod.super },
   key         = 'j',
   description = 'focus next by index',
   group       = 'client',
   on_press    = function ()
      awful.client.focus.byidx(1)
   end,
}

keys['keyboard::client::focus previous by index'] = {
   modifiers   = { mod.super },
   key         = 'k',
   description = 'focus previous by index',
   group       = 'client',
   on_press    = function ()
      awful.client.focus.byidx(-1)
   end,
}

keys['keyboard::client::go back'] = {
   modifiers   = { mod.super },
   key         = 'Tab',
   description = 'go back',
   group       = 'client',
   on_press    = function ()
      awful.client.focus.history.previous()

      if client.focus then
         client.focus:raise()
      end
   end,
}

keys['keyboard::client::swap with next client by index'] = {
   modifiers   = { mod.super, mod.shift },
   key         = 'j',
   description = 'swap with next client by index',
   group       = 'client',
   on_press    = function ()
      awful.client.swap.byidx(1)
   end,
}

keys['keyboard::client::swap with previous client by index'] = {
   modifiers   = { mod.super, mod.shift },
   key         = 'k',
   description = 'swap with previous client by index',
   group       = 'client',
   on_press    = function ()
      awful.client.swap.byidx(-1)
   end,
}

keys['keyboard::client::jump to urgent client'] = {
   modifiers   = { mod.super },
   key         = 'u',
   description = 'jump to urgent client',
   group       = 'client',
   on_press    = awful.client.urgent.jumpto,
}

keys['keyboard::client::restore minimized'] = {
   modifiers   = { mod.super, mod.ctrl },
   key         = 'n',
   description = 'restore minimized',
   group       = 'client',
   on_press    = function ()
      local c = awful.client.restore()

      if c then
         c:emit_signal(
            'request::activate',
            'key.unminimize',
            {raise = true}
         )
      end
   end,
}

--- layout {{{1

keys['keyboard::layout::select next'] = {
   modifiers   = { mod.super },
   key         = 'space',
   description = 'select next',
   group       = 'layout',
   on_press    = function ()
      awful.layout.inc(1)
   end,
}

keys['keyboard::layout::select previous'] = {
   modifiers   = { mod.super, mod.shift },
   key         = 'space',
   description = 'select previous',
   group       = 'layout',
   on_press    = function ()
      awful.layout.inc(-1)
   end,
}

keys['keyboard::layout::increase master width factor'] = {
   modifiers   = { mod.super },
   key         = 'y',
   description = 'increase master width factor',
   group       = 'layout',
   on_press    = function ()
      awful.tag.incmwfact(0.05)
   end,
}

keys['keyboard::layout::decrease master width factor'] = {
   modifiers   = { mod.super },
   key         = 'b',
   description = 'decrease master width factor',
   group       = 'layout',
   on_press    = function ()
      awful.tag.incmwfact(-0.05)
   end,
}

keys['keyboard::layout::increase the number of master clients'] = {
   modifiers   = { mod.super, mod.shift },
   key         = 'y',
   description = 'increase the number of master clients',
   group       = 'layout',
   on_press    = function ()
      awful.tag.incnmaster(1, nil, true)
   end,
}

keys['keyboard::layout::decrease the number of master clients'] = {
   modifiers   = { mod.super, mod.shift },
   key         = 'b',
   description = 'decrease the number of master clients',
   group       = 'layout',
   on_press    = function ()
      awful.tag.incmwfact(-1, nil, true)
   end,
}

keys['keyboard::layout::increase the number of columns'] = {
   modifiers   = { mod.super, mod.ctrl },
   key         = 'y',
   description = 'increase the number of columns',
   group       = 'layout',
   on_press    = function ()
      awful.tag.incncol(1, nil, true)
   end,
}

keys['keyboard::layout::decrease the number of columns'] = {
   modifiers   = { mod.super, mod.ctrl },
   key         = 'b',
   description = 'decrease the number of columns',
   group       = 'layout',
   on_press    = function ()
      awful.tag.incncol(-1, nil, true)
   end,
}

keys['keyboard::layout::select layout directly'] = {
   modifiers   = { mod.super },
   key         = 'numpad',
   description = 'select layout directly',
   group       = 'layout',
   on_press    = function (index)
      local tag = awful.screen.focused().selected_tag

      if tag then
         tag.layout = tag.layouts[index] or tag.layout
      end
   end,
}

--- screen {{{1

keys['keyboard::screen::focus previous screen'] = {
   modifiers   = { mod.super, mod.ctrl },
   key         = 'k',
   description = 'focus previous screen',
   group       = 'screen',
   on_press    = function ()
      awful.screen.focus_relative(-1)
   end,
}

keys['keyboard::screen::focus next screen'] = {
   modifiers   = { mod.super, mod.ctrl },
   key         = 'j',
   description = 'focus next screen',
   group       = 'screen',
   on_press    = function ()
      awful.screen.focus_relative(1)
   end,
}

return keys

-- localize globals {{{

local log = require('log')

-- }}}

local has_neorg, neorg = pcall(require, 'neorg')

if not has_neorg then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'neorg')
   return has_neorg
end

neorg.setup({
   load = {
      ['core.defaults'] = {},

      ['core.norg.concealer'] = {
         config = {
            icons = {
               heading = {
                  level_1 = { enabled = true, icon = '█' },
                  level_2 = { enabled = true, icon = '██' },
                  level_3 = { enabled = true, icon = '███' },
                  level_4 = { enabled = true, icon = '████' },
                  level_5 = { enabled = true, icon = '█████' },
                  level_6 = { enabled = true, icon = '██████' },
               },
            },
         },
      },

      ['core.keybinds'] = {
         config = {
            default_keybinds = false,
            neorg_leader     = '<leader>o',
         }
      },

      ['core.norg.dirman'] = {
         config = {
            workspaces = {
               brain = '~/brain',
            }
         }
      },

      ['core.norg.completion'] = {
         config = {
            engine = 'nvim-cmp',
         },
      },

      ['core.gtd.base'] = {
         config = {
            workspace = 'brain',
         },
      },

      ['core.gtd.ui']   = {},
   },

   hook = function ()
      -- This sets the leader for all Neorg keybinds. It is separate from the
      -- regular <Leader>, And allows you to shove every Neorg keybind under
      -- one "umbrella".
      local neorg_leader = '<Leader>n'

      -- Require the user callbacks module, which allows us to tap into the core of
      -- Neorg.
      -- local has_neorg, neorg = pcall(require, 'neorg')
      local neorg_callbacks = require('neorg.callbacks')

      -- Listen for the `enable_keybinds` event, which signals a `ready` state
      -- meaning we can bind keys. This hook will be called several times,
      -- e.g. whenever the Neorg Mode changes or an event that needs to
      -- reevaluate all the bound keys is invoked.
      neorg_callbacks.on_event('core.keybinds.events.enable_keybinds', function(_, keybinds)

         -- Map all the below keybinds only when the 'norg' mode is active.
         keybinds.map_event_to_mode('norg', {
            n = { -- Bind keys in normal mode.

               -- Keys for managing `TODO` items and setting their states.
               { 'gtd',       'core.norg.qol.todo_items.todo.task_done'    },
               { 'gtu',       'core.norg.qol.todo_items.todo.task_undone'  },
               { 'gtp',       'core.norg.qol.todo_items.todo.task_pending' },
               { '<C-Space>', 'core.norg.qol.todo_items.todo.task_cycle'   },

            },
         }, { silent = true, noremap = true })

      end)
   end,
})

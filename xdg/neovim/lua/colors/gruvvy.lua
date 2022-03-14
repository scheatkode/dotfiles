--- The raw colorscheme palette
---
--- Using  a function's  return  value  as a  temporary
--- variable to  avoid the  table lingering  around the
--- memory after  its use,  when the  garbage collector
--- sweeps for unreferenced objects.
---
--- @return table Default raw colorscheme component colors table
local function palette ()
   return {
      dark0_hard  = '#1d2021',
      dark0_dim   = '#242424',
      dark0       = '#282828',
      dark0_soft  = '#32302f',
      dark1       = '#3c3836',
      dark2       = '#504945',
      dark3       = '#665c54',
      dark4       = '#7c6f64',

      gray    = '#928374',

      light0_hard = '#f9f5d7',
      light0      = '#fbf1c7',
      light0_soft = '#f2e5bc',
      light1      = '#ebdbb2',
      light2      = '#d5c4a1',
      light3      = '#bdae93',
      light4      = '#a89984',

      bright_red     = '#fb4934',
      bright_green   = '#b8bb26',
      bright_yellow  = '#fabd2f',
      bright_blue    = '#83a598',
      bright_purple  = '#d3869b',
      bright_aqua    = '#8ec07c',
      bright_orange  = '#fe8019',

      neutral_red    = '#cc241d',
      neutral_green  = '#98971a',
      neutral_yellow = '#d79921',
      neutral_blue   = '#458588',
      neutral_purple = '#b16286',
      neutral_aqua   = '#689d6a',
      neutral_orange = '#d65d0e',

      faded_red      = '#9d0006',
      faded_green    = '#79740e',
      faded_yellow   = '#b57614',
      faded_blue     = '#076678',
      faded_purple   = '#8f3f71',
      faded_aqua     = '#427b58',
      faded_orange   = '#af3a03',

      pale_yellow = '#d8a657',
      pale_orange = '#e78a4e',
      pale_red    = '#ea6962',
      pale_green  = '#a9b665',
      pale_blue   = '#7daea3',
      pale_aqua   = '#89b482',
   }
end

--- The default themes
---
--- Using  a function's  return  value  as a  temporary
--- variable to  avoid the  table lingering  around the
--- memory after  its use,  when the  garbage collector
--- sweeps for unreferenced objects.
---
--- @return table Default themes table
local function themes (theme)
   return ({
      default = function(colors)
         return {
            bg        = colors.dark0,
            bg_dim    = colors.dark0_dim,
            bg_dark   = colors.dark0_hard,
            bg_light0 = colors.dark1,
            bg_light1 = colors.dark2,
            bg_light2 = colors.dark3,
            bg_light3 = colors.dark4,

            bg_menu     = colors.dark0_dim,
            bg_menu_sel = colors.dark0_soft,
            bg_search   = colors.dark0_soft,
            bg_status   = colors.dark0_dim,
            bg_visual   = colors.dark0_soft,

            fg = colors.light0_soft,

            fg_border  = colors.light4,
            fg_comment = colors.light4,
            fg_dark    = colors.light3,
            fg_reverse = colors.faded_blue,

            constant   = colors.pale_orange,
            delimiter  = colors.neutral_blue,
            fn         = colors.bright_blue,
            identifier = colors.pale_yellow,
            keyword    = colors.pale_red,
            number     = colors.pale_orange,
            operator   = colors.pale_red,
            preproc    = colors.pale_orange,
            regex      = colors.pale_yellow,
            special    = colors.bright_blue,
            special2   = colors.pale_red,
            special3   = colors.pale_red,
            statement  = colors.bright_purple,
            string     = colors.pale_green,
            type       = colors.pale_aqua,

            diag = {
               error   = colors.neutral_red,
               hint    = colors.neutral_aqua,
               info    = colors.neutral_blue,
               warning = colors.neutral_yellow,
            },

            diff = {
               add      = require('colors').alter(colors.faded_green,  -20),
               change   = require('colors').alter(colors.faded_blue,   -20),
               conflict = require('colors').alter(colors.faded_orange, -20),
               delete   = require('colors').alter(colors.faded_red,    -20),
               text     = require('colors').alter(colors.faded_yellow, -20),
            },

            git = {
               added   = require('colors').alter(colors.pale_green,  10),
               changed = require('colors').alter(colors.pale_yellow, 10),
               removed = require('colors').alter(colors.pale_red,    10),
            }
         }
      end
   })[theme]
end

local function lualine ()
   local colors = palette()
   local theme  = {}

   theme.normal = {
      a = { bg = colors.pale_blue, fg = colors.dark0_hard },
      b = { bg = colors.dark0,     fg = colors.pale_blue },
      c = { bg = colors.dark0,     fg = colors.light2 },
   }

   theme.insert = {
      a = { bg = colors.pale_green, fg = colors.dark0_hard },
      b = { bg = colors.dark0_dim,  fg = colors.pale_green },
   }

   theme.command = {
      a = { bg = colors.neutral_purple, fg = colors.dark0_hard },
      b = { bg = colors.dark0_dim,      fg = colors.neutral_purple },
   }

   theme.visual = {
      a = { bg = colors.pale_yellow, fg = colors.dark0_hard },
      b = { bg = colors.dark0_dim,   fg = colors.pale_yellow },
   }

   theme.replace = {
      a = { bg = colors.pale_red,  fg = colors.dark0_hard },
      b = { bg = colors.dark0_dim, fg = colors.pale_red },
   }

   theme.inactive = {
      a = { bg = colors.pale_blue, fg = colors.dark0_hard },
      b = { bg = colors.dark0_dim, fg = colors.pale_blue, gui = 'bold' },
      c = { bg = colors.dark0_dim, fg = colors.light4 },
   }

   return theme
end

return {
   palette = palette,
   themes  = themes,
   lualine = lualine,
}

--
--           ░█▀█░█░█░█▀▀░█▀▀░█▀█░█▄█░█▀▀
--           ░█▀█░█▄█░█▀▀░▀▀█░█░█░█░█░█▀▀
--           ░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
--

local       home_directory = os.getenv('HOME') or '~'
local xdg_config_directory = os.getenv('XDG_CONFIG_HOME') or home_directory .. '/.config'
local    awesome_directory = xdg_config_directory .. '/awesome'

-------------------------------------------------------
-- affects the main theme.

local themes = {
   'gruvbox', -- 1 --
   'gruvvy',  -- 2 --
}

-- change this number to use a different theme.
-- TODO(scheatkode): Add keybinding to automate this.
local theme = themes[2]

-------------------------------------------------------
-- affects  the window  appearance: title  bar, buttons
-- ...

local decorations = {
   'gruvbox', -- 1 --
}

local decoration = decorations[1]

-------------------------------------------------------
-- status bar themes. multiple  bars can be declared in
-- each theme.

local bars = {
   'gruvbox', -- 1 --
}

local bar = bars[1]

-------------------------------------------------------
-- affects  which icon  theme will  be used  by widgets
-- that display image icons.

local icons = {
   'gruvbox', -- 1 --
}

local icon = icons[1]

-------------------------------------------------------
-- notification themes.

local notifications = {
   'gruvbox', -- 1 --
}

local notification = notifications[1]

-------------------------------------------------------
-- side bar themes.

local sidebars = {
   'gruvbox', -- 1 --
}

local sidebar = sidebars[1]

-------------------------------------------------------
-- dashboard themes.

local dashboards = {
   'gruvbox', -- 1 --
}

local dashboard = dashboards[1]

-------------------------------------------------------
-- variables and preferences themes.

settings = {
   -- >> default applications <<

   terminal = 'alacritty',
   floating_terminal = 'alacritty',
   browser = 'firefox',
   -- file_manager = ''
   -- editor = ''
   -- email_client = ''
   -- music_client = ''

   -- >> Web search <<
   web_search_cmd = 'xdg-open https://duckduckgo.com/?q=',
   -- web_search_cmd = 'xdg-open https://google.com/search?q=',

   -- >> user profile <<
   profile = awesome_directory .. '/profile.png',

   -- directories with fallback values
   directories = {
        documents = os.getenv('XDG_DOCUMENTS_DIR')    or home_directory .. '/Documents',
        downloads = os.getenv('XDG_DOWNLOADS_DIR')    or home_directory .. '/Downloads',
            music = os.getenv('XDG_MUSIC_DIR')        or home_directory .. '/Music',
         pictures = os.getenv('XDG_PICTURES_DIR')     or home_directory .. '/Pictures',
      screenshots = os.getenv('XDG_SCREEENSHOTS_DIR') or home_directory .. '/Pictures/Screenshots',
           videos = os.getenv('XDG_VIDEOS_DIR')       or home_directory .. '/Videos',
   },

   -- >> sidebar <<
   sidebar = {
            hide_on_mouse_leave = true,
      show_on_mouse_screen_edge = true,
   },

   -- >> lock screen <<
   -- This password will ONLY be used if you have not installed
   -- https://github.com/RMTT/lua-pam
   -- as described in the README instructions
   -- Leave it empty in order to unlock with just the Enter key.
   -- lock_screen_custom_password = "",

   -- >> battery <<
   -- notifications will be issued when the battery reaches these levels.
   battery_threshold_low = 20,
   battery_threshold_critical = 8,
}

-- if luarocks  is installed,  make sure  that packages
-- installed  through  it  are  found  (e.g.  lgi).  if
-- luarocks is not installed, do nothing.
pcall(require, "luarocks.loader")

do
   local pack_path = (
         os.getenv('XDG_CONFIG_HOME')
      or os.getenv('HOME') .. '/.config'
   ) .. '/lib/lua'

   package.path = string.format(
      '%s;%s/?.lua;%s/?/init.lua',
      package.path,
      pack_path,
      pack_path
   )
end

-- load theme
local beautiful = require('beautiful')
local naughty = require('naughty')
-- beautiful.init(gears.filesystem.get_themes_dir() .. )
local theme_dir = os.getenv('HOME') .. '/.config/awesome/themes/' .. theme .. '/'
beautiful.init(theme_dir .. 'theme.lua')

-- {{{ Error handling
-- check if awesome encountered an error during startup
-- and fell back to another config (This code will only
-- ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- setup key and mouse bindings.
require('bindings').setup()

-- setup rules.
require('rules').setup()

-- setup signals.
require('signals').setup()

-- setup screens.
require('screens').setup()

-- setup flash.
require('modules.flash').setup()

-- local lockscreen = require('components.lockscreen')
-- -- lockscreen.init()

-- garbage collection.

collectgarbage('setpause',   260)
collectgarbage('setstepmul', 500)


--
--           ░█▀█░█░█░█▀▀░█▀▀░█▀█░█▄█░█▀▀░
--           ░█▀█░█▄█░█▀▀░▀▀█░█░█░█░█░█▀▀░
--           ░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░
--

local home_directory = os.getenv("HOME") or "~"
local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
	or home_directory .. "/.config"
local awm_dir = xdg_config_home .. "/awesome"

-- change this number to use a different theme.
-- TODO(scheatkode): Add keybinding to automate this.
local theme = "gruvvy"

-- if luarocks  is installed,  make sure  that packages
-- installed  through  it  are  found  (e.g.  lgi).  if
-- luarocks is not installed, do nothing.
pcall(require, "luarocks.loader")

do
	local pack_path = (
		os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
	) .. "/lib/lua"

	package.path = string.format(
		"%s;%s/?.lua;%s/?/init.lua",
		package.path,
		pack_path,
		pack_path
	)
end

-- load theme
local beautiful = require("beautiful")
beautiful.init(string.format("%s/themes/%s/theme.lua", awm_dir, theme))

-- {{{ Error handling
-- check if awesome encountered an error during startup
-- and fell back to another config (This code will only
-- ever execute for the fallback config)
local naughty = require("naughty")
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- handle runtime errors after startup
do
	local in_error = false

	awesome.connect_signal("debug::error", function(err)
		-- make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})

		in_error = false
	end)
end
-- }}}

local awful = require("awful")
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.floating,
}

-- setup key and mouse bindings.
require("bindings").setup()

-- setup rules.
require("rules").setup()

-- setup signals.
require("signals").setup()

-- setup screens.
require("screens").setup()

-- setup flash.
require("modules.flash").setup()

-- local lockscreen = require('components.lockscreen')
-- -- lockscreen.init()

return {
	setup = function()
		local f = require("f")

		local awful = require("awful")
		local gears = require("gears")
		local hotkeys_popup = require("awful.hotkeys_popup")

		require("awful.hotkeys_popup.keys")

		local menubar = require("menubar")

		local apps = require("apps")
		local mod = require("bindings.mod")
		local vars = require("config.vars")
		local widgets = require("widgets")

		menubar.utils.terminal = apps.terminal

		--- awesome {{{1
		local keyboard = gears.table.join(
			awful.key({ mod.super }, "s", hotkeys_popup.show_help, {
				description = "show help",
				group = "awesome",
			}),

			awful.key({ mod.super }, "w", function()
				widgets.menu.mainmenu:show()
			end, {
				description = "show main menu",
				group = "awesome",
			}),

			awful.key({ mod.super, mod.ctrl }, "r", awesome.restart, {
				description = "reload awesome",
				group = "awesome",
			}),

			awful.key({ mod.super, mod.shift }, "q", awesome.quit, {
				description = "quit awesome",
				group = "awesome",
			}),

			awful.key({ mod.super }, "x", function()
				awful.prompt.run({
					prompt = "Run Lua code: ",
					textbox = awful.screen.focused().promptbox.widget,
					exe_callback = awful.util.eval,
					history_path = awful.util.get_cache_dir() .. "/history_eval",
				})
			end, {
				description = "lua execute prompt",
				group = "awesome",
			}),

			--- launcher {{{1

			awful.key({ mod.super }, "r", function()
				awful.screen.focused().promptbox:run()
			end, {
				description = "run prompt",
				group = "launcher",
			}),

			awful.key({ mod.super }, "p", function()
				menubar.show()
			end, {
				description = "show the menubar",
				group = "launcher",
			}),

			awful.key({ mod.super }, "Return", function()
				awful.spawn(apps.terminal)
			end, {
				description = "open a terminal",
				group = "launcher",
			}),

			--- tag {{{1

			awful.key({ mod.super }, "Left", awful.tag.viewprev, {
				description = "view previous",
				group = "tag",
			}),

			awful.key({ mod.super }, "Right", awful.tag.viewnext, {
				description = "view next",
				group = "tag",
			}),

			awful.key({ mod.super }, "Escape", awful.tag.history.restore, {
				description = "go back",
				group = "tag",
			}),

			--- client {{{1

			awful.key({ mod.super }, "j", function()
				awful.client.focus.bydirection("down")
			end, {
				description = "focus the window down of the current window",
				group = "client",
			}),

			awful.key({ mod.super, mod.alt }, "j", function()
				awful.client.focus.byidx(1)
			end, {
				description = "focus the next window",
				group = "client",
			}),

			awful.key({ mod.super }, "k", function()
				awful.client.focus.bydirection("up")
			end, {
				description = "focus the window up of the current window",
				group = "client",
			}),

			awful.key({ mod.super, mod.alt }, "k", function()
				awful.client.focus.byidx(-1)
			end, {
				description = "focus the previous window",
				group = "client",
			}),

			awful.key({ mod.super }, "l", function()
				awful.client.focus.bydirection("right")
			end, {
				description = "focus the window right of the current window",
				group = "client",
			}),

			awful.key({ mod.super }, "h", function()
				awful.client.focus.bydirection("left")
			end, {
				description = "focus the window left of the current window",
				group = "client",
			}),

			awful.key({ mod.super }, "Tab", function()
				awful.client.focus.history.previous()

				if client.focus then
					client.focus:raise()
				end
			end, {
				description = "go back",
				group = "client",
			}),

			awful.key({ mod.super, mod.shift }, "j", function()
				awful.client.swap.bydirection("down")
			end, {
				description = "swap with client down of the current one",
				group = "client",
			}),

			awful.key({ mod.super, mod.shift }, "k", function()
				awful.client.swap.bydirection("up")
			end, {
				description = "swap with client up of the current one",
				group = "client",
			}),

			awful.key({ mod.super, mod.shift }, "l", function()
				awful.client.swap.bydirection("right")
			end, {
				description = "swap with client right of the current one",
				group = "client",
			}),

			awful.key({ mod.super, mod.shift }, "h", function()
				awful.client.swap.bydirection("left")
			end, {
				description = "swap with client left of the current one",
				group = "client",
			}),

			awful.key({ mod.super }, "u", awful.client.urgent.jumpto, {
				description = "jump to urgent client",
				group = "client",
			}),

			awful.key({ mod.super, mod.ctrl }, "n", function()
				local c = awful.client.restore()

				if c then
					c:emit_signal(
						"request::activate",
						"key.unminimize",
						{ raise = true }
					)
				end
			end, {
				description = "restore minimized",
				group = "client",
			}),

			--- layout {{{1

			awful.key({ mod.super }, "space", function()
				awful.layout.inc(1)
			end, {
				description = "select next",
				group = "layout",
			}),

			awful.key({ mod.super, mod.shift }, "space", function()
				awful.layout.inc(-1)
			end, {
				description = "select previous",
				group = "layout",
			}),

			awful.key({ mod.super }, "y", function()
				awful.tag.incmwfact(0.05)
			end, {
				description = "increase master width factor",
				group = "layout",
			}),

			awful.key({ mod.super }, "b", function()
				awful.tag.incmwfact(-0.05)
			end, {
				description = "decrease master width factor",
				group = "layout",
			}),

			awful.key({ mod.super, mod.shift }, "y", function()
				awful.tag.incnmaster(1, nil, true)
			end, {
				description = "increase the number of master clients",
				group = "layout",
			}),

			awful.key({ mod.super, mod.shift }, "b", function()
				awful.tag.incmwfact(-1, nil, true)
			end, {
				description = "decrease the number of master clients",
				group = "layout",
			}),

			awful.key({ mod.super, mod.ctrl }, "y", function()
				awful.tag.incncol(1, nil, true)
			end, {
				description = "increase the number of columns",
				group = "layout",
			}),

			awful.key({ mod.super, mod.ctrl }, "b", function()
				awful.tag.incncol(-1, nil, true)
			end, {
				description = "decrease the number of columns",
				group = "layout",
			}),

			awful.key({ mod.super }, "numpad", function(index)
				local tag = awful.screen.focused().selected_tag

				if tag then
					tag.layout = tag.layouts[index] or tag.layout
				end
			end, {
				description = "select layout directly",
				group = "layout",
			}),

			--- screen {{{1

			awful.key({ mod.super, mod.ctrl }, "k", function()
				awful.screen.focus_relative(-1)
			end, {
				description = "focus previous screen",
				group = "screen",
			}),

			awful.key({ mod.super, mod.ctrl }, "j", function()
				awful.screen.focus_relative(1)
			end, {
				description = "focus next screen",
				group = "screen",
			}),

			awful.key({ mod.super, mod.ctrl }, "l", function()
				awful.screen.focus_bydirection("right")
			end, {
				description = "focus screen to the right",
				group = "screen",
			}),

			awful.key({ mod.super, mod.ctrl }, "h", function()
				awful.screen.focus_bydirection("left")
			end, {
				description = "focus screen to the left",
				group = "screen",
			}),

			--- screenshot {{{1
			awful.key({ mod.super, mod.shift }, "s", function()
				awful.spawn.with_shell(
					"sleep 0.5; maim -s | xclip -selection clipboard -t image/png"
				)
			end, {
				description = "take a screenshot",
				group = "screen",
			}),

			--- scratchpad {{{1

			awful.key({ mod.super, mod.shift }, "v", function()
				local tempfile = os.tmpname()

				awful.spawn.easy_async_with_shell(
					string.format(
						'chmod o-r "%s"; wezterm start -- nvim "%s"',
						tempfile,
						tempfile
					),
					function()
						awful.spawn.with_shell(
							string.format(
								'cat "%s" | xclip -selection clipboard; rm "%s"',
								tempfile,
								tempfile
							)
						)
					end
				)
			end, {
				description = "Spawn a neovim instance",
				group = "command",
			})
		)

		f.enumerate(vars.tags):foreach(function(i, v)
			keyboard = gears.table.join(
				keyboard,
				awful.key({ mod.super }, "#" .. v + 9, function()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]

					if tag then
						tag:view_only()
					end
				end, {
					description = "view tag #" .. v,
					group = "tag",
				}),

				awful.key({ mod.super, mod.ctrl }, "#" .. v + 9, function()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]

					if tag then
						awful.tag.viewtoggle(tag)
					end
				end, {
					description = "toggle tag #" .. v,
					group = "tag",
				}),

				awful.key({ mod.super, mod.shift }, "#" .. v + 9, function()
					if client.focus then
						local tag = client.focus.screen.tags[i]

						if tag then
							client.focus:move_to_tag(tag)
						end
					end
				end, {
					description = "move focused client to tag #" .. v,
					group = "tag",
				}),

				awful.key(
					{ mod.super, mod.ctrl, mod.shift },
					"#" .. v + 9,
					function()
						if client.focus then
							local tag = client.focus.screen.tags[i]

							if tag then
								client.focus:toggle_tag(tag)
							end
						end
					end,
					{
						description = "toggle focused client to tag #" .. v,
						group = "tag",
					}
				)
			)
		end)

		return root.keys(keyboard)
	end,
}

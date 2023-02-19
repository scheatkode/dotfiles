local wt = require('wezterm')

do
	local pack_path = (
		os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config'
	) .. '/lib/lua'

	package.path = string.format(
		'%s;%s/?.lua;%s/?/init.lua',
		package.path,
		pack_path,
		pack_path
	)
end

local function setup()
	local colors = {
		dark0_hard     = '#1d2021',
		dark0_dim      = '#202020',
		dark0          = '#282828',
		dark0_soft     = '#32302f',
		dark1          = '#3c3836',
		dark2          = '#504945',
		dark3          = '#665c54',
		dark4          = '#7c6f64',

		gray           = '#928374',

		light0_hard    = '#f9f5d7',
		light0         = '#fbf1c7',
		light0_soft    = '#f2e5bc',
		light1         = '#ebdbb2',
		light2         = '#d5c4a1',
		light3         = '#bdae93',
		light4         = '#a89984',

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

		pale_yellow    = '#d8a657',
		pale_orange    = '#e78a4e',
		pale_red       = '#ea6962',
		pale_green     = '#a9b665',
		pale_blue      = '#7daea3',
		pale_aqua      = '#89b482',
	}

	---If possible, returns a colored pictogram of the current running process,
	---otherwise returns its basename.
	local function get_formatted_process(tab)
		local icons = {
			docker = {
				{ Foreground = { Color = colors.pale_blue } },
				{ Text = wt.nerdfonts.linux_docker },
			},
			podman = {
				{ Foreground = { Color = colors.pale_blue } },
				{ Text = wt.nerdfonts.linux_docker },
			},
			nvim = {
				{ Foreground = { Color = colors.pale_green } },
				{ Text = wt.nerdfonts.custom_vim },
			},
			vim = {
				{ Foreground = { Color = colors.pale_green } },
				{ Text = wt.nerdfonts.dev_vim },
			},
			node = {
				{ Foreground = { Color = colors.pale_green } },
				{ Text = wt.nerdfonts.mdi_hexagon },
			},
			zsh = {
				{ Foreground = { Color = colors.neutral_purple } },
				{ Text = wt.nerdfonts.dev_terminal },
			},
			btop = {
				{ Foreground = { Color = colors.pale_yellow } },
				{ Text = wt.nerdfonts.mdi_chart_donut_variant },
			},
			htop = {
				{ Foreground = { Color = colors.pale_yellow } },
				{ Text = wt.nerdfonts.mdi_chart_donut_variant },
			},
			cargo = {
				{ Foreground = { Color = colors.pale_orange } },
				{ Text = wt.nerdfonts.dev_rust },
			},
			go = {
				{ Foreground = { Color = colors.pale_blue } },
				{ Text = wt.nerdfonts.mdi_language_go },
			},
			git = {
				{ Foreground = { Color = colors.pale_orange } },
				{ Text = wt.nerdfonts.dev_git },
			},
			lua = {
				{ Foreground = { Color = colors.pale_blue } },
				{ Text = wt.nerdfonts.seti_lua },
			},
			wget = {
				{ Foreground = { Color = colors.pale_yellow } },
				{ Text = wt.nerdfonts.mdi_arrow_down_box },
			},
			curl = {
				{ Foreground = { Color = colors.pale_yellow } },
				{ Text = wt.nerdfonts.mdi_flattr },
			},
		}

		local name = string.gsub(
			tab.active_pane.foreground_process_name,
			'(.*[/\\])(.*)',
			'%2'
		)

		if name == '' then
			name = 'zsh'
		end

		return wt.format(icons[name] or {
			{ Foreground = { Color = { colors.pale_aqua } } },
			{ Text = string.format('[%s]', name) },
		})
	end

	---Return the formatted working directory.
	local function get_formatted_cwd(tab)
		local dir  = tab.active_pane.current_working_dir
		local home = string.format('file://%s', os.getenv('HOME'))

		return dir == home and '   ~'
			or string.format('   %s', string.gsub(dir, '(.*[/\\])(.*)', '%2'))
	end

	wt.on('format-tab-title', function(tab)
		return wt.format({
			{ Attribute = { Intensity = 'Bold' } },
			{ Text = string.format(' %s ', tab.tab_index + 1) },
			'ResetAttributes',
			{ Text = get_formatted_process(tab) },
			{ Text = get_formatted_cwd(tab) },
			{ Foreground = { Color = colors.pale_orange } },
			{ Text = ' ' },
		})
	end)

	wt.on('update-right-status', function(window)
		window:set_right_status(wt.format({
			{ Attribute = { Intensity = 'Bold' } },
			{ Text = wt.strftime(' %A, %d %B %Y %H:%M ') },
		}))
	end)

	wt.on('OpenInVim', function(window, pane)
		local tmpfile = os.tmpname()
		local file, err = io.open(tmpfile, 'w')

		if file == nil then
			wt.log_error(string.format('Unable to open %s: %s', tmpfile, err))
			return
		end

		file:write(pane:get_lines_as_text(10000))
		file:close()

		window:perform_action(
			wt.action({
				SpawnCommandInNewTab = {
					args = { 'nvim', tmpfile, '-c', 'call cursor(10000, 0)' },
				},
			}),
			pane
		)
	end)

	---Predicate that checks whether the current running process is Vim or Neovim.
	local function is_vi_process(pane)
		return pane:get_foreground_process_name():find('n?vim') ~= nil
	end

	---Conditionally activate a pane in the given direction.
	---
	---If inside Vim or Neovim, delegate the keybind handling, otherwise, handle
	---it internally.
	local function activate_pane(vdirection, pdirection)
		return function(window, pane)
			if is_vi_process(pane) then
				return window:perform_action(
					wt.action.SendKey({ key = vdirection, mods = 'ALT' }),
					pane
				)
			end

			return window:perform_action(
				wt.action.ActivatePaneDirection(pdirection),
				pane
			)
		end
	end

	-- Handle event to activate pane at some direction.
	wt.on('ActivatePaneDirectionUp',    activate_pane('k', 'Up'))
	wt.on('ActivatePaneDirectionDown',  activate_pane('j', 'Down'))
	wt.on('ActivatePaneDirectionRight', activate_pane('l', 'Right'))
	wt.on('ActivatePaneDirectionLeft',  activate_pane('h', 'Left'))

	return {
		-- I'm too used to this already
		leader = { key = 'a', mods = 'ALT' },

		-- The system package manager should handle this
		check_for_updates = false,

		-- Custom colorscheme
		colors = {
			split         = colors.gray,
			foreground    = colors.light2,
			background    = colors.dark0_dim,
			cursor_bg     = colors.bright_yellow,
			cursor_border = colors.bright_yellow,
			selection_bg  = colors.dark0_soft,
			selection_fg  = colors.light2,
			ansi = {
				colors.dark0,
				colors.pale_red,
				colors.pale_green,
				colors.pale_yellow,
				colors.pale_blue,
				colors.neutral_purple,
				colors.pale_aqua,
				colors.light3,
			},
			brights = {
				colors.dark4,
				colors.bright_red,
				colors.bright_green,
				colors.bright_yellow,
				colors.bright_blue,
				colors.bright_purple,
				colors.bright_aqua,
				colors.light1,
			},
			tab_bar = {
				background = colors.dark0_dim,
				active_tab = {
					bg_color      = colors.dark0,
					fg_color      = colors.pale_orange,
					intensity     = 'Bold',
					underline     = 'None',
					italic        = false,
					strikethrough = false,
				},
				inactive_tab = {
					bg_color = 'None',
					fg_color = colors.light4,
				},
			},
		},

		-- Dim inactive panes
		inactive_pane_hsb = {
			saturation = 0.8,
			brightness = 0.5,
		},

		-- Run ZSH by default
		default_prog = { 'zsh' },

		-- Font config
		font = wt.font_with_fallback({
			{ family = 'Dyosevka', weight = 'Medium' },
		}),
		font_size = 13,
		line_height = 1.35,

		launch_menu = {},

		-- Nonsense
		enable_wayland = false,

		-- No mouse, no scrollbars
		enable_scroll_bar = false,

		-- Tab bar config
		tab_max_width = 50,
		tab_bar_at_bottom = true,
		use_fancy_tab_bar = false,
		show_new_tab_button_in_tab_bar = false,

		-- Restrict to 60fps, even this is overkill
		max_fps = 60,

		-- I need the screen estate
		window_decorations = 'None',
		window_padding = {
			top    = 0,
			right  = 0,
			left   = 0,
			bottom = 0,
		},

		-- I'll have my own, thank you
		disable_default_key_bindings = true,
		keys = {
			-- Pane splitting
			{
				key = '\\',
				mods = 'LEADER',
				action = wt.action({
					SplitHorizontal = { domain = 'CurrentPaneDomain' },
				}),
			},
			{
				key = '-',
				mods = 'LEADER',
				action = wt.action({
					SplitVertical = { domain = 'CurrentPaneDomain' },
				}),
			},

			-- Fat fingered aliases
			{
				key = '\\',
				mods = 'LEADER|ALT',
				action = wt.action({
					SplitHorizontal = { domain = 'CurrentPaneDomain' },
				}),
			},
			{
				key = '-',
				mods = 'LEADER|ALT',
				action = wt.action({
					SplitVertical = { domain = 'CurrentPaneDomain' },
				}),
			},

			-- Pane zooming
			{ key = '=', mods = 'ALT', action = wt.action.TogglePaneZoomState },
			{
				key = '=',
				mods = 'LEADER',
				action = wt.action.TogglePaneZoomState,
			},

			-- Parkour
			{
				key = 'l',
				mods = 'ALT',
				action = wt.action.EmitEvent('ActivatePaneDirectionRight'),
			},
			{
				key = 'k',
				mods = 'ALT',
				action = wt.action.EmitEvent('ActivatePaneDirectionUp'),
			},
			{
				key = 'h',
				mods = 'ALT',
				action = wt.action.EmitEvent('ActivatePaneDirectionLeft'),
			},
			{
				key = 'j',
				mods = 'ALT',
				action = wt.action.EmitEvent('ActivatePaneDirectionDown'),
			},

			-- Pane size
			{
				key = 'h',
				mods = 'ALT|SHIFT',
				action = wt.action.AdjustPaneSize({ 'Left', 1 }),
			},
			{
				key = 'k',
				mods = 'ALT|SHIFT',
				action = wt.action.AdjustPaneSize({ 'Up', 1 }),
			},
			{
				key = 'j',
				mods = 'ALT|SHIFT',
				action = wt.action.AdjustPaneSize({ 'Down', 1 }),
			},
			{
				key = 'l',
				mods = 'ALT|SHIFT',
				action = wt.action.AdjustPaneSize({ 'Right', 1 }),
			},

			-- Fullscreen toggle
			{ key = 'f', mods = 'LEADER', action = wt.action.ToggleFullScreen },

			-- The OG copy-mode
			{
				key = 'Y',
				mods = 'LEADER',
				action = wt.action.EmitEvent('OpenInVim'),
			},
			-- The normal copy-mode
			{ key = 'y', mods = 'LEADER', action = wt.action.ActivateCopyMode },

			-- Parkour #2
			{ key = '1', mods = 'ALT', action = wt.action({ ActivateTab = 0 }) },
			{ key = '2', mods = 'ALT', action = wt.action({ ActivateTab = 1 }) },
			{ key = '3', mods = 'ALT', action = wt.action({ ActivateTab = 2 }) },
			{ key = '4', mods = 'ALT', action = wt.action({ ActivateTab = 3 }) },
			{ key = '5', mods = 'ALT', action = wt.action({ ActivateTab = 4 }) },
			{ key = '6', mods = 'ALT', action = wt.action({ ActivateTab = 5 }) },
			{ key = '7', mods = 'ALT', action = wt.action({ ActivateTab = 6 }) },
			{ key = '8', mods = 'ALT', action = wt.action({ ActivateTab = 7 }) },
			{ key = '9', mods = 'ALT', action = wt.action({ ActivateTab = 8 }) },
			{ key = 'Tab', mods = 'ALT', action = wt.action.ActivateLastTab },

			-- Parkour #3 (a.k.a. teleportation)
			{
				key = 's',
				mods = 'LEADER',
				action = wt.action.PaneSelect,
			},

			-- Clipboard
			{
				key = 'p',
				mods = 'LEADER',
				action = wt.action({ PasteFrom = 'Clipboard' }),
			},

			-- Font size
			{ key = '=', mods = 'CTRL', action = wt.action.IncreaseFontSize },
			{ key = '-', mods = 'CTRL', action = wt.action.DecreaseFontSize },
			{ key = '0', mods = 'CTRL', action = wt.action.ResetFontSize },

			-- Miscellaneousness
			{
				key = 'n',
				mods = 'LEADER',
				action = wt.action({ SpawnTab = 'CurrentPaneDomain' }),
			},

			-- Fat fingered alias
			{
				key = 'n',
				mods = 'LEADER|ALT',
				action = wt.action({ SpawnTab = 'CurrentPaneDomain' }),
			},

			{
				key = 'l',
				mods = 'LEADER',
				action = wt.action.ShowLauncher,
			},

			{
				key = 'x',
				mods = 'LEADER',
				action = wt.action.CloseCurrentPane({ confirm = false }),
			},

			{
				key = 'X',
				mods = 'LEADER',
				action = wt.action.CloseCurrentTab({ confirm = false }),
			},
		},
	}
end

return setup()

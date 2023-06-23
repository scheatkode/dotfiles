return {
	setup = function()
		local wt = require("wezterm")

		return {
			-- Fat fingered aliases
			{
				key = "\\",
				mods = "LEADER|ALT",
				action = wt.action({
					SplitHorizontal = { domain = "CurrentPaneDomain" },
				}),
			},
			{
				key = "-",
				mods = "LEADER|ALT",
				action = wt.action({
					SplitVertical = { domain = "CurrentPaneDomain" },
				}),
			},

			-- Pane splitting
			{
				key = "\\",
				mods = "LEADER",
				action = wt.action({
					SplitHorizontal = { domain = "CurrentPaneDomain" },
				}),
			},
			{
				key = "-",
				mods = "LEADER",
				action = wt.action({
					SplitVertical = { domain = "CurrentPaneDomain" },
				}),
			},

			-- Pane zooming
			{ key = "=", mods = "ALT", action = wt.action.TogglePaneZoomState },
			{
				key = "=",
				mods = "LEADER",
				action = wt.action.TogglePaneZoomState,
			},

			-- Pane moving
			{
				key = "r",
				mods = "ALT",
				action = wt.action.RotatePanes("Clockwise"),
			},
			{
				key = "r",
				mods = "ALT|SHIFT",
				action = wt.action.RotatePanes("CounterClockwise"),
			},

			-- Parkour
			{
				key = "l",
				mods = "ALT",
				action = wt.action.EmitEvent("ActivatePaneDirectionRight"),
			},
			{
				key = "k",
				mods = "ALT",
				action = wt.action.EmitEvent("ActivatePaneDirectionUp"),
			},
			{
				key = "h",
				mods = "ALT",
				action = wt.action.EmitEvent("ActivatePaneDirectionLeft"),
			},
			{
				key = "j",
				mods = "ALT",
				action = wt.action.EmitEvent("ActivatePaneDirectionDown"),
			},

			{
				key = "l",
				mods = "LEADER",
				action = wt.action.ActivatePaneDirection("Right"),
			},
			{
				key = "k",
				mods = "LEADER",
				action = wt.action.ActivatePaneDirection("Up"),
			},
			{
				key = "h",
				mods = "LEADER",
				action = wt.action.ActivatePaneDirection("Left"),
			},
			{
				key = "j",
				mods = "LEADER",
				action = wt.action.ActivatePaneDirection("Down"),
			},

			-- Pane size
			{
				key = "h",
				mods = "ALT|SHIFT",
				action = wt.action.AdjustPaneSize({ "Left", 1 }),
			},
			{
				key = "k",
				mods = "ALT|SHIFT",
				action = wt.action.AdjustPaneSize({ "Up", 1 }),
			},
			{
				key = "j",
				mods = "ALT|SHIFT",
				action = wt.action.AdjustPaneSize({ "Down", 1 }),
			},
			{
				key = "l",
				mods = "ALT|SHIFT",
				action = wt.action.AdjustPaneSize({ "Right", 1 }),
			},

			-- Fullscreen toggle
			{ key = "f", mods = "LEADER", action = wt.action.ToggleFullScreen },

			-- The OG copy-mode
			{
				key = "Y",
				mods = "LEADER",
				action = wt.action.EmitEvent("OpenInVim"),
			},
			-- The normal copy-mode
			{ key = "y", mods = "LEADER", action = wt.action.ActivateCopyMode },

			-- Parkour #2
			{ key = "1", mods = "ALT", action = wt.action.ActivateTab(0) },
			{ key = "2", mods = "ALT", action = wt.action.ActivateTab(1) },
			{ key = "3", mods = "ALT", action = wt.action.ActivateTab(2) },
			{ key = "4", mods = "ALT", action = wt.action.ActivateTab(3) },
			{ key = "5", mods = "ALT", action = wt.action.ActivateTab(4) },
			{ key = "6", mods = "ALT", action = wt.action.ActivateTab(5) },
			{ key = "7", mods = "ALT", action = wt.action.ActivateTab(6) },
			{ key = "8", mods = "ALT", action = wt.action.ActivateTab(7) },
			{ key = "9", mods = "ALT", action = wt.action.ActivateTab(8) },
			{ key = "Tab", mods = "ALT", action = wt.action.ActivateLastTab },

			{
				key = "]",
				mods = "LEADER",
				action = wt.action.ActivateTabRelative(1),
			},
			{
				key = "[",
				mods = "LEADER",
				action = wt.action.ActivateTabRelative(-1),
			},
			{
				key = "}",
				mods = "LEADER|SHIFT",
				action = wt.action.MoveTabRelative(1),
			},
			{
				key = "{",
				mods = "LEADER|SHIFT",
				action = wt.action.MoveTabRelative(-1),
			},

			-- Parkour #3 (a.k.a. teleportation)
			{
				key = "s",
				mods = "LEADER",
				action = wt.action.PaneSelect,
			},

			-- Clipboard
			{
				key = "p",
				mods = "LEADER",
				action = wt.action({ PasteFrom = "Clipboard" }),
			},

			-- Font size
			{ key = "=", mods = "CTRL", action = wt.action.IncreaseFontSize },
			{ key = "-", mods = "CTRL", action = wt.action.DecreaseFontSize },
			{ key = "0", mods = "CTRL", action = wt.action.ResetFontSize },

			-- Miscellaneousness
			{
				key = "n",
				mods = "LEADER",
				action = wt.action({ SpawnTab = "CurrentPaneDomain" }),
			},

			-- Fat fingered alias
			{
				key = "n",
				mods = "LEADER|ALT",
				action = wt.action({ SpawnTab = "CurrentPaneDomain" }),
			},

			{
				key = "l",
				mods = "LEADER|SHIFT",
				action = wt.action.ShowLauncher,
			},

			{
				key = "x",
				mods = "LEADER",
				action = wt.action.CloseCurrentPane({ confirm = false }),
			},

			{
				key = "X",
				mods = "LEADER",
				action = wt.action.CloseCurrentTab({ confirm = false }),
			},
		}
	end,
}

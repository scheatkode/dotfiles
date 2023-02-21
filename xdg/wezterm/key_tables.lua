return {
	setup = function()
		local wt = require('wezterm')
		local act = wt.action

		return {
			copy_mode = {
				{
					key = 'Escape',
					mods = 'NONE',
					action = act.Multiple({
						act.ClearSelection,
						act.CopyMode('ClearPattern'),
						act.CopyMode('Close'),
					}),
				},

				{ key = 'q', mods = 'NONE', action = act.CopyMode('Close') },

				-- cursor movement
				{ key = 'h', mods = 'NONE', action = act.CopyMode('MoveLeft') },
				{ key = 'j', mods = 'NONE', action = act.CopyMode('MoveDown') },
				{ key = 'k', mods = 'NONE', action = act.CopyMode('MoveUp') },
				{ key = 'l', mods = 'NONE', action = act.CopyMode('MoveRight') },
				{
					key = 'w',
					mods = 'NONE',
					action = act.CopyMode('MoveForwardWord'),
				},
				{
					key = 'b',
					mods = 'NONE',
					action = act.CopyMode('MoveBackwardWord'),
				},
				-- {
				-- 	key = 'e',
				-- 	mods = 'NONE',
				-- 	action = act.CopyMode('MoveForwardWordEnd'),
				-- },
				{
					key = 'f',
					mods = 'NONE',
					action = act.CopyMode({ JumpForward = { prev_char = false } }),
				},
				{
					key = 't',
					mods = 'NONE',
					action = act.CopyMode({ JumpForward = { prev_char = true } }),
				},
				{
					key = 'F',
					mods = 'NONE',
					action = act.CopyMode({ JumpBackward = { prev_char = false } }),
				},
				{
					key = 'T',
					mods = 'NONE',
					action = act.CopyMode({ JumpBackward = { prev_char = true } }),
				},
				{
					key = '0',
					mods = 'NONE',
					action = act.CopyMode('MoveToStartOfLine'),
				},
				{
					key = '^',
					mods = 'NONE',
					action = act.CopyMode('MoveToStartOfLineContent'),
				},
				{
					key = '^',
					mods = 'SHIFT',
					action = act.CopyMode('MoveToStartOfLineContent'),
				},
				{
					key = 'H',
					mods = 'NONE',
					action = act.CopyMode('MoveToStartOfLineContent'),
				},
				{
					key = 'H',
					mods = 'SHIFT',
					action = act.CopyMode('MoveToStartOfLineContent'),
				},
				{
					key = '$',
					mods = 'NONE',
					action = act.CopyMode('MoveToEndOfLineContent'),
				},
				{
					key = '$',
					mods = 'SHIFT',
					action = act.CopyMode('MoveToEndOfLineContent'),
				},
				{
					key = 'L',
					mods = 'NONE',
					action = act.CopyMode('MoveToEndOfLineContent'),
				},
				{
					key = 'L',
					mods = 'SHIFT',
					action = act.CopyMode('MoveToEndOfLineContent'),
				},

				-- selection
				{
					key = 'v',
					mods = 'NONE',
					action = act.CopyMode({ SetSelectionMode = 'Cell' }),
				},
				{
					key = 'v',
					mods = 'SHIFT',
					action = act.CopyMode({ SetSelectionMode = 'Line' }),
				},

				-- copy
				{
					key = 'y',
					mods = 'NONE',
					action = act.Multiple({
						act.CopyTo('ClipboardAndPrimarySelection'),
						act.CopyMode('Close'),
					}),
				},

				-- scrolling
				{
					key = 'G',
					mods = 'NONE',
					action = act.CopyMode('MoveToScrollbackBottom'),
				},
				{
					key = 'G',
					mods = 'SHIFT',
					action = act.CopyMode('MoveToScrollbackBottom'),
				},
				{
					key = 'g',
					mods = 'NONE',
					action = act.CopyMode('MoveToScrollbackTop'),
				},
				{
					key = 'o',
					mods = 'NONE',
					action = act.CopyMode('MoveToSelectionOtherEnd'),
				},
				{ key = 'f', mods = 'CTRL', action = act.CopyMode('PageDown') },
				{ key = 'b', mods = 'CTRL', action = act.CopyMode('PageUp') },
				{ key = 'u', mods = 'CTRL', action = act.CopyMode('PageUp') },
				{ key = 'd', mods = 'CTRL', action = act.CopyMode('PageDown') },
				-- {
				-- 	key = 'u',
				-- 	mods = 'CTRL',
				-- 	action = act.CopyMode({ MoveByPage = -0.5 }),
				-- },
				-- {
				-- 	key = 'd',
				-- 	mods = 'CTRL',
				-- 	action = act.CopyMode({ MoveByPage = 0.5 }),
				-- },
			},
			search_mode = {
				{ key = 'Escape', mods = 'NONE', action = act.CopyMode('Close') },
				{ key = 'n', mods = 'NONE', action = act.CopyMode('NextMatch') },
				{
					key = 'n',
					mods = 'SHIFT',
					action = act.CopyMode('PriorMatch'),
				},
				{
					key = 'r',
					mods = 'CTRL',
					action = act.CopyMode('CycleMatchType'),
				},
				{
					key = 'u',
					mods = 'CTRL',
					action = act.CopyMode('ClearPattern'),
				},
				{
					key = 'PageUp',
					mods = 'NONE',
					action = act.CopyMode('PriorMatchPage'),
				},
				{
					key = 'PageDown',
					mods = 'NONE',
					action = act.CopyMode('NextMatchPage'),
				},
			},
		}
	end,
}

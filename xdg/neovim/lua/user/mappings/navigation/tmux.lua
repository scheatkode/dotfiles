return {
	setup = function()
		local api = vim.api
		local fmt = string.format

		local TMUX        = os.getenv('TMUX')
		local TMUX_PANE   = os.getenv('TMUX_PANE')
		local TMUX_SOCKET = vim.split(TMUX or ',', ',')[1]

		local function tmux_jump(to)
			local directions = {
				h = 'L',
				k = 'U',
				l = 'R',
				j = 'D',
			}

			local command = fmt(
				'tmux -S %s select-pane -t "%s" -%s',
				TMUX_SOCKET,
				TMUX_PANE,
				directions[to]
			)

			local handle = assert(
				io.popen(command),
				fmt('unable to execute tmux command "%s"', command)
			)

			local result = handle:read()
			handle:close()

			return result
		end

		local function jump(direction)
			return function()
				-- window id before jump
				local current_window = api.nvim_get_current_win()

				api.nvim_command(fmt('wincmd %s', direction))

				-- stop if we're not in a tmux instance
				if TMUX == nil then return end

				if api.nvim_get_current_win() == current_window then
					tmux_jump(direction)
				end
			end
		end

		--- mappings

		vim.keymap.set('n', '<M-h>', jump('h'), { nowait = true, desc = 'Go to the pane on the left' })
		vim.keymap.set('n', '<M-l>', jump('l'), { nowait = true, desc = 'Go to the pane on the right' })
		vim.keymap.set('n', '<M-j>', jump('j'), { nowait = true, desc = 'Go to the pane below' })
		vim.keymap.set('n', '<M-k>', jump('k'), { nowait = true, desc = 'Go to the pane above' })
	end
}

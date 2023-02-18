return {
	setup = function()
		local assertx = require('assertx')
		local WEZTERM = os.getenv('WEZTERM_UNIX_SOCKET')

		local function jump(vdirection, pdirection)
			return function()
				-- window id before jump
				local current_window = vim.api.nvim_get_current_win()

				vim.api.nvim_command(string.format('wincmd %s', vdirection))

				-- stop if we're not in a wezterm instance
				if WEZTERM == nil then
					return
				end

				if vim.api.nvim_get_current_win() ~= current_window then
					return
				end

				local command = string.format(
					'wezterm cli activate-pane-direction %s',
					pdirection
				)

				local handle = assertx(
					io.popen(command),
					string.format,
					'unable to execute wezterm command "%s"',
					command
				)

				local result = handle:read()
				handle:close()
				return result
			end
		end

		--- mappings

		vim.keymap.set('n', '<M-k>', jump('k', 'Up'), { nowait = true, desc = 'Go to the pane above' })
		vim.keymap.set('n', '<M-j>', jump('j', 'Down'), { nowait = true, desc = 'Go to the pane below' })
		vim.keymap.set('n', '<M-h>', jump('h', 'Left'), { nowait = true, desc = 'Go to the pane on the left' })
		vim.keymap.set('n', '<M-l>', jump('l', 'Right'), { nowait = true, desc = 'Go to the pane on the right' })
	end,
}

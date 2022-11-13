return {
	setup = function()
		local log = require('log')

		-- Check for plugin existence
		local has_signature, signature = pcall(require, 'lsp_signature')

		if not has_signature then
			log.error('Tried loading plugin ... unsuccessfully ‼', 'lsp-signature')
			return has_signature
		end

		signature.setup({
			-- Autoclose signature float win after x sec, disabled if
			-- `nil`.
			auto_close_after = nil,

			-- XXX: Setting this to something big to avoid the signature
			-- window popping automatically until I come around and do
			-- a custom implementation that handles signature help with
			-- overloads.
			timer_interval = 60000,

			-- An attempt at making the window appear manually, but having
			-- a look at the plugin's code, this is just a dummy option not
			-- used anywhere.
			always_trigger = false,

			-- Disable showing the signature window on `CursorHold`.
			cursorhold_update = false,

			-- This is mandatory, otherwise border config won't get
			-- registered. if you want to hook lspsaga or other signature
			-- handler, set to `false`.
			bind = true,

			-- Makes the floating window have less priority over other
			-- floating windows.
			zindex = 1,

			transparency = 10,

			-- Will show four lines of comment/doc (if there are more than
			-- two lines in doc, the excess lines will be truncated); set
			-- to 0 if you DO NOT want any API comments to be shown. this
			-- setting only takes effect in insert mode, it does not affect
			-- signature help in normal mode, 10 by default.
			doc_lines = 4,

			-- Show hint in a floating window, set to false for virtual
			-- text only mode.
			floating_window = true,

			-- Try to place the floating above the current line when
			-- possible. Note: will set to `true` when fully tested, set to
			-- `false` will use whichever side has more space this setting
			-- will be helpful if you do not want the PUM and floating
			-- window to overlap.
			floating_window_above_cur_line = true,

			hint_enable = false, -- virtual hint disable.
			hint_prefix = 'ⓘ ', -- icon.
			hint_scheme = 'String',

			-- How the parameter will be highlighted.
			hi_parameter = 'LspSignatureActiveParameter',

			-- Max height of the signature floating window, if content is
			-- more than `max_height`, you can scroll down to view the
			-- hidden contents.
			max_height = 12,

			-- Max width of signature floating window, line will be wrapped
			-- if it exceeds `max_width`.
			max_width = 50,

			handler_opts = {
				border = 'rounded' -- double, single, shadow, none
			},

			-- Manual toggle key.
			toggle_key = '<M-s>',

			-- Next signature selection key, for looping through overloads.
			select_signature_key = '<M-n>',
		})
	end
}

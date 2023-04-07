return {
	-- The OG, on-demand statusline.
	setup = function()
		local function genmessage()
			local status = vim.b.gitsigns_status_dict

			if status == nil then
				return vim.cmd.normal({
					args = {
						vim.api.nvim_replace_termcodes("<C-g>", true, true, true),
					},
					bang = true,
				})
			end

			local line = string.format("%s ", status.head, vim.fn.expand("%"))

			if status.added ~= 0 then
				line = string.format("%s +%s", line, status.added)
			end

			if status.changed ~= 0 then
				line = string.format("%s ~%s", line, status.changed)
			end

			if status.removed ~= 0 then
				line = string.format("%s -%s", line, status.removed)
			end

			vim.notify(string.format("%s %s", line, vim.fn.expand("%")))
		end

		vim.keymap.set("n", "<C-g>", genmessage)
	end,
}

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

			local line =
				string.format("%s  %s ", status.head, vim.fn.expand("%"))

			if status.added ~= 0 then
				line = line .. " +" .. status.added
			end

			if status.changed ~= 0 then
				line = line .. " ~" .. status.changed
			end

			if status.removed ~= 0 then
				line = line .. " -" .. status.removed
			end

			print(line)
		end

		vim.keymap.set("n", "<C-g>", genmessage)
	end,
}

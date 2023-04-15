return {
	setup = function()
		local constant = require("f.function.constant")
		local rpartial = require("f.function.rpartial")
		local ternary = require("f.function.ternary")

		local function modified(tabpage)
			local count = 0

			for _, bufnr in ipairs(vim.fn.tabpagebuflist(tabpage)) do
				if vim.api.nvim_buf_get_option(bufnr, "modified") then
					count = count + 1
				end
			end

			if count == 0 then
				return ""
			end

			return string.format(" +%d", count)
		end

		local function wincount(tabpage)
			local count = vim.fn.tabpagewinnr(tabpage, "$")

			if count < 2 then
				return ""
			end

			return string.format(" #%s", count)
		end

		-- This is intended in order to let the `tabline` function be the
		-- tabline handler.
		-- selene: allow(global_usage)
		_G.user = _G.user or {}
		-- selene: allow(global_usage)
		function _G.user.tabline()
			local tabline = {}
			local current = vim.fn.tabpagenr()

			local highlight = rpartial(
				ternary,
				constant("%#TabLineSel#"),
				constant("%#TabLine#")
			)

			for t = 1, vim.fn.tabpagenr("$") do
				tabline[#tabline + 1] = highlight(t == current)
				tabline[#tabline + 1] =
					string.format("%%%sT %s%s%s ", t, t, wincount(t), modified(t))
			end

			tabline[#tabline + 1] = "%#TabLineFill#%T"

			return table.concat(tabline, "")
		end

		vim.opt.tabline = "%!v:lua.user.tabline()"
	end,
}

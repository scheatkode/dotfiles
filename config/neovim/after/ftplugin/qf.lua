--- Neovim filetype plugin
--- Language: quickfix list

if vim.b.did_after_ftplugin == 1 then
	return
end

vim.opt_local.buflisted = false
vim.opt_local.signcolumn = "no"
vim.opt_local.bufhidden = "wipe"

vim.cmd.packadd("cfilter")
vim.cmd.cnoreabbrev({ "cfilter", "Cfilter" })
vim.cmd([[autocmd! BufEnter <buffer> if winnr('$') < 2 | q | endif]])

local function delete()
	local ternary = require("f.function.ternary")
	local filter = require("tablex.filter")

	local bufnr = vim.api.nvim_get_current_buf()
	local line = vim.api.nvim_win_get_cursor(0)[1]

	-- Figure out if we're in the quickfix list or the location list.
	local is_qf = vim.fn.getqflist({ winid = 0 }).winid ~= 0
	local list = ternary(is_qf, vim.fn.getqflist, function()
		return vim.fn.getloclist(bufnr)
	end)

	local upper_bound
	local lower_bound

	-- Filter out the current entry or selection.
	if vim.api.nvim_get_mode().mode:match("[vV]") then
		-- XXX(scheatkode): Quit visual mode to update the
		-- '< and '> marks.
		vim.api.nvim_feedkeys("\027", "xt", false)
		-- TODO(scheatkode): Maybe use `vim.region` after 0.10.
		-- ```lua
		-- vim.region(bufnr, "'<", "'>", vim.fn.visualmode(), true)
		-- ```
		lower_bound = vim.api.nvim_buf_get_mark(bufnr, "<")[1]
		upper_bound = vim.api.nvim_buf_get_mark(bufnr, ">")[1]
	else
		lower_bound = line
		upper_bound = line + vim.v.count - 1
	end

	list = filter(list, function(_, i)
		return i < lower_bound or i > upper_bound
	end)

	-- Replace items in the current list.
	if is_qf then
		vim.fn.setqflist({}, "r", { items = list })
	else
		vim.fn.setloclist(bufnr, {}, "r", { items = list })
	end

	-- Restore cursor position.
	vim.fn.setpos(".", { bufnr, line, 1, 0 })
end

vim.keymap.set("n", "q", "<cmd>q<CR>", {
	buffer = true,
	desc = "Close quickfix window",
})

vim.keymap.set("n", "dd", delete, {
	buffer = true,
	desc = "Delete quickfix entry under cursor",
})
vim.keymap.set("v", "d", delete, {
	buffer = true,
	desc = "Delete selected quickfix entries",
})

vim.b.did_after_ftplugin = 1

vim.opt_local.buflisted = false
vim.opt_local.signcolumn = "no"
vim.opt_local.bufhidden = "wipe"

vim.cmd.packadd("cfilter")
vim.cmd.cnoreabbrev({ "cfilter", "Cfilter" })
vim.cmd([[autocmd! BufEnter <buffer> if winnr('$') < 2 | q | endif]])

vim.keymap.set("n", "q", "<cmd>q<CR>", {
	buffer = true,
	desc = "Close quickfix window",
})

vim.opt_local.buflisted = false
vim.opt_local.signcolumn = "no"
vim.opt_local.bufhidden = "wipe"

vim.cmd([[autocmd! BufEnter <buffer> if winnr('$') < 2 | q | endif]])

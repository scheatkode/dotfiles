--- Neovim filetype plugin
--- Language: starlark

if vim.b.did_after_ftplugin == 1 then
	return
end

vim.opt_local.commentstring = "#%s"
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 78

vim.b.did_after_ftplugin = 1

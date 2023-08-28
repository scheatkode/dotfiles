--- Neovim filetype plugin
--- Language: Git commit message

if vim.b.did_after_ftplugin == 1 then
	return
end

vim.opt_local.textwidth = 72
vim.opt_local.spell = true

vim.b.did_after_ftplugin = 1

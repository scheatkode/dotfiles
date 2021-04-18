vim.o.background                 = 'dark'
-- e.g.gruvbox_contrast_dark   = 'hard'
vim.g.gruvbox_bold               = true
vim.g.gruvbox_italic             = true
vim.g.gruvbox_underline          = true
vim.g.gruvbox_undercurl          = true
vim.g.gruvbox_italicize_comments = true
vim.g.gruvbox_italicize_strings  = true

vim.cmd([[augroup ColorSchemeOverrides]])
vim.cmd([[autocmd ColorScheme gruvbox highlight GruvboxGreenSign ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme gruvbox highlight GruvboxOrangeSign ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme gruvbox highlight GruvboxBlueSign ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme gruvbox highlight GruvboxAquaSign ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme gruvbox highlight GruvboxRedSign ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme gruvbox highlight GruvboxYellowSign ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme gruvbox highlight clear SignColumn]])
vim.cmd([[autocmd ColorScheme gruvbox highlight clear Statusline]])
vim.cmd([[augroup END]])
vim.cmd([[colorscheme gruvbox]])

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80

vim.o.background                 = 'dark'
-- vim.g.gruvbox_contrast_dark   = 'hard'
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
vim.cmd([[augroup END]])
vim.cmd([[colorscheme gruvbox]])

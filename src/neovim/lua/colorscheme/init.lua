local e = vim

e.o.background                 = 'dark'
-- e.g.gruvbox_contrast_dark   = 'hard'
e.g.gruvbox_bold               = true
e.g.gruvbox_italic             = true
e.g.gruvbox_underline          = true
e.g.gruvbox_undercurl          = true
e.g.gruvbox_italicize_comments = true
e.g.gruvbox_italicize_strings  = true

e.cmd([[augroup ColorSchemeOverrides]])
e.cmd([[autocmd ColorScheme gruvbox highlight GruvboxGreenSign ctermbg=NONE guibg=NONE]])
e.cmd([[autocmd ColorScheme gruvbox highlight GruvboxOrangeSign ctermbg=NONE guibg=NONE]])
e.cmd([[autocmd ColorScheme gruvbox highlight GruvboxBlueSign ctermbg=NONE guibg=NONE]])
e.cmd([[autocmd ColorScheme gruvbox highlight GruvboxAquaSign ctermbg=NONE guibg=NONE]])
e.cmd([[autocmd ColorScheme gruvbox highlight GruvboxRedSign ctermbg=NONE guibg=NONE]])
e.cmd([[autocmd ColorScheme gruvbox highlight GruvboxYellowSign ctermbg=NONE guibg=NONE]])
e.cmd([[autocmd ColorScheme gruvbox highlight clear SignColumn]])
e.cmd([[autocmd ColorScheme gruvbox highlight clear Statusline]])
e.cmd([[augroup END]])
e.cmd([[colorscheme gruvbox]])

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:

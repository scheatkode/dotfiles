scriptencoding utf-8

" Vim filetype detection file
" Language: Git config file

autocmd BufNewFile,BufReadPost git/config,*/git/config setfiletype gitconfig

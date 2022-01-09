scriptencoding utf-8

" Vim filetype detection file
" Language: Cisco configuration

autocmd BufNewFile,BufReadPost *.cisco setfiletype cisco
autocmd BufNewFile,BufReadPost *.ios   setfiletype cisco

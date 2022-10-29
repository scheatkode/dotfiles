scriptencoding utf-8

" Vim filetype detection file
" Language: Bazel/Please build definition file

autocmd BufNewFile,BufReadPost BUILD   setfiletype python
autocmd BufNewFile,BufReadPost BUILD.* setfiletype python

scriptencoding utf-8

" Vim filetype detection file
" Language: SSH configuration

autocmd BufNewFile,BufRead ssh_config,*/ssh/config,*/.ssh/config setf sshconfig

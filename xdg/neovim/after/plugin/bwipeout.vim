" Wipe hidden buffers.
"
" Wipe  all  deleted  (unloaded  &  unlisted)  or  all
" unloaded buffers.
command! -bar -bang Bwipeout call bwipeout#bwipeout(<bang>0)

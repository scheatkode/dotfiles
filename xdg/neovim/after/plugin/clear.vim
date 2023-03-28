" Commands to clear stuff.

" Clear message history.
command! ClearMessages messages clear
" Clear undo history.
command! ClearUndo     execute "set ul=-1 | edit! | set ul=" . &ul

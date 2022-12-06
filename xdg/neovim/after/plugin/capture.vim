" Wipe hidden buffers.
"
" Capture the output of a given command into a new buffer.
command! -complete=command -nargs=+ Capture enew|pu=execute('<args>')|1,2d_

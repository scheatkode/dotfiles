
set rtp+=.
set rtp+=plenary
exec "set rtp+=" . stdpath('data') . "/site/pack/packer/opt/plenary"

runtime plugin/plenary.vim

nnoremap ,,x :luafile %<CR>

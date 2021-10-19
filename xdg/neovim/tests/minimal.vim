" grab dotfiles code
set rtp+=.

" use local version of plenary (required for CI)
set rtp+=../plenary.nvim

" when using packer
set rtp+=~/.local/share/nvim/site/pack/packer/opt/plenary.nvim
set rtp+=~/.local/share/nvim/site/pack/packer/opt/plenary
set rtp+=~/.local/share/nvim/site/pack/packer/start/plenary.nvim
set rtp+=~/.local/share/nvim/site/pack/packer/start/plenary

" when using vim-plug
set rtp+=~/.vim/plugged/plenary.nvim
set rtp+=~/.vim/plugged/plenary

runtime plugin/plenary.vim

" grab dotfiles code
set rtp+=.

" use local version of plenary (required for CI)
set rtp+=../plenary.nvim

" when using packer
set rtp+=~/.local/share/nvim/site/pack/packer/opt/plenary.nvim
set rtp+=~/.local/share/nvim/site/pack/packer/start/plenary.nvim

" when using vim-plug
set rtp+=~/.vim/plugged/plenary.nvim

runtime plugin/plenary.vim

lua << EOF
   do
      local pack_path = (
            os.getenv('XDG_CONFIG_HOME')
         or os.getenv('HOME') .. '/.config'
      ) .. '/lib/lua'

      package.path = string.format(
         '%s;%s/?.lua;%s/?/init.lua',
         package.path,
         pack_path,
         pack_path
      )
   end
EOF
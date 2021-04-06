local confirm = require('lib').func.confirm
local apply   = require('lib.config').keymaps.use

-- only required if packer is tagged as optional.

local packer_exists = pcall(vim.cmd, 'packadd packer.nvim')


-- automatic installation of packer

if not packer_exists then
   if not confirm('Download Packer ?') then
      return false
   end

   local directory = string.format(
      '%s/site/pack/packer/opt',
      vim.fn.stdpath('data')
   )

   vim.fn.mkdir(directory, 'p')

   print('Downloading packer.nvim...')

   local out = vim.fn.system(string.format(
      'git clone %s %s',
      'https://github.com/wbthomason/packer.nvim',
      directory .. '/packer.nvim'
   ))

   print(out)

   vim.cmd('PackerCompile')
   vim.cmd('PackerInstall')

   print('Restart is needed now')

   return false
end


-- keymaps

local keymaps = {
   {'n', '<leader>pc', '<cmd>PackerCompile<CR>', {silent = true, noremap = true}},
   {'n', '<leader>pC', '<cmd>PackerClean<CR>',   {silent = true, noremap = true}},
   {'n', '<leader>pi', '<cmd>PackerInstall<CR>', {silent = true, noremap = true}},
   {'n', '<leader>pu', '<cmd>PackerUpdate<CR>',  {silent = true, noremap = true}},
   {'n', '<leader>ps', '<cmd>PackerSync<CR>',    {silent = true, noremap = true}},
}

apply(keymaps)


-- packer configuration

return require('packer').startup(function(use)

   -- packer can manage itself as an optional plugin.

   use {'wbthomason/packer.nvim', opt = true}


   -- auto completion, language server clients, tags, and snippets plugins

   --use {'neoclide/coc.nvim', branch = 'release'}
   --use {'rhysd/vim-grammarous'}
   --use {'liuchengxu/vista.vim'}
   --use {'honza/vim-snippets'}
   --use {'nvim-lua/diagnostic-nvim'} -- deprecated
   --use {'nvim-lua/completion-nvim'}
   use {'hrsh7th/nvim-compe'}
   use {'neovim/nvim-lspconfig'}
   use {'anott03/nvim-lspinstall'}
   use {'glepnir/lspsaga.nvim'}
   use {'onsails/lspkind-nvim'}
   use {'windwp/nvim-autopairs'}


   -- fuzzy searching and file exploring plugins

   --use {'scrooloose/nerdTree', cmd = 'NERDTreeToggle'}
   --use {'junegunn/fzf', run = './install --all > /dev/null 2>&1'}
   --use {'junegunn/fzf.vim'}
   use {
      'kyazdani42/nvim-tree.lua',
      requires = {'kyazdani42/nvim-web-devicons'},
   }
   use {
      'nvim-telescope/telescope.nvim', -- extensible fuzzy finder
      requires = {
         {'nvim-lua/popup.nvim'},
         {'nvim-lua/plenary.nvim'},
         --{'nvim-telescope/telescope-fzy-native.nvim'},  -- fast sorter
         --{'nvim-telescope/telescope-media-files.nvim'}, -- media preview
         --{'nvim-telescope/telescope-frecency.nvim'},    -- media preview
      },
   }


   -- git plugins

   --use {'mhinz/vim-signify'}     -- git file changes in the gutter
   --use {'tpope/vim-fugitive'}      -- git wrapper
   --use {'mhinz/vim-signify'}
   use {'lewis6991/gitsigns.nvim'} -- git file changes in the gutter
   use {'TimUntersberger/neogit'}  -- magit for neovim


   -- syntax plugins

   --use {'sheerun/vim-polyglot'} -- syntax highlighting for different languages
   use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
         {'nvim-treesitter/playground'}, -- playground for treesitter
         {'nvim-treesitter/nvim-treesitter-textobjects'}, -- "smart" textobjects
      },
      run = ':TSUpdate'
   }


   -- visual

   --use {'nathanaelkane/vim-indent-guides'}  -- indent guides
   --use {'vim-airline/vim-airline'} -- status bar
   --use {'morhetz/gruvbox'}         -- THE colorscheme
   --use {'lifepillar/vim-gruvbox8'}   -- lighter colorscheme
   use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}} -- lua port of THE colorscheme
   --use {'itchyny/lightline.vim'}   -- *lighter* status bar
   --use {'ryanoasis/vim-devicons'}  -- icons for filetypes and the such
   --use {'camspiers/animate'}       -- animation library
   use {'camspiers/lens.vim'}        -- auto resize (panes|windows) when tight
   use {'junegunn/goyo.vim',           opt = true} -- distraction-free → no ui elements
   use {'junegunn/limelight.vim',      opt = true} -- distraction-free → dim paragraphs
   use {'norcalli/nvim-colorizer.lua', opt = true} -- colorize hex/rgb/hsl values
   use {
      'yamatsum/nvim-nonicons',
      requires = {'kyazdani42/nvim-web-devicons'}
   }
   use {
      'glepnir/galaxyline.nvim',
      branch   = 'main',
      requires = {'kyazdani42/nvim-web-devicons'}
   }


   -- miscellaneous plugins

   use {'b3nj5m1n/kommentary'}  -- commenting plugin
   use {'dstein64/vim-startuptime'} -- startup time monitor
   use {'mhinz/vim-startify'}      -- start screen
   --use {'psliwka/vim-smoothie'}    -- smooth scrolling
   use {'karb94/neoscroll.nvim'}   -- better smooth scrolling
   use {'lambdalisue/suda.vim'}    -- workaround for using `sudo`
   --use {'vimwiki/vimwiki'}         -- personal note taking
   --use {'plasticboy/vim-markdown'} -- markdown support
   --use {'pbrisbin/vim-mkdir'}      -- like mkdir -p, but for vim
   use {'kana/vim-operator-user'}  -- operator definitions for text objects
   use {'junegunn/vim-easy-align'} -- alignment made easy
   use {
      'machakann/vim-sandwich',
      --    cmd = {
      --      '<Plug>(operator-sandwich-add)',
      --      '<Plug>(operator-sandwich-delete)',
      --      '<Plug>(operator-sandwich-replace)',
      --      '<Plug>(textobj-sandwich-auto-a)',
      --      '<Plug>(textobj-sandwich-auto-i)',
      --      '<Plug>(textobj-sandwich-query-a)',
      --      '<Plug>(textobj-sandwich-query-i)'
      --    }
   }

end)

-- vim: set sw=3 ts=3 sts=3 et tw=81 fmr={{{,}}} fdl=0 fdm=marker:

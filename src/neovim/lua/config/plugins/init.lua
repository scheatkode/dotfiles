--- localise vim globals

local fn     = vim.fn
local cmd    = vim.cmd
local notify = vim.notify

local confirm = require('sol.util').confirm
local format  = require('sol.string').format

--- only required if packer is tagged as optional.

local has_packer = pcall(cmd, 'packadd packer.nvim')

--- packer automatic installation

if not has_packer then
   if not confirm('Download Packer ?') then return false end

   local directory = format('%s/site/pack/packer/opt', fn.stdpath('data'))

   fn.mkdir(directory, 'p')

   notify('Downloading packer.nvim ...')

   local out = fn.system(format(
      'git clone %s %s',
      'https://github.com/wbthomason/packer.nvim',
      directory .. '/packer.nvim'
   ))

   notify(out)

   local packer = require('packer')

   packer.compile()
   packer.install()

   print('Restart is needed now')

   return false
end

--- packer configuration

require('packer').startup(function(use)

   -- packer can manage itself as an optional plugin.

   use {'wbthomason/packer.nvim', opt = true}

   --- auto completion, language server clients, tags, and snippets plugins

   -- use {'nvim-lua/completion-nvim'}
   use {'hrsh7th/nvim-compe'}
   use {'neovim/nvim-lspconfig'}
   use {'anott03/nvim-lspinstall'}
   use {'glepnir/lspsaga.nvim'}
   use {'onsails/lspkind-nvim'}
   use {'folke/lsp-trouble.nvim'}
   -- use {'windwp/nvim-autopairs'}
   use {'steelsojka/pears.nvim'}
   use {'simrat39/symbols-outline.nvim'}
   use {'hrsh7th/vim-vsnip'}
   use {'rafamadriz/friendly-snippets'}

   --- fuzzy searching and file exploration plugins

   use {
      'kyazdani42/nvim-tree.lua', -- tree file explorer
      requires = {'kyazdani42/nvim-web-devicons'},
   }
   use {
      'nvim-telescope/telescope.nvim', -- extensible fuzzy finder
      requires = {
         {'nvim-lua/popup.nvim'},
         {'nvim-lua/plenary.nvim'},
         {'nvim-telescope/telescope-fzy-native.nvim'},  -- fast sorter
         {'nvim-telescope/telescope-media-files.nvim'}, -- media preview
         {'nvim-telescope/telescope-frecency.nvim'},    -- media preview
      },
   }

   --- git plugins

   -- use {'TimUntersberger/neogit'} -- magit for neovim
   use {'lewis6991/gitsigns.nvim'}   -- git file changes in the gutter
   use {'kdheepak/lazygit.nvim'}     -- lazygit wrapper inside neovim

   --- syntax plugins

   use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
         {'nvim-treesitter/playground'}, -- playground for treesitter
         {'nvim-treesitter/nvim-treesitter-textobjects'}, -- "smart" textobjects
      },
      run = ':TSUpdate'
   }

   --- visual

   use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}} -- lua port of THE colorscheme
   use {'camspiers/lens.vim'}        -- auto resize (panes|windows) when tight
   use {'junegunn/goyo.vim',           opt = true} -- distraction-free → no ui elements
   use {'junegunn/limelight.vim',      opt = true} -- distraction-free → dim paragraphs
   use {'norcalli/nvim-colorizer.lua', opt = true} -- colorize hex/rgb/hsl values
   use {
      'glepnir/galaxyline.nvim', -- sexy status line
      branch   = 'main',
      requires = {'kyazdani42/nvim-web-devicons'}
   }

   --- miscellaneous plugins

   use {'ojroques/nvim-bufdel'} -- delete buffer without messing up layout
   use {'folke/which-key.nvim'}
   use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
   use {'mbbill/undotree'}
   use {'b3nj5m1n/kommentary'}      -- commenting plugin
   use {'dstein64/vim-startuptime'} -- startup time monitor
   use {'mhinz/vim-startify'}       -- start screen
   use {'tversteeg/registers.nvim'} -- register quick peek
   use {'karb94/neoscroll.nvim'}    -- better smooth scrolling
   use {'lambdalisue/suda.vim'}     -- workaround for using `sudo`
   use {'kana/vim-operator-user'}   -- operator definitions for text objects
   use {'junegunn/vim-easy-align'}  -- alignment made easy
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

--- keymaps

local modifiers = {
      silent  = true,
      noremap = true
}

require('sol.vim').apply_keymaps({
   {'n', '<leader>pc', '<cmd>PackerCompile<CR>', modifiers},
   {'n', '<leader>pC', '<cmd>PackerClean<CR>',   modifiers},
   {'n', '<leader>pi', '<cmd>PackerInstall<CR>', modifiers},
   {'n', '<leader>pu', '<cmd>PackerUpdate<CR>',  modifiers},
   {'n', '<leader>ps', '<cmd>PackerSync<CR>',    modifiers},
})

--- whichkey setup

local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>P'] = {
         name = '+Plugins',

         c = {'Compile plugins (requires restart to take effect)'},
         C = {'Clean unused plugins'},
         i = {'Install plugins'},
         u = {'Update plugins'},
         s = {'Synchronize plugins'},
      },
   })
end

--- convenience

return setmetatable({}, {
   __index = function (_, file)
      local has_plugin, plugin = pcall('config.plugins.' .. file)

      if not ok then
         error('Plugin ' .. file .. ' not found.')
         return has_plugin
      end

      return plugin
   end,
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:

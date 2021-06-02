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

local packer = require('packer')
local util   = require('packer.util')

packer.init({
   package_root         = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
   compile_path         = util.join_paths(vim.fn.stdpath('data'), 'site', 'packer_compiled.vim'),

   ensure_dependencies  = true, -- should packer install plugin dependencies?

   plugin_package       = 'packer', -- the default package for plugins
   max_jobs             = 10,       -- limit the number of simultaneous jobs. nil means no limit

   auto_clean           = true, -- during sync(), remove unused plugins
   auto_reload_compiled = true, -- automatically reload the compiled file after creating it.
   compile_on_sync      = true, -- during sync(), run packer.compile()

   disable_commands     = false, -- disable creating commands
   opt_default          = false, -- default to using opt (as opposed to start) plugins
   transitive_opt       = true,  -- make dependencies of opt plugins also opt by default
   transitive_disable   = true,  -- automatically disable dependencies of disabled plugins

   git = {
      cmd           = 'git', -- the base command for git operations
      clone_timeout = 600,   -- timeout, in seconds, for git clones
      depth         = 1,     -- git clone depth

      subcommands = { -- format strings for git subcommands
         update         = '-C %s pull --ff-only --progress --rebase=false',
         install        = 'clone %s %s --depth %i --no-single-branch --progress',
         fetch          = '-C %s fetch --depth 999999 --progress',
         checkout       = '-C %s checkout %s --',
         update_branch  = '-C %s merge --ff-only @{u}',
         current_branch = '-C %s branch --show-current',
         diff           = '-C %s log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
         diff_fmt       = '%%h %%s (%%cr)',
         get_rev        = '-C %s rev-parse --short HEAD',
         get_msg        = '-C %s log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
         submodules     = '-C %s submodule update --init --recursive --progress'
      },
   },

   display = {
      non_interactive = false, -- if true, disable display windows for all operations
      open_fn         = nil, -- an optional function to open a window for packer's display
      open_cmd        = '65vnew [packer]', -- an optional command to open a window for packer's display
      working_sym     = '⟳', -- the symbol for a plugin being installed/updated
      error_sym       = '✗', -- the symbol for a plugin with an error in installation/updating
      done_sym        = '✓', -- the symbol for a plugin which has completed installation/updating
      removed_sym     = '-', -- the symbol for an unused plugin which was removed
      moved_sym       = '→', -- the symbol for a plugin which was moved (e.g. from opt to start)
      header_sym      = '━', -- the symbol for the header line in packer's display
      show_all_info   = true, -- should packer show all update details automatically?

      keybindings = { -- keybindings for the display window
         quit          = '<Esc>',
         toggle_info   = '<CR>',
         prompt_revert = 'r',
      }
   },

   luarocks = {
      python_cmd = 'python' -- set the python command to use for running hererocks
   },

   profile = {
      enable    = false,
      threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
   }
})

packer.startup(function (use)

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
         -- {'nvim-telescope/telescope-fzy-native.nvim'},  -- fast sorter
         {'nvim-telescope/telescope-project.nvim'}, -- project picker
         {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},  -- better sorter
         {'nvim-telescope/telescope-media-files.nvim'}, -- media preview
         {'nvim-telescope/telescope-frecency.nvim'},    -- frequency sorter
      },
   }

   --- git plugins

   use {'TimUntersberger/neogit',
      opt = true,
      cmd = 'Neogit',
} -- magit for neovim
   use {'lewis6991/gitsigns.nvim'}   -- git file changes in the gutter
   -- use {'kdheepak/lazygit.nvim'}     -- lazygit wrapper inside neovim
   use {'sindrets/diffview.nvim', -- ediff-like diff view
      -- opt = true,
      -- cmd = 'DiffviewOpen',
   }

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
   -- use {'tversteeg/registers.nvim'} -- register quick peek
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
   noremap = true,
}

require('sol.vim').apply_keymaps({
   {'n', '<leader>Pc', '<cmd>PackerCompile<CR>', modifiers},
   {'n', '<leader>PC', '<cmd>PackerClean<CR>',   modifiers},
   {'n', '<leader>Pi', '<cmd>PackerInstall<CR>', modifiers},
   {'n', '<leader>PI', '<cmd>PackerInstall<CR>', modifiers},
   {'n', '<leader>Pu', '<cmd>PackerUpdate<CR>',  modifiers},
   {'n', '<leader>PU', '<cmd>PackerUpdate<CR>',  modifiers},
   {'n', '<leader>Ps', '<cmd>PackerSync<CR>',    modifiers},
   {'n', '<leader>PS', '<cmd>PackerSync<CR>',    modifiers},
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

      if not has_plugin then
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

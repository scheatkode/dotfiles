--- localise global variables

local fn     = vim.fn
local notify = vim.notify
local format = string.format

--- check if packer is already installed
--
-- @return boolean whether packer is already installed
--
local is_packer_installed = function (install_path)
   local directory_exists = fn.isdirectory(install_path)

   if    directory_exists == 1
      or directory_exists == true
   then
      return true
   end
end


--- auto installs packer when needed and returns true when a sync is required
--
-- @return boolean whether a sync is required
--
local packer_autoinstall = function (install_path)
   local confirm = require('sol.util').confirm

   if not confirm('Download Packer ?') then return false end

   notify('Downloading packer.nvim ...')

   local out = fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
   })

   notify(out)

   return true
end


--- configure packer with sane defaults
--
local packer_configure = function ()
   local has_packer, packer = pcall(require, 'packer')
   local has_util,   util   = pcall(require, 'packer.util')

   if not has_packer or not has_util then
      error('Expected packer to be installed')
   end

   return packer.init({
      package_root         = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
      compile_path         = util.join_paths(vim.fn.stdpath('data'), 'site', 'plugin', 'compiled.lua'),

      ensure_dependencies  = true, -- should packer install plugin dependencies?

      plugin_package       = 'packer', -- the default package for plugins
      max_jobs             = 8,        -- limit the number of simultaneous jobs. nil means no limit

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
            update         = 'pull --ff-only --progress --rebase=false',
            install        = 'clone --depth %i --no-single-branch --progress',
            fetch          = 'fetch --depth 999999 --progress',
            checkout       = 'checkout %s --',
            update_branch  = 'merge --ff-only @{u}',
            current_branch = 'branch --show-current',
            diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
            diff_fmt       = '%%h %%s (%%cr)',
            get_rev        = 'rev-parse --short HEAD',
            get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
            submodules     = 'submodule update --init --recursive --progress'
         },
      },

      display = {
         non_interactive = false, -- if true, disable display windows for all operations
         open_fn         = nil, -- an optional function to open a window for packer's display
         open_cmd        = '60vnew packer', -- an optional command to open a window for packer's display
         working_sym     = '⟳', -- the symbol for a plugin being installed/updated
         error_sym       = '✗', -- the symbol for a plugin with an error in installation/updating
         done_sym        = '✓', -- the symbol for a plugin which has completed installation/updating
         removed_sym     = '-', -- the symbol for an unused plugin which was removed
         moved_sym       = '→', -- the symbol for a plugin which was moved (e.g. from opt to start)
         header_sym      = '━', -- the symbol for the header line in packer's display
         show_all_info   = true, -- should packer show all update details automatically?

         -- keybindings = { -- keybindings for the display window
         --    quit          = '<Esc>',
         --    toggle_info   = '<CR>',
         --    prompt_revert = 'r',
         -- }
      },

      luarocks = {
         python_cmd = 'python' -- set the python command to use for running hererocks
      },

      profile = {
         enable    = false,
         threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
      }
   })
end


--- configure packer to manage plugins
--
local packer_manage_plugins = function ()
   local has_packer,   packer   = pcall(require, 'packer')

   if not has_packer then
      error('Expected packer to be installed')
   end

   packer.startup(function (use)

      -- packer can manage itself

      use { 'wbthomason/packer.nvim' }


      -- miscellaneous requirements {{{

      use(require 'plugins.devicons') -- powered by kyazdani42/nvim-web-devicons
      use(require 'plugins.plenary')  -- powered by nvim-lua/plenary.nvim

      -- }}}
      -- completion, lsp clients, debuggers, and snippets plugins {{{

      use(require 'plugins.lspinstall')  -- powered by williamboman/nvim-lsp-installer
      use(require 'plugins.lspconfig')   -- powered by neovim/nvim-lspconfig
      use(require 'plugins.lint')
      use(require 'plugins.signature')   -- powered by xray/lsp_signature
      use(require 'plugins.diagnostics') -- powered by folke/lsp-trouble
      use(require 'plugins.symbols')     -- powered by simrat39/symbols-outline

      use(require 'plugins.snippets')    -- powered by L3MON4D3/LuaSnip
      use(require 'plugins.snippets-catalog')
      use(require 'plugins.completion')  -- powered by hrsh7th/nvim-compe

         use(require 'plugins.completion.buffer')
         use(require 'plugins.completion.calc')
         use(require 'plugins.completion.lsp')
         use(require 'plugins.completion.lua')
         use(require 'plugins.completion.path')
         use(require 'plugins.completion.snip')

      -- use {'nvim-lua/lsp-status.nvim'}

      use(require 'plugins.dap')
      use(require 'plugins.dapui')

      -- }}}

      use(require 'plugins.pairs') -- powered by windwp/nvim-autopairs

      -- fuzzy searching and file exploration plugins {{{

      use(require 'plugins.explorer')  -- tree-like file explorer
      use(require 'plugins.telescope') -- fuzzy searching

      -- }}}
      -- git plugins {{{

      use(require 'plugins.gitporcelain') -- magit for vim
      use(require 'plugins.gitsigns')     -- git file changes in the gutter
      use(require 'plugins.diff')         -- ediff-like diff viewing

      use {'rhysd/committia.vim', opt = true,
         ft = 'gitcommit',
         setup = function ()
            vim.g.committia_open_only_vim_starting = 0
            vim.g.committia_min_window_width       = 120
            vim.api.nvim_exec([[
               nnoremap <PgUp> <Plug>(committia-scroll-diff-up-half)
               nnoremap <PgDn> <Plug>(committia-scroll-diff-down-half)
            ]], false)
         end,
         config = function ()
            vim.api.nvim_exec([[:e!]], false)
         end,
      }

      -- }}}
      -- syntax plugins {{{

      use(require 'plugins.treesitter')
      use(require 'plugins.treesitter-textobjects')
      use(require 'plugins.treesitter-comment-string')

      use(require 'plugins.syntax.salt')
      use(require 'plugins.syntax.jinja')
      use(require 'plugins.syntax.twig')
      use(require 'plugins.syntax.plantuml')
      use(require 'plugins.syntax.blade')
      use(require 'plugins.syntax.pug')

      -- }}}
      -- visual

      use {'eddyekofo94/gruvbox-flat.nvim',
         setup = function()
            require('sol.vim').apply_variables('g', {
               -- gruvbox_flat_style = "dark",
               gruvbox_italic_comments  = true,
               gruvbox_italic_keywords  = true,
               gruvbox_italic_functions = false,
               gruvbox_italic_variables = false,

               gruvbox_sidebars = {
                  'nofile',
                  'Trouble',
                  'packer',
                  'qf',
                  'terminal',
                  'Outline',
                  'NvimTree'
               },
            })
         end,
         config = function () vim.cmd([[colorscheme gruvbox-flat]]) end,
      }

      -- use {'camspiers/lens.vim'}        -- auto resize (panes|windows) when tight
      use {'norcalli/nvim-colorizer.lua', opt = true} -- colorize hex/rgb/hsl values
      -- use {'glepnir/galaxyline.nvim', -- sexy status line
      --    branch   = 'main',
      --    event    = 'VimEnter',
      --    config   = function () require('config.plugins.galaxyline') end,
      --    wants    = { 'nvim-web-devicons' },
      --    requires = { 'kyazdani42/nvim-web-devicons' },
      -- }

      use {'famiu/feline.nvim', opt = true,
         event    = 'VimEnter',
         wants    = { 'nvim-web-devicons' },
         requires = { 'kyazdani42/nvim-web-devicons' },
         config = function ()
            local b = vim.b
            local fn = vim.fn
            local c = require('meta.colorscheme.gruvbox')
            local lsp = require('feline.providers.lsp')
            local vi_mode_utils = require('feline.providers.vi_mode')

            local components = {
               left = {
                  active = {},
                  inactive = {},
               },
               mid = {
                  active = {},
                  inactive = {},
               },
               right = {
                  active = {},
                  inactive = {},
               },
            }

            components.left.active[1] = {
               provider = '▊ ',
               hl = {
                  fg = 'skyblue'
               }
            }

            components.left.active[2] = {
               provider = 'vi_mode',
               hl = function()
                  local val = {}

                  val.name = vi_mode_utils.get_mode_highlight_name()
                  val.fg = vi_mode_utils.get_mode_color()
                  val.style = 'bold'

                  return val
               end,
               right_sep = ' '
            }

            components.left.active[3] = {
               provider = 'file_info',
               hl = {
                  fg = 'white',
                  bg = 'oceanblue',
                  style = 'bold'
               },
               left_sep = {
                  ' ', 'slant_left_2',
                  {str = ' ', hl = {bg = 'oceanblue', fg = 'NONE'}}
               },
               right_sep = {'slant_right_2', ' '}
            }

            components.left.active[4] = {
               provider = 'file_size',
               enabled = function() return fn.getfsize(fn.expand('%:p')) > 0 end,
               right_sep = {
                  ' ',
                  {
                     str = 'slant_left_2_thin',
                     hl = {
                        fg = 'fg',
                        bg = 'bg'
                     }
                  },
               }
            }

            components.left.active[5] = {
               provider = 'position',
               left_sep = ' ',
               right_sep = {
                  ' ',
                  {
                     str = 'slant_right_2_thin',
                     hl = {
                        fg = 'fg',
                        bg = 'bg'
                     }
                  }
               }
            }

            components.left.active[6] = {
               provider = 'diagnostic_errors',
               enabled = function() return lsp.diagnostics_exist('Error') end,
               hl = { fg = 'red' }
            }

            components.left.active[7] = {
               provider = 'diagnostic_warnings',
               enabled = function() return lsp.diagnostics_exist('Warning') end,
               hl = { fg = 'yellow' }
            }

            components.left.active[8] = {
               provider = 'diagnostic_hints',
               enabled = function() return lsp.diagnostics_exist('Hint') end,
               hl = { fg = 'cyan' }
            }

            components.left.active[9] = {
               provider = 'diagnostic_info',
               enabled = function() return lsp.diagnostics_exist('Information') end,
               hl = { fg = 'skyblue' }
            }

            components.right.active[1] = {
               provider = 'git_branch',
               hl = {
                  fg = 'white',
                  bg = 'black',
                  style = 'bold'
               },
               right_sep = function()
                  local val = {hl = {fg = 'NONE', bg = 'black'}}
                  if b.gitsigns_status_dict then val.str = ' ' else val.str = '' end

                  return val
               end
            }

            components.right.active[2] = {
               provider = 'git_diff_added',
               hl = {
                  fg = 'green',
                  bg = 'black'
               }
            }

            components.right.active[3] = {
               provider = 'git_diff_changed',
               hl = {
                  fg = 'orange',
                  bg = 'black'
               }
            }

            components.right.active[4] = {
               provider = 'git_diff_removed',
               hl = {
                  fg = 'red',
                  bg = 'black'
               },
               right_sep = function()
                  local val = {hl = {fg = 'NONE', bg = 'black'}}
                  if b.gitsigns_status_dict then val.str = ' ' else val.str = '' end

                  return val
               end
            }

            components.right.active[5] = {
               provider = 'line_percentage',
               hl = {
                  style = 'bold'
               },
               left_sep = '  ',
               right_sep = ' '
            }

            components.right.active[6] = {
               provider = 'scroll_bar',
               hl = {
                  fg = 'skyblue',
                  style = 'bold'
               }
            }

            components.left.inactive[1] = {
               provider = 'file_type',
               hl = {
                  fg = 'white',
                  bg = 'oceanblue',
                  style = 'bold'
               },
               left_sep = {
                  str = ' ',
                  hl = {
                     fg = 'NONE',
                     bg = 'oceanblue'
                  }
               },
               right_sep = {
                  {
                     str = ' ',
                     hl = {
                        fg = 'NONE',
                        bg = 'oceanblue'
                     }
                  },
                  'slant_right'
               }
            }

            require('feline').setup({
               colors = {
                  fg = '#ebdbb2',
                  bg = '#1d2021',
                  fore      = c.fg,
                  back      = c.bg,
                  dark      = c.bg0,
                  white     = c.fg0,
                  skyblue   = c.blue,
                  cyan      = c.aqua,
                  green     = c.green,
                  oceanblue = c.orange,
                  magenta   = c.aqua,
                  orange    = c.lightorange,
                  red       = c.red,
                  violet    = c.purple,
                  yellow    = c.yellow,
               },
            })
         end,
      }

      --- miscellaneous plugins

      use {'AckslD/nvim-revJ.lua', opt = true,
         config = function () require('config.plugins.revJ') end,
         keys   = {
            {'n', '<leader>ca'},
            {'v', '<leader>ca'},
         },
         requires = {
            'kana/vim-textobj-user',
            'sgur/vim-textobj-parameter',
      }}

      use(require 'plugins.todo')
      use(require 'plugins.notes')

      use {'kristijanhusak/orgmode.nvim', opt = true,
         disable = true,
         ft     = 'org',
         config = function () require('config.plugins.orgmode') end,
      }

      use {'ojroques/nvim-bufdel', opt = true, -- delete buffer without messing up layout
         cmd = {
            'BufDel',
         },
         keys = {
            '<leader>bk',
            '<leader>bK'
         },
         config = function () require('config.plugins.bufdel') end,
      }

      use(require 'plugins.whichkey')

      use {'kevinhwang91/nvim-bqf'}

      use(require 'plugins.indent')
      use(require 'plugins.align') -- alignment made easy
      use(require 'plugins.comment') -- commenting plugin

      -- use {'mbbill/undotree'}
      -- use {'b3nj5m1n/kommentary'}      -- commenting plugin
      use {'dstein64/vim-startuptime'} -- startup time monitor
      use {'mhinz/vim-startify'}       -- start screen
      -- use {'karb94/neoscroll.nvim'}    -- better smooth scrolling
      use {'lambdalisue/suda.vim'}     -- workaround for using `sudo`
      use {'kana/vim-operator-user'}   -- operator definitions for text objects

      use(require 'plugins.surround')

   end)
end


--- commit configuration -----------------------------------------------------

local install_path = format(
   '%s/site/pack/packer/start/packer.nvim',
   fn.stdpath('data')
)

if not is_packer_installed(install_path) then
   local should_sync = packer_autoinstall(install_path)

   if not should_sync then
      return false
   end

   vim.cmd [[packadd packer.nvim]]
   packer_configure()
   packer_manage_plugins()
   require('packer').sync()
else
   packer_configure()
   packer_manage_plugins()
end


--- keymaps ------------------------------------------------------------------

require('sol.vim').apply_keymaps({
   {'n', '<leader>Pc', '<cmd>PackerCompile<CR>'},
   {'n', '<leader>PC', '<cmd>PackerClean<CR>'},
   {'n', '<leader>Pi', '<cmd>PackerInstall<CR>'},
   {'n', '<leader>PI', '<cmd>PackerInstall<CR>'},
   {'n', '<leader>Pu', '<cmd>PackerUpdate<CR>'},
   {'n', '<leader>PU', '<cmd>PackerUpdate<CR>'},
   {'n', '<leader>Ps', '<cmd>PackerStatus<CR>'},
   {'n', '<leader>PS', '<cmd>PackerSync<CR>'},
})


--- whichkey setup -----------------------------------------------------------

local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>P'] = {
         name = '+plugins',

         c = {'Compile plugins'},
         C = {'Clean unused plugins'},
         i = {'Install plugins'},
         I = {'which_key_ignore'},
         u = {'Update plugins'},
         U = {'which_key_ignore'},
         s = {'Show status'},
         S = {'Synchronize plugins'},
      },
   })
end


--- convenience --------------------------------------------------------------

return setmetatable({}, {
   __index = function (_, file)
      local has_plugin, plugin = pcall('plugins.' .. file)

      if not has_plugin then
         error('Plugin ' .. file .. ' not found.')
         return has_plugin
      end

      return plugin
   end,
})

-- vim: set ft=lua fdm=marker fdl=0:


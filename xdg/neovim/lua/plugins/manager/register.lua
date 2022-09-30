local function setup()
	local has_packer, packer = pcall(require, 'packer')

	if not has_packer then
		error('Expected packer to be installed')
	end

	packer.startup(function(use)

		-- packer can manage itself

		use { 'wbthomason/packer.nvim' }

		use(require 'plugins.modes')

		-- miscellaneous requirements {{{

		use(require 'plugins.devicons') -- powered by kyazdani42/nvim-web-devicons
		use(require 'plugins.plenary') -- powered by nvim-lua/plenary.nvim

		-- }}}
		-- completion, lsp clients, debuggers, and snippets plugins {{{

		use(require 'plugins.mason') -- powered by williamboman/mason.nvim
		use(require 'plugins.mason-lspconfig') -- powered by williamboman/mason-lspconfig.nvim
		use(require 'plugins.lspconfig') -- powered by neovim/nvim-lspconfig
		use(require 'plugins.lspstatus') -- powered by nvim-lua/lsp-status.nvim
		use(require 'plugins.lint')
		use(require 'plugins.signature') -- powered by xray/lsp_signature
		use(require 'plugins.symbols') -- powered by simrat39/symbols-outline

		use(require 'plugins.snippets') -- powered by L3MON4D3/LuaSnip
		use(require 'plugins.snippets-catalog')
		use(require 'plugins.completion') -- powered by hrsh7th/nvim-cmp

			use(require 'plugins.completion.calc')
			use(require 'plugins.completion.lsp')
			use(require 'plugins.completion.lua')
			use(require 'plugins.completion.path')
			use(require 'plugins.completion.snip')

		use(require 'plugins.dap')
		use(require 'plugins.dapui')
		use(require 'plugins.testing')

		use(require 'plugins.annotation')

		use(require 'plugins.schema')

		-- }}}

		use(require 'plugins.pairs') -- powered by windwp/nvim-autopairs
		use(require 'plugins.autotag') -- powered by windwp/nvim-ts-autotag

		-- fuzzy searching and file exploration plugins {{{

		use(require 'plugins.explorer') -- tree-like file explorer
		use(require 'plugins.telescope') -- fuzzy searching

			use(require 'plugins.popup')
			use(require 'plugins.telescope-fzf-native')
			use(require 'plugins.telescope-project')

		-- }}}
		-- git plugins {{{

		use(require 'plugins.gitporcelain') -- magit for vim
		use(require 'plugins.gitsigns') -- git file changes in the gutter
		use(require 'plugins.diff') -- ediff-like diff viewing

		use { 'rhysd/committia.vim', opt = true,
			ft = 'gitcommit',
			setup = function()
				vim.g.committia_open_only_vim_starting = 0
				vim.g.committia_min_window_width       = 120
				vim.api.nvim_exec([[
               nnoremap <PgUp> <Plug>(committia-scroll-diff-up-half)
               nnoremap <PgDn> <Plug>(committia-scroll-diff-down-half)
            ]], false)
			end,
			config = function()
				vim.api.nvim_exec([[:e!]], false)
			end,
		}

		-- }}}
		-- syntax plugins {{{

		use(require 'plugins.treesitter')
		use(require 'plugins.treesitter-playground')
		use(require 'plugins.treesitter-textobjects')
		use(require 'plugins.treesitter-comment-string')

		use(require 'plugins.syntax.twig')
		use(require 'plugins.syntax.plantuml')
		use(require 'plugins.syntax.blade')
		use(require 'plugins.syntax.pug')

		-- }}}
		-- visual

		use(require 'plugins.colorizer')
		use(require 'plugins.statusline')

		--- miscellaneous plugins

		use(require 'plugins.movement')
		use(require 'plugins.harpoon')
		use(require 'plugins.splitjoin')
		use(require 'plugins.notes')
		use(require 'plugins.bufdel')

		use(require 'plugins.quickfix')

		use(require 'plugins.indent')
		use(require 'plugins.align') -- alignment made easy
		use(require 'plugins.comment') -- commenting plugin

		use { 'dstein64/vim-startuptime' } -- startup time monitor
		use { 'lambdalisue/suda.vim' }     -- workaround for using `sudo`

		use(require 'plugins.surround')

	end)
end

return {
	setup = setup
}

local function setup()
	local has_packer, packer = pcall(require, 'packer')
	local lazy               = require('lazy.on_index')

	if not has_packer then
		error('Expected packer to be installed')
	end

	packer.startup(function(use)

		-- packages running at startup

		use { 'wbthomason/packer.nvim' }
		use({ 'lewis6991/impatient.nvim' })

		-- miscellaneous requirements {{{

		use(lazy 'plugins.devicons') -- powered by kyazdani42/nvim-web-devicons
		use(lazy 'plugins.plenary') -- powered by nvim-lua/plenary.nvim

		-- }}}
		-- completion, lsp clients, debuggers, and snippets plugins {{{

		use(lazy 'plugins.mason') -- powered by williamboman/mason.nvim
		use(lazy 'plugins.mason-lspconfig') -- powered by williamboman/mason-lspconfig.nvim
		use(lazy 'plugins.lspconfig') -- powered by neovim/nvim-lspconfig
		use(lazy 'plugins.lspstatus') -- powered by nvim-lua/lsp-status.nvim
		use(lazy 'plugins.lint')
		use(lazy 'plugins.signature') -- powered by xray/lsp_signature
		use(lazy 'plugins.symbols') -- powered by simrat39/symbols-outline

		use(lazy 'plugins.snippets') -- powered by L3MON4D3/LuaSnip
		use(lazy 'plugins.snippets-catalog')
		use(lazy 'plugins.completion') -- powered by hrsh7th/nvim-cmp

			use(lazy 'plugins.completion.calc')
			use(lazy 'plugins.completion.lsp')
			use(lazy 'plugins.completion.lua')
			use(lazy 'plugins.completion.path')
			use(lazy 'plugins.completion.snip')

		use(lazy 'plugins.dap')
		use(lazy 'plugins.dapui')
		use(lazy 'plugins.dap-js')
		use(lazy 'plugins.testing')

		use(lazy 'plugins.annotation')

		use(lazy 'plugins.schema')

		-- }}}

		use(lazy 'plugins.pairs') -- powered by windwp/nvim-autopairs
		use(lazy 'plugins.autotag') -- powered by windwp/nvim-ts-autotag

		-- fuzzy searching and file exploration plugins {{{

		use(lazy 'plugins.explorer') -- tree-like file explorer
		use(lazy 'plugins.telescope') -- fuzzy searching

			use(lazy 'plugins.popup')
			use(lazy 'plugins.telescope-file-browser')
			use(lazy 'plugins.telescope-fzf-native')
			use(lazy 'plugins.telescope-project')

		-- }}}
		-- git plugins {{{

		use(lazy 'plugins.git-conflict') -- git conflict view
		-- use(lazy 'plugins.gitporcelain') -- magit for vim
		use(lazy 'plugins.git-fugitive') -- magit for vim
		use(lazy 'plugins.gitsigns') -- git file changes in the gutter
		use(lazy 'plugins.diff') -- ediff-like diff viewing

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

		use(lazy 'plugins.treesitter')
		use(lazy 'plugins.treesitter-playground')
		use(lazy 'plugins.treesitter-textobjects')
		use(lazy 'plugins.treesitter-comment-string')

		use(lazy 'plugins.syntax.twig')
		use(lazy 'plugins.syntax.plantuml')
		use(lazy 'plugins.syntax.blade')
		use(lazy 'plugins.syntax.pug')

		-- }}}
		-- visual

		use(lazy 'plugins.colorizer')
		use(lazy 'plugins.statusline')

		--- miscellaneous plugins

		use(lazy 'plugins.modes')
		use(lazy 'plugins.movement')
		use(lazy 'plugins.harpoon')
		use(lazy 'plugins.splitjoin')
		use(lazy 'plugins.notes')
		use(lazy 'plugins.bufdel')

		use(lazy 'plugins.quickfix')

		use(lazy 'plugins.indent')
		use(lazy 'plugins.align') -- alignment made easy
		use(lazy 'plugins.comment') -- commenting plugin

		use(lazy 'plugins.surround')

	end)
end

return {
	setup = setup
}

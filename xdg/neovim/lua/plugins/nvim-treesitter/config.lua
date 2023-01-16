return {
	setup = function()
		local flip           = require('f.function.flip')
		local is_file_bigger = require('user.predicates.is_file_bigger')

		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				'awk',
				'bash',
				'comment',
				'cpp',
				'css',
				'diff',
				'dockerfile',
				'git_rebase',
				'gitattributes',
				'gitcommit',
				'gitignore',
				'go',
				'gomod',
				'gowork',
				'hcl',
				'html',
				'http',
				'javascript',
				'jq',
				'jsdoc',
				'json',
				'jsonc',
				'json5',
				'lua',
				'make',
				'markdown',
				'markdown_inline',
				'norg',
				'python',
				'query',
				'regex',
				'rust',
				'scss',
				'sql',
				'svelte',
				'toml',
				'tsx',
				'typescript',
				'yaml',
			},

			autopairs   = { enable = true },
			autotag     = { enable = true },
			indent      = { enable = true },
			lsp_interop = { enable = true },
			highlight   = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = flip(is_file_bigger(1048576)), -- 1 MiB,
			},

			context_commentstring = {
				enable         = true,
				enable_autocmd = false,

				config = {
					cs = '// %s',
				},
			},

			incremental_selection = {
				enable = true,

				keymaps = {
					init_selection    = '<leader>v',
					node_incremental  = '<leader>a',
					scope_incremental = '<leader>s',
					node_decremental  = '<leader>i',
				},
			},

			textobjects = {
				lookahead = true,

				lsp_interop = {
					enable = true,

					peek_definition_code = {
						['<leader>cpf'] = '@function.outer',
						['<leader>cpc'] = '@class.outer',
					},
				},

				move = {
					enable    = true,
					set_jumps = true, -- update the jumplist

					goto_next_start = {
						[']f'] = {
							query = '@function.inner',
							desc  = 'Go to next function',
						},
						[']C'] = {
							query = '@class.outer',
							desc  = 'Go to next class definition',
						},
						[']b'] = {
							query = '@block.outer',
							desc  = 'Go to next block',
						},
						[']/'] = {
							query = '@comment.outer',
							desc  = 'Go to next comment',
						},
						[']i'] = {
							query = '@conditional.outer',
							desc  = 'Go to next condition',
						},
						[']l'] = {
							query = '@loop.outer',
							desc  = 'Go to next loop',
						},
					},

					goto_next_end = {},

					goto_previous_start = {
						['[f'] = {
							query = '@function.inner',
							desc  = 'Go to previous function',
						},
						['[C'] = {
							query = '@class.outer',
							desc  = 'Go to previous class definition',
						},
						['[b'] = {
							query = '@block.outer',
							desc  = 'Go to previous block',
						},
						['[/'] = {
							query = '@comment.outer',
							desc  = 'Go to previous comment',
						},
						['[i'] = {
							query = '@conditional.outer',
							desc  = 'Go to previous condition',
						},
						['[l'] = {
							query = '@loop.outer',
							desc  = 'Go to previous loop',
						},
					},

					goto_previous_end = {},
				},

				select = {
					enable = true,

					keymaps = {
						['ab'] = '@block.outer',
						['ib'] = '@block.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
						['aC'] = '@comment.outer',
						['iC'] = '@comment.inner',
						['ai'] = '@conditional.outer',
						['ii'] = '@conditional.inner',
						['al'] = '@loop.outer',
						['il'] = '@loop.inner',
						['aP'] = '@parameter.outer',
						['iP'] = '@parameter.inner',
						['af'] = '@function.outer',
						['if'] = '@function.inner',
					},
				},

				swap = {
					enable = true,

					swap_next = {
						['<leader>cs'] = '@swappable',
					},

					swap_previous = {
						['<leader>cS'] = '@swappable',
					},
				},
			},
		})
	end,
}

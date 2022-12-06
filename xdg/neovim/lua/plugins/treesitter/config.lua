return {
	setup = function()
		local has_treesitter, treesitter = pcall(require, 'nvim-treesitter.configs')
		local has_textobjects, _         = pcall(require, 'nvim-treesitter-textobjects')
		local has_commentstring, _       = pcall(require, 'ts_context_commentstring')

		if not has_treesitter then
			print('‼ Tried loading treesitter ... unsuccessfully.')
			return has_treesitter
		end

		if not has_textobjects then
			print('‼ Tried loading treesitter-textobjects ... unsuccessfully.')
		end

		if not has_commentstring then
			print('‼ Tried loading treesitter-comment-string ... unsuccessfully.')
		end

		treesitter.setup({
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
			highlight   = { enable = true },
			indent      = { enable = true },
			lsp_interop = { enable = true },

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
				}
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

					goto_next_end = {
					},

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

					goto_previous_end = {
					},
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
	end
}

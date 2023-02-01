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
				move = {
					enable    = true,
					set_jumps = true, -- update the jumplist

					goto_next = {
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

					goto_previous = {
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
				},

				select = {
					enable    = true,
					lookahead = true,

					keymaps = {
						['ab'] = {
							query = '@block.outer',
							desc  = 'Select around block region',
						},
						['ib'] = {
							query = '@block.inner',
							desc  = 'Select inside block region',
						},
						['aC'] = {
							query = '@class.outer',
							desc  = 'Select around class region',
						},
						['iC'] = {
							query = '@class.inner',
							desc  = 'Select inside class region',
						},
						['a/'] = {
							query = '@comment.outer',
							desc  = 'Select around comment region',
						},
						['i/'] = {
							query = '@comment.inner',
							desc  = 'Select inside comment region',
						},
						['ai'] = {
							query = '@conditional.outer',
							desc  = 'Select around conditional region',
						},
						['ii'] = {
							query = '@conditional.inner',
							desc  = 'Select inside conditional region',
						},
						['al'] = {
							query = '@loop.outer',
							desc  = 'Select around loop region',
						},
						['il'] = {
							query = '@loop.inner',
							desc  = 'Select inside loop region',
						},
						['aP'] = {
							query = '@parameter.outer',
							desc  = 'Select around parameter region',
						},
						['iP'] = {
							query = '@parameter.inner',
							desc  = 'Select inside parameter region',
						},
						['af'] = {
							query = '@function.outer',
							desc  = 'Select around function region',
						},
						['if'] = {
							query = '@function.inner',
							desc  = 'Select inside function region',
						},
					},
				},

				swap = {
					enable = true,

					swap_next = {
						['<leader>cs'] = {
							desc  = 'Swap current node with next',
							query = {
								'@swappable',
								'@parameter.*',
							},
						},
					},

					swap_previous = {
						['<leader>cS'] = {
							desc  = 'Swap current node with previous',
							query = {
								'@swappable',
								'@parameter.*',
							},
						},
					},
				},
			},

			playground = {
				enable = false,
			},
		})
	end,
}

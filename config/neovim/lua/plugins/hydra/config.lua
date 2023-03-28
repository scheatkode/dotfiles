return {
	setup = function()
		local lazy = require("load.on_member_call")
		local hydra = require("hydra")

		local dap = lazy("dap")
		local dapui = lazy("dapui")

		hydra({
			name = "Side scroll",
			mode = "n",
			body = "z",
			heads = {
				{ "h", "5zh" },
				{ "l", "5zl", { desc = "←/→" } },
				{ "H", "zH" },
				{ "L", "zL", { desc = "half screen ←/→" } },
			},
		})

		hydra({
			name = "Window resizing",
			mode = "n",
			body = "<C-w>",
			heads = {
				{ "<", "5<C-w><" },
				{ ">", "5<C-w>>", { desc = "5 × ←/→" } },
				{ ",", "<C-w><" },
				{ ".", "<C-w>>", { desc = "←/→" } },
				{ "+", "5<C-w>+" },
				{ "-", "5<C-w>-", { desc = "5 × ↑/↓" } },
			},
		})

		hydra({
			name = "Debug",
			body = "<leader>D",
			hint = [[
 ^ ^Step   ^ ^           Action
 ^-^------ ^ ^ --------------------------- 
 _K_: up   ^ ^     _t_: toggle breakpoint
 _O_: out  ^ ^     _T_: clear breakpaints
 _o_: over ^ ^ _<C-k>_: evaluate variable
 _i_: into ^ ^     _c_: continue
 _J_: down ^ ^     _C_: continue to cursor
 ^ ^       ^ ^     _r_: toggle repl

 ^ ^      _q_: exit ^ ^   _x_: terminate
]],
			config = {
				invoke_on_body = true,
				color = "pink",
				hint = {
					type = "window",
					offset = 2,
					position = "bottom-right",
				},
				on_enter = function()
					dapui.open()
				end,
				on_exit = function()
					dapui.close()
				end,
			},
			mode = {
				"n",
			},
			heads = {
				{ "c", dap.continue, { desc = "continue" } },
				{ "C", dap.run_to_cursor, { desc = "run to cursor" } },
				{ "t", dap.toggle_breakpoint, { desc = "toggle breakpoint" } },
				{ "T", dap.clear_breakpoints, { desc = "clear breakpoints" } },
				{ "i", dap.step_into, { desc = "step into" } },
				{ "o", dap.step_over, { desc = "step over" } },
				{ "O", dap.step_out, { desc = "step out" } },
				{ "J", dap.down, { desc = "go down the stacktrace" } },
				{ "K", dap.up, { desc = "go up the stacktrace" } },
				{ "<C-k>", dapui.eval, { desc = "evaluate variable" } },
				{ "x", dap.terminate, { desc = "terminate" } },
				{ "q", nil, { desc = "exit", nowait = true, exit = true } },
				{ "<Esc>", nil, { desc = false, nowait = true, exit = true } },

				{
					"r",
					function()
						require("dap").repl.toggle()
					end,
					{ exit = true, desc = "open repl" },
				},
			},
		})
	end,
}

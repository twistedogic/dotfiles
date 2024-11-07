return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local default_mappings = {
			n = {
				["<CR>"] = actions.select_horizontal,
			},
			i = {
				["<CR>"] = actions.select_horizontal,
			},
		}
		local default_insert = {
			mappings = default_mappings,
		}
		local default_normal = {
			initial_mode = "normal",
			mappings = default_mappings,
		}
		require("telescope").setup({
			defaults = {
				layout_strategy = "vertical",
			},
			pickers = {
				find_files = default_insert,
				live_grep = default_insert,
				lsp_incoming_calls = default_normal,
				lsp_outgoing_calls = default_normal,
				lsp_references = default_normal,
				lsp_definitions = default_normal,
				diagnostics = default_normal,
			},
		})
		vim.keymap.set("n", "<C-n>", builtin.find_files, {})
		vim.keymap.set("n", "ff", builtin.live_grep, {})
		vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
		vim.keymap.set("n", "<leader>ca", builtin.lsp_incoming_calls, {})
		vim.keymap.set("n", "<leader>og", builtin.lsp_outgoing_calls, {})
		vim.keymap.set("n", "<leader>rr", builtin.lsp_references, {})
		vim.keymap.set("n", "<leader>ge", builtin.diagnostics, {})
	end,
}

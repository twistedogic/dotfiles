return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local default_split = {
			n = {
				["<CR>"] = actions.select_horizontal,
			},
			i = {
				["<CR>"] = actions.select_horizontal,
			},
		}
		require("telescope").setup({
			defaults = {
				layout_strategy = "vertical",
			},
			pickers = {
				find_files = {
					mappings = default_split,
				},
			},
		})
		vim.keymap.set("n", "<C-n>", builtin.find_files, {})
		vim.keymap.set("n", "ff", builtin.live_grep, {})
	end,
}

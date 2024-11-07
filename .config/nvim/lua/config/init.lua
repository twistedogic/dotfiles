require("config.set")
require("config.remap")
require("config.lazy_init")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local LspGroup = augroup("LspGroup", {})

vim.cmd([[colorscheme kanagawa]])

autocmd("LspAttach", {
	group = LspGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "fs", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "L", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
	end,
})

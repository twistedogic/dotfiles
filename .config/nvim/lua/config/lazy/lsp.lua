return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"j-hui/fidget.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		local lsp_list = {
			"rust_analyzer",
			"gopls",
			"pyright",
			"bashls",
			"ts_ls",
		}

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = lsp_list,
		})
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entries = cmp.get_entries()
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						if #entries == 1 then
							cmp.confirm()
						end
					else
					end
				end, { "i", "s" }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),
		})
		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
		vim.lsp.enable(lsp_list)
	end,
}

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"mason.nvim",
			"nvim-lspconfig",
			"folke/lazydev.nvim",
		},

		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local ok, cmp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp.default_capabilities(capabilities)
			end

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
					"html",
					"cssls",
				},

				handlers = {
					function(server)
						lspconfig[server].setup({
							capabilities = capabilities,
						})
					end,

					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},

									diagnostics = {
										globals = { "vim" },
									},

									workspace = {
										checkThirdParty = false,
										library = vim.api.nvim_get_runtime_file("", true),
									},

									telemetry = {
										enable = false,
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			-- Capabilities (for nvim-cmp, if installed)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp.default_capabilities(capabilities)
			end

			mason_lspconfig.setup({
				ensure_installed = {
					-- Web
					"ts_ls",
					"html",
					"cssls",
					"eslint",
					"clangd",
					"pyright",
					"marksman",
				},
				-- FIX: Define handlers inside the setup table
				handlers = {
					-- Default handler
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- clangd (C / C++)
					["clangd"] = function()
						lspconfig.clangd.setup({
							capabilities = capabilities,
							cmd = { "clangd", "--background-index" },
						})
					end,

					-- Pyright (Python)
					["pyright"] = function()
						lspconfig.pyright.setup({
							capabilities = capabilities,
							settings = {
								python = {
									analysis = {
										typeCheckingMode = "basic",
										autoSearchPaths = true,
										useLibraryCodeForTypes = true,
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

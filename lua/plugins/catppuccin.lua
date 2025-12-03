return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			integrations = {
				treesitter = true,
				native_lsp = { enabled = true },
				cmp = true,
				gitsigns = true,
				telescope = true,
				notify = false,
				mini = false,
			},
		})

		-- Apply the colorscheme
		vim.cmd("colorscheme catppuccin-mocha")
	end,
}

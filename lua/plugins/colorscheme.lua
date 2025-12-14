return {
	{ "vim-scripts/newsprint.vim" },
	{ "gbprod/nord.nvim" },
	{ "slugbyte/lackluster.nvim" },
	{ "vim-scripts/zenesque.vim" },
	{ "jaredgorski/fogbell.vim" },
	{ "oahlen/iceberg.nvim" },
	{ "Skardyy/makurai-nvim" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "jnurmine/Zenburn" },
	{ "kdheepak/monochrome.nvim" },

	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_background = "hard"
		end,
	},
	{
		"blazkowolf/gruber-darker.nvim",
		opts = {
			bold = false,
		},
	},
	{
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
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = { transparent = true },
		config = function()
			require("tokyonight").setup({
				transparent = true,
			})
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({
				transparent = true,
			})

			-- Aplica o tema
			vim.cmd.colorscheme("vague")
		end,
	},
}

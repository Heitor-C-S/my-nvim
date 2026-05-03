-- ~/.config/nvim/lua/plugins/codeium.lua
return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp", -- If using nvim-cmp
	},
	config = function()
		require("codeium").setup({
			enable_chat = true, -- Enable free chat feature
		})
	end,
}

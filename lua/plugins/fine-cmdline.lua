return {
	"vonheikemen/fine-cmdline.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim", -- Required dependency
	},
	config = function()
		require("fine-cmdline").setup({
			-- Optional: customize appearance
			cmdline = {
				prompt = " λ ",
			},
		})

		-- Optional: keybinding to open command line
		vim.keymap.set("n", ":", function()
			require("fine-cmdline").open()
		end, { desc = "Fine command line" })
	end,
}

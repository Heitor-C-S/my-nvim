return {
	"karb94/neoscroll.nvim",
	opts = {},
	config = function()
		require("neoscroll").setup({
			performance_mode = false,
			duration_multiplier = 0.2,
			easing = "linear",
		})
	end,
}

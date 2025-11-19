return {

	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		-- silencia mensagens do which-key
		local orig_notify = vim.notify
		vim.notify = function(msg, level, opts)
			if type(msg) == "string" and msg:match("which%-key") then
				return
			end
			orig_notify(msg, level, opts)
		end

		-- local wk = require("which-key")
	end,
}

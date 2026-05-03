return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	config = function()
		require("lsp_signature").setup({
			bind = true,
			floating_window = true,
			floating_window_above_cur_line = true,
			hint_enable = true,
			hint_prefix = "🦉 ",
			hint_scheme = "String",
			wrap = true,
			always_trigger = false,
			extra_trigger_chars = { "<", "(", "," },
			toggle_key = "<C-x>", -- Ctrl+x para alternar janela
			doc_lines = 0,
			max_height = 1,
			max_width = math.floor(vim.api.nvim_win_get_width(0) * 0.9),
			handler_opts = { border = "rounded" },
			padding = " ",
			transparency = 10,
		})
	end,
}

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
			toggle_key = "<C-x>",

			-- 🔹 Ajustes para evitar o erro de 'height'
			doc_lines = 2, -- Aumente para pelo menos 2 para dar margem ao cálculo
			max_height = 12, -- 1 é muito restritivo e causa erros de cálculo com bordas
			max_width = 80, -- Use um valor fixo ou garanta que seja > 0

			handler_opts = {
				border = "rounded",
				zindex = 50,
			},

			padding = "", -- Tente deixar vazio se o erro persistir com " "
			transparency = 10,
			shadow_blend = 20,
			shadow_guibg = "#1e1e2e",
			hi_parameter = "LspSignatureActiveParameter",
		})
	end,
}

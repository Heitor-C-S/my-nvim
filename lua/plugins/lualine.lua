-- lua/plugins/lualine.lua

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Configuração de Diagnósticos: Ondinhas apenas para Erros e Avisos
		vim.diagnostic.config({
			underline = { severity = { min = vim.diagnostic.severity.WARN } },
			signs = { severity = { min = vim.diagnostic.severity.WARN } },
			virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
		})

		-- Definição dos componentes da barra
		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
			end,
		}

		local filename = {
			"filename",
			file_status = true,
			path = 1,
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			symbols = { added = " ", modified = " ", removed = " " },
			cond = hide_in_width,
		}

		-- Setup do Lualine
		require("lualine").setup({
			options = {
				theme = "vague",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree" },
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch" },
				lualine_c = { filename },
				lualine_x = {
					diagnostics,
					diff,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			extensions = { "fugitive" },
		})
	end,
}

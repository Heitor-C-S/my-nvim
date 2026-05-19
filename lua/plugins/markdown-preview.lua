return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- se você usa ícones
		ft = { "markdown" },
		opts = {
			-- Configuração padrão já é excelente
			heading = {
				sign = false, -- desativa ícones na margem esquerda se preferir
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " }, -- Ícones nerdfont para H1-H6
			},
		},
	},
}

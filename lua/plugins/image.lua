-- ~/.config/nvim/lua/plugins/image.lua
return {
	"3rd/image.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("image").setup({
			backend = "wezterm",
			processor = "magick", -- usa ImageMagick
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
				},
			},
			max_width = 100,
			max_height = 30,
			max_width_window_percentage = 100,
			max_height_window_percentage = 100,
			window_overlap_clear_enabled = true,
		})
	end,
}

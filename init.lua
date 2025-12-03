require("core.options")
require("core.keymaps")

-- Set default working directory
local function set_working_directory()
	local args = vim.fn.argv()
	local default_dir = "C:/Users/heito/Coisas/Coding"

	-- If started with 1 argument that's a directory, do nothing
	if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
		return
	end

	-- Otherwise, change to default directory
	vim.cmd("cd " .. default_dir)
end

set_working_directory()

-- Force proper encoding for all Lua files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.lua",
  callback = function()
    vim.opt.fileencoding = "utf-8"
    vim.opt.fileformat = "unix"
  end,
})

-- Clean up shada temp files on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.system("del /Q " .. vim.fn.stdpath("data") .. "\\shada\\main.shada.tmp.* 2>nul")
  end,
})

-- NOTE: lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim plugins
require("lazy").setup({
	-- Plugins configurations
	require("plugins.autocompletion"),
	require("plugins.neotree"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.indent-blankline"),
	require("plugins.comment"),
	require("plugins.autopairs"),
	require("plugins.which-key"),
	require("plugins.neogit"),
	require("plugins.tokyonight"),
	require("plugins.typescript-tools"),
	require("plugins.conform"),
	require("plugins.session"),
	-- require("plugins.catppuccin"),

	-- Mason and LSP config
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls", -- FIXED COMMA
					"html",
					"cssls",
					"eslint",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
		end,
	},
}, {
	-- Lazy options
	rocks = {
		enabled = true,
		hererocks = true,
	},
})

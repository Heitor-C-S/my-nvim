require("core.options")
require("core.keymaps")

-- Set default working directory
local function set_working_directory()
	local args = vim.fn.argv()
	local windows_default = "C:/Users/heito/Coisas/Coding"
	local home_default = vim.fn.expand("~")

	-- If started with 1 argument that's a directory (e.g., opening NVIM inside a folder)
	if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
		return
	end

	-- Decide which directory to use
	local target_dir = windows_default

	-- If Windows dir does NOT exist, fallback to HOME
	if vim.fn.isdirectory(target_dir) == 0 then
		target_dir = home_default
	end

	-- Change directory
	vim.cmd("cd " .. target_dir)
end

set_working_directory()

-- Force proper encoding for all Lua files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.lua",
	callback = function()
		vim.opt.fileencoding = "utf-8"
		vim.opt.fileformat = "unix"
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Fix: Convert path separators and add quotes for Windows command line
		local shada_path = vim.fn.stdpath("data"):gsub("/", "\\")
		local cmd = 'del /Q "' .. shada_path .. '\\shada\\main.shada.tmp.*" 2>nul'
		vim.fn.system(cmd)
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
	require("plugins.lsp"),
	require("plugins.neotree"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.indent-blankline"),
	require("plugins.comment"),
	require("plugins.autopairs"),
	require("plugins.which-key"),
	require("plugins.neogit"),
	require("plugins.typescript-tools"),
	require("plugins.conform"),
	require("plugins.session"),
	require("plugins.colorscheme"),
	require("plugins.bg"),
	require("plugins.yazi"),
	require("plugins.fire-nvim"),
	require("plugins.markdown-preview"),
	require("plugins.zoxide"),
	require("plugins.todo"),
	require("plugins.lsp-signature"),
	require("plugins.neoscroll"),
	require("plugins.autotag"),
}, {
	-- Lazy options
	rocks = {
		enabled = true,
		hererocks = true,
	},
})

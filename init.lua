require 'core.options'
require 'core.keymaps'

--CURRNT PLUGINS LIST:
--1.  autocompletion
--2.  autopairs
--3.  comment
--4.  indent-blankline
--5.  lualine
--6.  markdown-preview.lua
--7.  neogit.lua
--8.  neotree
--9.  telescope
--10. treesitter
--11. which-key
--12. tokyo night (theme)
--13. typescript-tools

vim.env.PATH = vim.env.PATH .. ";C:\\Program Files (x86)\\Lua\\5.1"
-- NOTE: lazy.nvim set-up
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
-- Clipboard integration
-- vim.g.clipboard = {
--   name = 'win32yank-wsl',
--   copy = {
--     ['+'] = 'win32yank.exe -i',
--     ['*'] = 'win32yank.exe -i',
--   },
--   paste = {
--     ['+'] = 'win32yank.exe -o',
--     ['*'] = 'win32yank.exe -o',
--   },
--   cache_enabled = 0,
-- }
-- vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }

-- Lazy.nvim plugins
require('lazy').setup {
  -- Plugins locais
  require('plugins.neotree'),
  require('plugins.lualine'),
  require('plugins.treesitter'),
  require('plugins.telescope'),
  -- require('plugins.alpha'),
  require('plugins.indent-blankLine'),
  -- require('plugins.autoformatting'), -- opcional
  require('plugins.comment'),
  require('plugins.autopairs'),
  -- require('plugins.neoscroll'),
  require('plugins.which-key'),
  require('plugins.neogit'),
  -- require('plugins.markdown-preview')
  require('plugins.tokyonight'),
  require('plugins.typescript-tools')
}


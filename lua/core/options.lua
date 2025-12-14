-- Make Line Numbers
vim.wo.number = true

-- Make relative line numbers
vim.opt.relativenumber = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Save undo history
vim.opt.undofile = true

vim.opt.clipboard = "unnamedplus"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 2 -- Define o número de espaços que um tab ocupa
vim.opt.shiftwidth = 2 -- Define o número de espaços usados para cada nível de indentação
vim.opt.expandtab = true -- Converte tabs em espaços

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local hl_groups = {
      "Normal", "NormalNC", "SignColumn", "MsgArea", 
      "TelescopeNormal", "TelescopeBorder", "EndOfBuffer",
    }
    for _, name in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, name, { bg = "NONE", ctermbg = "NONE" })
    end
  end,
})

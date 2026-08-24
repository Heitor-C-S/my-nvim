--oi

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- save file
vim.keymap.set("n", "<M-s>", "<cmd> w! <CR>", opts)

-- alt + q exit's
vim.keymap.set("n", "<M-q>", "<cmd> q! <CR>", opts)

-- exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {
  desc = "Exit terminal mode",
})

vim.keymap.set("n", "<leader>td", "<cmd>:Todo <CR>", { desc = "Open [t]o[d]o file.", silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

-- create a new terminal under the current buffer
vim.keymap.set(
  "n",
  "<leader>tj",
  "<cmd>:sp<CR> <C-w>j <cmd>:terminal <CR>",
  { desc = "Open horizontal terminal", silent = true }
)
-- navegate between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- Ir para o split à esquerda
vim.keymap.set("n", "<C-k>", "<C-w>k", opts) -- Ir para o split acima
vim.keymap.set("n", "<C-j>", "<C-w>j", opts) -- Ir para o split abaixo
vim.keymap.set("n", "<C-l>", "<C-w>l", opts) -- Ir para o split à direita

-- delete current buffer
vim.keymap.set("n", "<leader>bdf", "<cmd>bd!<CR>", { desc = "[B]uffer [D]elete [F]orce (!)" })
-- create new empty buffer
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Create [B]uffer [N]ew" })

-- set command root to this buffer directory
vim.keymap.set("n", "<leader>ncr", function()
  vim.cmd("cd %:p:h")
end, { desc = "[N]ew [C]ommand [R]oot (current buffer directory)" })

-- set previous directory as command root (duh)
vim.keymap.set("n", "<leader>pdr", function()
  vim.cmd("cd ..")
end, { desc = "[P]revious [D]irectory as Command [R]oot" })

-- Docker Refresh (need a compose.yaml file)
-- Use o comando completo para evitar ambiguidade com outros plugins
vim.keymap.set(
  "n",
  "<leader>rd",
  "<cmd>!docker compose up -d --build --remove-orphans<CR>",
  { desc = "Refresh Docker", silent = true }
)

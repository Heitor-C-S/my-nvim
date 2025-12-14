--oi
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- save file
vim.keymap.set("n", "<M-s>", "<cmd> w! <CR>", opts)

-- alt + q exit's
vim.keymap.set("n", "<M-q>", "<cmd> exit <CR>", opts)


vim.keymap.set("n","<leader>td", "<cmd>:Todo <CR>", { desc="Open [t]o[d]o file.", silent=true })

-- create a new terminal under the current buffer
vim.keymap.set("n", "<leader>tj","<cmd>:sp<CR> <C-w>j <cmd>:terminal <CR>", { desc = "Open horizontal terminal", silent = true })
-- navegate between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- Ir para o split à esque
vim.keymap.set('n', '<C-k>', '<C-w>k', opts) -- Ir para o split ac
vim.keymap.set('n', '<C-j>', '<C-w>j', opts) -- Ir para o split aba
vim.keymap.set('n', '<C-l>', '<C-w>l', opts) -- Ir para o split à dira

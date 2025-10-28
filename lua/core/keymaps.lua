--oi
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- save file
vim.keymap.set('n', '<M-s>', '<cmd> w! <CR>', opts)

-- alt + q exit's
vim.keymap.set('n', '<M-q>', '<cmd> exit <CR>', opts)

-- navegate between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', opts) -- Ir para o split à esquerda
vim.keymap.set('n', '<C-k>', '<C-w>k', opts) -- Ir para o split acima
vim.keymap.set('n', '<C-j>', '<C-w>j', opts) -- Ir para o split abaixo
vim.keymap.set('n', '<C-l>', '<C-w>l', opts) -- Ir para o split à direita


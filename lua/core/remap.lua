-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- U as redo (not sure why this doesn't work by default?)
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })


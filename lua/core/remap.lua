-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- U as redo (not sure why this doesn't work by default?)
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })

-- More obvious comment keybind
vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>norm gcc<cr>', { desc = "Toggle comment", noremap = true })
vim.api.nvim_set_keymap('v', '<leader>c', '<cmd>norm gc<cr>', { desc = "Toggle comment", noremap = true })

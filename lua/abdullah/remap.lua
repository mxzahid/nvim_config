vim.g.mapleader = " "
vim.keymap.set("n","<leader>pv",vim.cmd.Ex)
vim.keymap.set("n", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>", { desc = "Toggle TS Playground" })
-- quick window navigation
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>w", "<C-w>w", { desc = "Cycle windows" })



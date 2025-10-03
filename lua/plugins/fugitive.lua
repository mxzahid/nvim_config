return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "GBrowse", "Gblame" },
  keys = {
    { "<leader>ga", "<cmd>Git add .<CR>",                         desc = "Git status (Fugitive)" },
    { "<leader>gs", "<cmd>Git<CR>",                         desc = "Git status (Fugitive)" },
    { "<leader>gc", "<cmd>Git commit<CR>",                  desc = "Git commit" },
    { "<leader>gC", "<cmd>Git commit --amend<CR>",          desc = "Git commit --amend" },
    { "<leader>gp", "<cmd>Git push<CR>",                    desc = "Git push" },
    { "<leader>gP", "<cmd>Git pull --rebase<CR>",           desc = "Git pull --rebase" },
    { "<leader>gd", "<cmd>Gdiffsplit<CR>",                  desc = "Diff vs index" },
    { "<leader>gD", "<cmd>Gdiffsplit!<CR>",                 desc = "Diff (force, keep layout)" },
    { "<leader>gb", "<cmd>Gblame<CR>",                      desc = "Blame (inline virtual text)" },
    -- Open current file/line on remote host (needs 'vim-rhubarb' for GitHub)
    { "<leader>go", "<cmd>GBrowse<CR>",                     desc = "Open on remote (GBrowse)" },
    -- Visual mode: open selected lines on remote
    { "<leader>go", ":GBrowse<CR>", mode = "v",             desc = "Open selection on remote" },
  },
  dependencies = {
    -- Optional: enables GBrowse with GitHub remotes (like github.com)
    "tpope/vim-rhubarb",
  },
  init = function()
    -- (Optional) If you like :G as an alias to :Git
    vim.cmd.cnoreabbrev("G Git")
  end,
}


return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript", "json", "yaml", "go"
    },
    highlight = { enable = true },
    indent = { enable = true },
    Incremental_selection = { enable = false },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}


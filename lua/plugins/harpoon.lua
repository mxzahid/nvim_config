return {
  "theprimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local mark = require("harpoon.mark")
    local ui   = require("harpoon.ui")

    -- Add file to harpoon
    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon add file" })

    -- Toggle quick menu
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon quick menu" })

    -- Navigate directly to specific files
    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Harpoon file 4" })
  end,
}


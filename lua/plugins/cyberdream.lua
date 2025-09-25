return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
	transparent = true
    },
    config = function(_, opts)
    	vim.o.termguicolors = true
    	require("cyberdream").setup(opts)   -- safe even if opts is {}
    	vim.cmd.colorscheme("cyberdream")
	vim.api.nvim_set_hl(0,"Normal", { bg = "none" })
	vim.api.nvim_set_hl(0,"NormalFloat", { bg = "none" })
    end
}

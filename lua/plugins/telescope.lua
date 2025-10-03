return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8', -- or branch = '0.1.x'
  dependencies = { 'nvim-lua/plenary.nvim' },

  cmd = 'Telescope',
  keys = {
    { '<leader>pf', function() require('telescope.builtin').find_files() end, desc = 'Telescope: find files' },
    { '<C-p>',      function() require('telescope.builtin').git_files()  end, desc = 'Telescope: git files' },
    { '<leader>ps', function()
        require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })
      end,
      desc = 'Telescope: grep string'
    },
  },

  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    }
  end,
}


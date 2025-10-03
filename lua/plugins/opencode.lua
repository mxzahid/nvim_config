-- lua/plugins/opencode.lua
return {
  'NickvanDyke/opencode.nvim',

  -- Snacks is recommended for ask() and required for toggle()
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
  },

  -- Load on first keypress to avoid requiring the plugin at startup
  keys = {
    { '<leader>ot', function() require('opencode').toggle() end,              desc = 'OpenCode: Toggle embedded' },
    { '<leader>oa', function() require('opencode').ask('@cursor: ') end,     desc = 'OpenCode: Ask about cursor' },
    { '<leader>oa', function() require('opencode').ask('@selection: ') end,  mode = 'v', desc = 'OpenCode: Ask about selection' },
    { '<leader>o+', function() require('opencode').prompt('@buffer', { append = true }) end, desc = 'OpenCode: Add buffer to prompt' },
    { '<leader>o+', function() require('opencode').prompt('@selection', { append = true }) end, mode = 'v', desc = 'OpenCode: Add selection to prompt' },
    { '<leader>oe', function() require('opencode').prompt('Explain @cursor and its context') end, desc = 'OpenCode: Explain code' },
    { '<leader>on', function() require('opencode').command('session_new') end, desc = 'OpenCode: New session' },
    { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,   desc = 'OpenCode: Messages half page up' },
    { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'OpenCode: Messages half page down' },
    { '<leader>os', function() require('opencode').select() end, mode = { 'n', 'v' }, desc = 'OpenCode: Select prompt' },
  },

  -- Use init for early editor options, and config to set plugin opts
  init = function()
    -- Required for opencode opts.auto_reload to work properly
    vim.opt.autoread = true
  end,

  config = function()
    -- If opencode expects global opts (per its docs example), keep this:
    vim.g.opencode_opts = {
      -- Put your opencode options here, e.g.:
      -- provider = 'openai',
      -- auto_reload = true,
      -- model = 'gpt-4o-mini',
    }

    -- If the plugin also supports setup(), you can do:
    -- require('opencode').setup(vim.g.opencode_opts)
  end,
}


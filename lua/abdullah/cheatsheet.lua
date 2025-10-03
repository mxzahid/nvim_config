local CHEATSHEET = [[
╭───────────────────────────────╮
│          Keymap Guide         │
╰───────────────────────────────╯

[Git – Fugitive]
  <leader>gs   Git status
  <leader>gc   Git commit
  <leader>gC   Git commit --amend
  <leader>gp   Git push
  <leader>gP   Git pull --rebase
  <leader>gd   Gdiffsplit (diff vs index)
  <leader>gD   Gdiffsplit! (force, keep layout)
  <leader>gb   Gblame (inline virtual text)
  <leader>go   GBrowse (open on remote)
  (visual) <leader>go  GBrowse selection

[Telescope]
  <leader>pf   find_files
  <C-p>        git_files
  <leader>ps   grep_string (prompt)

[Harpoon]
  <C-h>        jump to harpoon 1
  <C-t>        jump to harpoon 2
  <C-n>        jump to harpoon 3
  <C-s>        jump to harpoon 4

[Tree-sitter]
  <leader>tp   TSPlaygroundToggle

[Windows]
  <leader>h    move to left window
  <leader>l    move to right window
  <leader>w    cycle windows

[Files]
  <leader>pv   Open netrw (Ex)
]]

local function open_cheatsheet()
  local buf = vim.api.nvim_create_buf(false, true)

  -- allow writing first
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(CHEATSHEET, "\n"))
  vim.api.nvim_buf_set_option(buf, "modifiable", false) -- lock after writing
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  local ui = vim.api.nvim_list_uis()[1]
  local width  = math.min(80, math.floor(ui.width * 0.7))
  local height = math.min(24, math.floor(ui.height * 0.7))
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width  - width)  / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row, col = col,
    width = width, height = height,
    style = "minimal",
    border = "rounded",
    title = " Keymap Guide ",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end, { buffer = buf, nowait = true, silent = true })
end

vim.api.nvim_create_user_command("KeymapsHelp", open_cheatsheet, {})
vim.keymap.set("n", "<leader>?", open_cheatsheet, { desc = "Show keymap guide" })


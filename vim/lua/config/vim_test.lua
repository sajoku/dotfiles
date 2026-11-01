-- ~/.config/nvim/lua/testing.lua
-- vim-test setup: runs tests in a Rex pane inside Rex, in a vimux pane in tmux.
-- Load AFTER the vimrc (needs mapleader = ",").

-- Where tests run
if vim.env.REX_SESSION then
  local runner = require("rex/rex_runner")
  vim.g["test#custom_strategies"] = { rex = function(cmd) runner.run(cmd) end }
  vim.g["test#strategy"] = "rex"
else
  vim.g["test#strategy"] = "vimux"
end

vim.g["test#echo_command"] = 0

-- Mappings
local map = function(lhs, cmd) vim.keymap.set("n", lhs, cmd, { silent = true }) end
map("<leader>t", "<cmd>TestNearest<cr>")
map("<leader>T", "<cmd>TestFile<cr>")
map("<leader>a", "<cmd>TestSuite<cr>")
map("<leader>l", "<cmd>TestLast<cr>")
map("<leader>g", "<cmd>TestVisit<cr>")

-- vim-tmux-runner (only used in tmux)
vim.g.VtrStripLeadingWhitespace = 0
vim.g.VtrClearEmptyLines = 0
vim.g.VtrAppendNewline = 1

-- Per-project overrides (e.g. test#python#runner), loaded last so they win
local project_file = vim.fn.getcwd() .. "/.vimrc.test_runners"
if vim.fn.filereadable(project_file) == 1 then
  vim.cmd.source(project_file)
end

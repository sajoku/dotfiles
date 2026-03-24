local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- NerdTree
map("n", "<leader>n", ":NERDTreeToggle<CR>", opts)
map("n", "<leader>f", ":NERDTreeFind<CR>", opts)

-- Copy filepath
map("n", "<Leader>cp", [[:let @+=expand("%:p")<CR>]], opts)

-- Disable arrows
for _, mode in ipairs({ "n", "i" }) do
  for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
    map(mode, key, "<nop>", opts)
  end
end

-- Test runners
map("n", "<leader>t", ":TestNearest<CR>", opts)
map("n", "<leader>T", ":TestFile<CR>", opts)
map("n", "<leader>a", ":TestSuite<CR>", opts)
map("n", "<leader>l", ":TestLast<CR>", opts)
map("n", "<leader>g", ":TestVisit<CR>", opts)


-- Celery
map("n", "<leader>c", [[ofrom celery.contrib import rdb;rdb.set_trace()<Esc>]], opts)

-- Typo fixes
vim.cmd([[
  command! Q q
  command! Qa qa
  command! Qall qall
  command! W w
  command! Wa wa
  command! Wq wq
  command! Wqa wqa
  command! Vsp vsp
  command! Sp sp
  command! Vs vs
]])

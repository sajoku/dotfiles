local home = vim.env.HOME
local map = vim.keymap.set
local group = vim.api.nvim_create_augroup("vimrc", { clear = true })
local function autocmd(event, opts)
  opts.group = group
  vim.api.nvim_create_autocmd(event, opts)
end

-- ============================================================
-- LEADER & PACKAGES
-- ============================================================
vim.g.mapleader = ","

local packages = home .. "/dotfiles/vimrc.packages"
if vim.fn.filereadable(packages) == 1 then
  vim.cmd.source(packages)
end

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update(nil, { force = true })
end, {})
vim.api.nvim_create_user_command("PackDel", function()
  vim.pack.del(vim.fn.input("Plugin name: "))
end, {})

-- ============================================================
-- GENERAL
-- ============================================================
-- Must be set before the colorscheme: underline matches instead of coloring them
autocmd("ColorScheme", {
  callback = function()
    vim.cmd("hi MatchParen ctermbg=NONE")
    vim.cmd("hi MatchWord ctermbg=NONE cterm=undercurl gui=undercurl")
  end,
})

vim.o.clipboard = "unnamed"
vim.o.showmode = false -- the statusline already shows the mode
vim.o.showtabline = 0
vim.o.laststatus = 2
vim.o.shell = "/bin/sh" -- running commands through fish is slow

-- Go to the last edited line when opening a file
autocmd("BufReadPost", {
  callback = function()
    local line = vim.api.nvim_buf_get_mark(0, '"')[1]
    if line > 0 and line <= vim.api.nvim_buf_line_count(0) then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Equalize splits when the terminal is resized
autocmd("VimResized", { command = "wincmd =" })

-- Open the quickfix / location list after commands that fill it
autocmd("QuickFixCmdPost", { pattern = "[^l]*", nested = true, command = "cwindow" })
autocmd("QuickFixCmdPost", { pattern = "l*", nested = true, command = "lwindow" })

-- ============================================================
-- FILE TREE (NERDTree, netrw)
-- ============================================================
vim.g.NERDTreeWinSize = 31
vim.g.NERDTreeShowHidden = 1
map("", "<leader>n", "<cmd>NERDTreeToggle<cr>")
map("", "<leader>f", "<cmd>NERDTreeFind<cr>")

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

-- ============================================================
-- MAPPINGS
-- ============================================================
map("", "<leader>ea:", ":EasyAlign \\<cr>")
map("", "<leader>ea =", "<cmd>EasyAlign =<cr>")
map("", "<leader>ea", ":EasyAlign")

-- Emacs-like beginning and end of line
map("i", "<c-e>", "<c-o>$")
map("i", "<c-a>", "<c-o>^")

map("x", "s", "S", { remap = true }) -- vim-surround
map("i", "jj", "<esc>")
map("n", "go", "o<esc>")             -- blank line below, stay in normal mode

-- Copy the current file's full path
map("n", "<leader>cp", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end)

-- Disable arrow keys
for _, key in ipairs({ "<up>", "<down>", "<left>", "<right>" }) do
  map({ "", "i" }, key, "<nop>")
end

map("n", "<leader>G", "<cmd>Git commit<cr>")

-- Typo fixes
for typo, cmd in pairs({
  Q = "q", Qa = "qa", Qall = "qall",
  W = "w", Wa = "wa", Wq = "wq", Wqa = "wqa",
  Vsp = "vsp", Sp = "sp", Vs = "vs",
}) do
  vim.api.nvim_create_user_command(typo, cmd, {})
end

-- ============================================================
-- FILETYPES
-- ============================================================
vim.filetype.add({
  extension = {
    rabl = "ruby",
    strings = "yaml",
    md = "markdown",
    exs = "elixir",
  },
  filename = {
    Gemfile = "ruby",
    Rakefile = "ruby",
    Guardfile = "ruby",
    Vagrantfile = "ruby",
    Thorfile = "ruby",
    Capfile = "ruby",
    ["config.ru"] = "ruby",
  },
  pattern = {
    [".*%.json%.jbuilder"] = "ruby",
    [".*%.html%.eex"] = "html",
  },
})

autocmd("FileType", {
  pattern = { "markdown", "asciidoc", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en", "nl" }
  end,
})

-- Python uses 4 spaces
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.py",
  callback = function()
    local o = vim.opt_local
    o.tabstop = 4
    o.softtabstop = 4
    o.shiftwidth = 4
    o.textwidth = 120
    o.expandtab = true
    o.autoindent = true
    o.fileformat = "unix"
  end,
})

vim.g.python_highlight_all = 1

-- Debug snippets per filetype (buffer-local)
local debug_snippets = {
  ruby = {
    ["<leader>d"] = "obinding.irb<esc>",
    ["<leader>1"] = [[oputs("[DBG] => #{expand('%')}")<esc>]],
  },
  python = {
    ["<leader>d"] = "obreakpoint()<esc>",
    ["<leader>1"] = [[oprint(f"[DBG] => ")<esc>]],
    ["<leader>c"] = "ofrom celery.contrib import rdb;rdb.set_trace()<esc>",
  },
  javascript = { ["<leader>d"] = "odebugger;<esc>" },
  typescript = { ["<leader>d"] = "odebugger;<esc>" },
}

autocmd("FileType", {
  pattern = vim.tbl_keys(debug_snippets),
  callback = function(ev)
    for lhs, rhs in pairs(debug_snippets[vim.bo[ev.buf].filetype]) do
      map("n", lhs, rhs, { buffer = ev.buf })
    end
  end,
})

-- Skeleton files
autocmd("BufNewFile", { pattern = "readme.md", command = "0r " .. home .. "/dotfiles/skeletons/readme.md" })
autocmd("BufNewFile", { pattern = "*.rb", command = "0r " .. home .. "/dotfiles/skeletons/ruby.rb" })

-- ============================================================
-- PLUGIN SETTINGS
-- ============================================================
-- vim-matchup
vim.g.matchup_matchparen_nomode = "i"
vim.g.matchup_matchpref = {
  html = { tagnameonly = 1 },
  htmldjango = { tagnameonly = 1 },
}
vim.g.matchup_matchparen_offscreen = { method = "popup" }

-- vim-go: format with goimports instead of gofmt
vim.g.go_fmt_command = "goimports"

-- fzf
vim.opt.rtp:append("/opt/homebrew/opt/fzf")

vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/shims/python")


-- ============================================================
-- EXTRA CONFIG FILES
-- ============================================================
-- Project-local .vimrc
vim.o.secure = true
local project_vimrc = vim.fn.getcwd() .. "/.vimrc"
if vim.fn.filereadable(project_vimrc) == 1 then
  vim.cmd.source(project_vimrc)
end

-- Plugin config split into ~/dotfiles/vim/ftplugin/* and ~/dotfiles/vim/rcfiles/*
for _, dir in ipairs({ "ftplugin", "rcfiles" }) do
  for _, file in ipairs(vim.fn.glob(home .. "/dotfiles/vim/" .. dir .. "/*", false, true)) do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd.source(file)
    end
  end
end

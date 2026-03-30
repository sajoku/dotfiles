-- plugins.lua (or inline in init.lua)
-- Neovim 0.12+ built-in package manager
-- Run :vim.pack.update() to update all plugins

vim.pack.add({
  -- Git
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/lewis6991/gitsigns.nvim",

  -- Editing utilities
  "https://github.com/tpope/vim-commentary",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-unimpaired",

  -- File explorer
  "https://github.com/preservim/nerdtree",

  -- UI / Breadcrumbs
  "https://github.com/Bekaboo/dropbar.nvim",

  -- Treesitter
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  "https://github.com/apple/pkl-neovim",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/shellRaining/hlchunk.nvim",

  -- Search
  "https://github.com/dmtrKovalenko/fff.nvim",

  -- Convenience
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/trouble.nvim",

  -- Tests
  "https://github.com/vim-test/vim-test",

  -- LSP & completion
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/nvimtools/none-ls.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/mikavilpas/blink-ripgrep.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",

  -- Rails / Ruby
  "https://github.com/tpope/vim-rails",
  "https://github.com/tpope/vim-bundler",

  -- Auto tag / end completion
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/RRethy/nvim-treesitter-endwise",
  "https://github.com/andymass/vim-matchup",

  -- Colors, icons, statusline
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",

  -- Themes
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/webhooked/kanso.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/danfry1/lume",

  -- Tmux
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/christoomey/vim-tmux-runner",
  "https://github.com/preservim/vimux",
})

-- TSUpdate hook: runs after nvim-treesitter is installed or updated
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      vim.cmd("TSUpdate")
    end
  end,
})

-- fff.nvim post-install hook
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "fff.nvim" then
      require("fff.download").download_or_build_binary()
    end
  end,
})

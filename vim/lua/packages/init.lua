vim.pack.add({
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/lewis6991/gitsigns.nvim",

  "https://github.com/tpope/vim-commentary",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-unimpaired",

  "https://github.com/preservim/nerdtree",

  "https://github.com/Bekaboo/dropbar.nvim",

  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  "https://github.com/apple/pkl-neovim",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/shellRaining/hlchunk.nvim",

  "https://github.com/dmtrKovalenko/fff.nvim",

  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/trouble.nvim",

  "https://github.com/vim-test/vim-test",

  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/nvimtools/none-ls.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/mikavilpas/blink-ripgrep.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",

  "https://github.com/tpope/vim-rails",
  "https://github.com/tpope/vim-bundler",

  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/RRethy/nvim-treesitter-endwise",
  "https://github.com/andymass/vim-matchup",

  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",

  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/webhooked/kanso.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/danfry1/lume",

  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/christoomey/vim-tmux-runner",
  "https://github.com/preservim/vimux",
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      vim.cmd("TSUpdate")
    end
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "fff.nvim" then
      require("fff.download").download_or_build_binary()
    end
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "fff.nvim" then
      require("fff.download").download_or_build_binary()
      vim.cmd("!cargo install --locked tree-sitter-cli")
    end
  end,
})


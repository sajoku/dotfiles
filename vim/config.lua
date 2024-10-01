require('nvim-highlight-colors').setup {}
require("barbecue").setup()
require("catppuccin").setup({
  flavour = "latte", -- latte, frappe, macchiato, mocha
  background = {     -- :h background
    light = "frappe",
    dark = "frappe",
  },
  transparent_background = true, -- disables setting the background color.
  show_end_of_buffer = true,     -- shows the '~' characters after the end of buffers
  term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = true,              -- dims the background color of inactive window
    shade = "light",
    percentage = 0.15,           -- percentage of the shade to apply to the inactive window
  },
  no_italic = false,             -- Force no italic
  no_bold = false,               -- Force no bold
  no_underline = false,          -- Force no underline
  styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" },     -- Change the style of comments
    conditionals = { "italic" },
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    fzf = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    telescope = {
      enabled = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
        ok = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin-frappe"
vim.o.background = "dark" -- set moon or dawn

--require("rose-pine").setup({
--  variant = "auto",      -- auto, main, moon, or dawn
--  dark_variant = "main", -- main, moon, or dawn
--  dim_inactive_windows = false,
--  extend_background_behind_borders = true,

--  enable = {
--    terminal = true,
--    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
--    migrations = true,        -- Handle deprecated options automatically
--  },

--  styles = {
--    bold = true,
--    italic = true,
--    transparency = false,
--  },

--  groups = {
--    border = "muted",
--    link = "iris",
--    panel = "surface",

--    error = "love",
--    hint = "iris",
--    info = "foam",
--    note = "pine",
--    todo = "rose",
--    warn = "gold",

--    git_add = "foam",
--    git_change = "rose",
--    git_delete = "love",
--    git_dirty = "rose",
--    git_ignore = "muted",
--    git_merge = "iris",
--    git_rename = "pine",
--    git_stage = "iris",
--    git_text = "rose",
--    git_untracked = "subtle",

--    h1 = "iris",
--    h2 = "foam",
--    h3 = "rose",
--    h4 = "gold",
--    h5 = "pine",
--    h6 = "foam",
--  },


--  highlight_groups = {
--    StatusLine = { fg = "love", bg = "love", blend = 10 },
--    StatusLineNC = { fg = "subtle", bg = "surface" },

--    TelescopeBorder = { fg = "overlay", bg = "overlay" },
--    TelescopeNormal = { fg = "subtle", bg = "overlay" },
--    TelescopeSelection = { fg = "text", bg = "highlight_med" },
--    TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
--    TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

--    TelescopeTitle = { fg = "base", bg = "love" },
--    TelescopePromptTitle = { fg = "base", bg = "pine" },
--    TelescopePreviewTitle = { fg = "base", bg = "iris" },

--    TelescopePromptNormal = { fg = "text", bg = "surface" },
--    TelescopePromptBorder = { fg = "surface", bg = "surface" },
--  },

--  before_highlight = function(group, highlight, palette)
--    -- Disable all undercurls
--    -- if highlight.undercurl then
--    --     highlight.undercurl = false
--    -- end
--    --
--    -- Change palette colour
--    -- if highlight.fg == palette.pine then
--    --     highlight.fg = palette.foam
--    -- end
--  end,
--})

--vim.cmd("colorscheme rose-pine")
--vim.o.background = "light" -- set moon or dawn

---- vim.cmd("colorscheme rose-pine-main")
---- vim.cmd("colorscheme rose-pine-moon")
---- vim.cmd("colorscheme rose-pine-dawn")


require('nvim-treesitter.configs').setup({
  -- A list of parser names, or 'all'
  ensure_installed = { 'c', 'lua', 'rust', 'ruby', 'python', 'json', 'vim', 'yaml', 'html', 'css', 'htmldjango',
    'javascript', 'typescript' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  auto_install = true,
  -- List of parsers to ignore installing (for 'all')
  --ignore_install = { 'javascript' },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  endwise = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = {},  -- optional, list of language that will be disabled
  },

})

require('nvim-ts-autotag').setup({
  opts = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = {
      'html', 'htmldjango',
      'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte',
      'vue', 'tsx',
      'jsx', 'rescript', 'ts',
      'rb', 'ruby',
      'xml',
      'php',
      'markdown',
      'astro', 'glimmer', 'handlebars', 'hbs'
    }
  }
})

require('treesitter-context').setup({
  enable = true,         -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0,         -- How many lines the window should span. Values <= 0 mean no limit.
  trim_scope = 'outer',  -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  patterns = {           -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    default = {
      'class',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
    },
    -- Patterns for specific filetypes
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    tex = {
      'chapter',
      'section',
      'subsection',
      'subsubsection',
    },
    rust = {
      'impl_item',
      'struct',
      'enum',
    },
    scala = {
      'object_definition',
    },
    vhdl = {
      'process_statement',
      'architecture_body',
      'entity_declaration',
    },
    markdown = {
      'section',
    },
    elixir = {
      'anonymous_function',
      'arguments',
      'block',
      'do_block',
      'list',
      'map',
      'tuple',
      'quoted_content',
    },
    json = {
      'pair',
    },
    yaml = {
      'block_mapping_pair',
    },
  },
  exact_patterns = {
    -- Example for a specific filetype with Lua patterns
    -- Treat patterns.rust as a Lua pattern (i.e '^impl_item$' will
    -- exactly match 'impl_item' only)
    -- rust = true,
  },

  -- [!] The options below are exposed but shouldn't require your attention,
  --     you can safely ignore them.

  zindex = 20,     -- The Z-index of the context window
  mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
})

-- Setup language servers.
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require('lspconfig')

lspconfig.luau_lsp.setup({})
lspconfig.lua_ls.setup {}
local on_attach_tailwind = function(client, bufnr)
  -- other stuff --
  require("tailwindcss-colors").buf_attach(bufnr)
end

lspconfig.tailwindcss.setup({
  on_attach = on_attach_tailwind,
})
lspconfig.marksman.setup({})
lspconfig.html.setup({})
local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup {
  capabilities = cssls_capabilities,
  settings = {
    css = {
      lint = {
        unknownAtRules = 'ignore' --ignore @apply and @tailwind
      }
    }
  }
}

lspconfig.pyright.setup {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
}
local on_attach_ruff_lsp = function(client, bufnr)
end
lspconfig.ruff.setup({
  init_options = {
    settings = {
      format = {
        preview = true
      }
    }
  }
})

--completions.completeFunctionCalls
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  settings = {
    completions = {
      completeFunctionCalls = true
    }
  }
})
lspconfig.standardrb.setup({})
-- lspconfig.solargraph.setup {}
lspconfig.ruby_lsp.setup {}
lspconfig.rust_analyzer.setup({
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
})

local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
if hasConfigs then
  configs.setup {
    ensure_installed = "pkl",
    highlight = {
      enable = true, -- false will disable the whole extension
    },
    indent = {
      enable = true
    }
  }
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keysvimrc
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- On save format the code
vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', 'g/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

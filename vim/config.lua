require('nvim-highlight-colors').setup {}
require("barbecue").setup()


require("catppuccin").setup({
  flavour = "auto", -- latte, frappe, macchiato, mocha
  -- background = {    -- :h background
  --   light = "latte",
  --   dark = "macchiato",
  -- },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = true,      -- shows the '~' characters after the end of buffers
  term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = true,               -- dims the background color of inactive window
    shade = "light",
    percentage = 0.35,            -- percentage of the shade to apply to the inactive window
  },
  styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" },      -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Uncomment to turn off hard-coded styles
  },
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
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
        ok = { "undercurl" },
      },
      inlay_hints = {
        background = true,
      },
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})
require("rose-pine").setup({
  variant = "auto",      -- auto, main, moon, or dawn
  dark_variant = "main", -- main, moon, or dawn
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true,        -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },
})

require('lualine').setup {
  options = {
    theme = "rose-pine"
  }
}

local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
  update_interval = 3000,
  set_dark_mode = function()
    vim.cmd('colorscheme rose-pine-moon')
  end,
  set_light_mode = function()
    --vim.cmd('colorscheme xcodelight')
    vim.cmd('colorscheme rose-pine-dawn')
  end,
})

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
lspconfig.lua_ls.setup({})
local on_attach_tailwind = function(client, bufnr)
  -- other stuff --
  require("tailwindcss-colors").buf_attach(bufnr)
end

lspconfig.tailwindcss.setup({
  on_attach = on_attach_tailwind,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass", "extra_class", ".*className", "add_class" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      sortSelection = true,
      codeAction = true,
      validate = true
    }
  }
})

lspconfig.marksman.setup({})

lspconfig.html.setup({
  filetypes = { 'html', 'templ' } -- ,'htmldjango' }
})

-- lspconfig.superhtml.setup {
--   filetypes = { 'superhtml', 'djangohtml' }
-- }
--lspconfig.superhtml.setup({
--  name = 'superhtml',
--  cmd = { 'superhtml', 'lsp' },
--  filetypes = { 'html', 'shtml', 'htm', 'htmldjango' },
--  --root_dir = require('lspconfig.util').root_pattern('.git')
--  root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
--})
--

-- This does not trigger on htmldjango (check local .vimrc in projects also;))
-- This only triggers shtml and html files as htmldjango will produce to much
-- errors because of the {} and {%%} tags
lspconfig.superhtml.setup({})
local function get_django_settings()
  return os.getenv("DJANGO_SETTINGS_MODULE") or ""
end
lspconfig.djlsp.setup {
  cmd = { "/Users/sajoku/.pyenv/shims/djlsp" },
  init_options = {
    djlsp = {
      django_settings_module = get_django_settings()
    }
  }
}

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

-- local on_attach_ruff_lsp = function(_client, bufnr)
-- end
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

-- enable json
lspconfig.jsonls.setup {}

--lspconfig.standardrb.setup({})
-- lspconfig.solargraph.setup {}
-- --local lspconfig = require('lspconfig')
lspconfig.ruby_lsp.setup({
  init_options = {
    formatter = 'rubocop',
    linters = { 'rubocop' },
  },
})
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


local blink = require('blink.cmp')
blink.setup({
  keymap = {
    preset = "enter",
  },
  completion = {
    -- do not show in the cmdline of vim/nvim because I know these commands
    -- menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end },
    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = true },
  },
  signature = {
    enabled = true,
  },
  --trigger = { signature_help = { enabled = true } },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
      --"ripgrep", -- 👈🏻 add "ripgrep" here
    },
    cmdline = {},
    providers = {
      -- 👇🏻👇🏻 add the ripgrep provider config below
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {
          prefix_min_len = 3,
          context_size = 5,
          max_filesize = "1M",
          additional_rg_options = {}
        },
      },
    },
  },
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.diagnostic.config({
  virtual_text = {
    source = "if_many", -- Or "if_many"
    prefix = '', -- Could be '●', '▎', 'x'
  },
  float = {
    source = "always", -- Or "if_many"
  },
})

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
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Pressing gd while go to definition
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
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- pressing gr wil find all reference
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
--vim.keymap.set('n', 'g/', builtin.live_grep, {})
--vim.keymap.set("n", "<space>fg", require "lua.telescope.multi-ripgrep")
vim.keymap.set("n", "g/", require "lua.telescope.multi-ripgrep")
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set("n", "<space>fg", require "lua.telescope.multi-ripgrep")

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

--init todo-comments
require("todo-comments").setup()

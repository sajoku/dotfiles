-- Require config files
require("lua.config.options")
require("lua.config.filetypes")
require("lua.config.keymaps")

require('nvim-highlight-colors').setup {
  render = 'virtual',
}
require("barbecue").setup()

require("rose-pine").setup({
  variant = "auto",      -- auto, main, moon, or dawn
  dark_variant = "moon", -- main, moon, or dawn
  dim_inactive_windows = true,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    migrations = true, -- Handle deprecated options automatically
  },
  styles = {
    bold = true,
    italic = true,
    transparency = true,
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
    vim.cmd('colorscheme rose-pine-dawn')
  end,
})


require('nvim-treesitter.configs').setup({
  -- A list of parser names, or 'all'
  ensure_installed = { 'c', 'lua', 'rust', 'ruby', 'python', 'json', 'vim', 'yaml', 'html', 'css', 'htmldjango',
    'javascript', 'typescript', 'query' },

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
  --require("tailwindcss-colors").buf_attach(bufnr)
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

require("tailwind-tools").setup({
  document_color = {
    enabled = false
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
    formatter = 'auto', --or rubocop for most of the projects
    linters = { 'rubocop_internal', 'erb_lint' },
    filetypes = { "ruby", "eruby" },
  },
})

local lint = require("lint")
lint.linters_by_ft = {
  eruby = { 'erb_lint' },
}

lint.linters.erb_lint = require("lint.util").wrap(lint.linters.erb_lint, function(diagnostic)
  diagnostic.severity = vim.diagnostic.severity.ERROR
  return diagnostic
end)
-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
--   callback = function()
--     -- lint based oon the linters_by_ft defined above
--     require("lint").try_lint()
--   end,
-- })

--add a shortcut to format eruby files
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>el",
--   ":!bundle exec erb_lint --lint-all --autocorrect<CR>",
--   { noremap = true, silent = true }
-- )

local django_settings_module = os.getenv("DJANGO_SETTINGS_MODULE") or "default.settings"
require 'lspconfig'.djlsp.setup {
  cmd = { "/Users/sajoku/.pyenv/shims/djlsp" },
  init_options = {
    django_settings_module = django_settings_module,
  }
}


lspconfig.rust_analyzer.setup({
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
})


local blink = require('blink.cmp')
blink.setup({
  keymap = {
    preset = "enter",
  },
  cmdline = {
    enabled = true
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
    -- This is currenlty failing .-> It should show the current line with
    -- "ghost-text" ie. how oit would look like when selecting the current item
    --ghost_text = { enabled = true },
    menu = { auto_show = true },
  },
  signature = {
    enabled = true,
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  --trigger = { signature_help = { enabled = true } },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
      --"ripgrep", -- 👈🏻 add "ripgrep" here
    },
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


local fzf = require('fzf-lua')
fzf.setup({
  { 'telescope', 'ivy' },
  fzf_colors = {
    true,
  },
})
-- Find files
vim.keymap.set('n', '<leader>ff', fzf.files, {})
vim.keymap.set('n', '<C-p>', fzf.files, {})

-- Live grep
vim.keymap.set('n', '<leader>fg', fzf.live_grep_native or fzf.live_grep, {})
vim.keymap.set('n', '<C-f>', fzf.live_grep_native or fzf.live_grep, {})
vim.keymap.set('n', 'g/', fzf.live_grep_native or fzf.live_grep, {})

-- Buffers
vim.keymap.set('n', '<leader>fb', fzf.buffers, {})

-- Help tags
vim.keymap.set('n', '<leader>fh', fzf.help_tags, {})
-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

--init todo-comments
require("todo-comments").setup()
require("lua.plugins.none-ls")

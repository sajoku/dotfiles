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

-- Completions with nvim-cmp
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup language servers.
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require('lspconfig')

lspconfig.luau_lsp.setup({})
lspconfig.lua_ls.setup {}
lspconfig.tailwindcss.setup({})
lspconfig.marksman.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup {}

lspconfig.pyright.setup({
  capabilities = capabilities,
})
local on_attach_ruff_lsp = function(client, bufnr)
  -- Disable hover in favor of Pyright
  client.server_capabilities.hoverProvider = false
end
lspconfig.ruff_lsp.setup({
  on_attach = on_attach_ruff_lsp,
  init_options = {
  }
})

--completions.completeFunctionCalls
lspconfig.tsserver.setup({
  capabilities = capabilities,
  settings = {
    completions = {
      completeFunctionCalls = true
    }
  }
})
lspconfig.standardrb.setup({})
lspconfig.solargraph.setup {}
lspconfig.rust_analyzer.setup({
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
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
local actions = require("telescope.actions")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

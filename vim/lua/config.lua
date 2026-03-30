-- Require config files
require("config.options")
require("config.filetypes")
require("config.keymaps")


require('mini.pairs').setup()
require('mini.cursorword').setup({ delay = 3150 })

require('nvim-highlight-colors').setup({})

-- local hipatterns = require('mini.hipatterns')
-- hipatterns.setup({
--   highlighters = {
--     -- Highlight hex color strings (`#rrggbb`) using that color
--     hex_color = hipatterns.gen_highlighter.hex_color(),
--   },
--})

--vim.cmd [[colorscheme catppuccin]]
--vim.cmd("colorscheme rose-pine")
--vim.cmd("colorscheme kanagawa")
--vim.cmd("colorscheme dim")
-- vim.cmd("colorscheme cyberdream")
-- require("cyberdream").setup({
--   -- Set light or dark variant
--   variant = "auto",
--   extensions = {
--     default = true,
--     base = true,
--   }
-- })

-- vim.cmd('colorscheme github_dark')
-- require('github-theme').setup({
--   options = {
--     styles = {
--       comments = 'italic',
--       keywords = 'bold',
--       types = 'italic,bold',
--     }
--   }
-- })


-- require('kanso').setup({
--     dimInactive = false,
--     foreground = {
--         dark = "saturated",
--         light = "saturated"
--     },
-- })
-- vim.cmd("colorscheme kanso")

require("lume").setup()
vim.cmd("colorscheme lume")

require("lualine").setup {
  options = {
    --theme = "catppuccin",
    theme = 'auto',
    icons_enabled = true,
  }
}


require("trouble").setup({
  position = "bottom",            -- bottom/top/left/right
  height = 12,                    -- panel height
  width = 50,                     -- if using side positions
  icons = true,
  mode = "workspace_diagnostics", -- default mode
  fold_open = "▾",
  fold_closed = "▸",
  group = true,
  padding = true,
  action_keys = {
    close = "q",
    cancel = "<esc>",
    refresh = "r",
    jump = { "<cr>", "<tab>" },
  },
  auto_open = false,          -- auto-open when diagnostics appear
  auto_close = false,         -- auto-close when clean
  use_diagnostic_signs = true -- use signs from LSP
})


local ts = require('nvim-treesitter')
ts.install({
  "c", "lua", "rust", "ruby", "python", "json", "vim", "yaml", "html",
  "css", "htmldjango", "javascript", "typescript", "query", "toml"
})

require('nvim-treesitter').setup()

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    "css", "htmldjango", "javascript", "typescript", "query", "toml", "fish",
    "csv","c", "lua", "rust", "ruby", "python", "json", "vim", "yaml", "html",
  },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "*" },
  callback = function()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require("nvim-ts-autotag").setup({
  opts = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = {
      "html", "htmldjango",
      "javascript", "typescript", "javascriptreact", "typescriptreact",
      "svelte", "vue", "tsx", "jsx", "rescript", "ts",
      "rb", "ruby", "xml", "php", "markdown", "astro",
      "glimmer", "handlebars", "hbs",
    }
  }
})

require("treesitter-context").setup({
  enable = true,
  max_lines = 0,
  trim_scope = "outer",
  min_window_height = 0,
  patterns = {
    default = { "class", "function", "method", "for", "while", "if", "switch", "case" },
    tex = { "chapter", "section", "subsection", "subsubsection" },
    rust = { "impl_item", "struct", "enum" },
    scala = { "object_definition" },
    vhdl = { "process_statement", "architecture_body", "entity_declaration" },
    markdown = { "section" },
    elixir = { "anonymous_function", "arguments", "block", "do_block", "list", "map", "tuple", "quoted_content" },
    json = { "pair" },
    yaml = { "block_mapping_pair" },
  },
  exact_patterns = {},
  zindex = 20,
  mode = "cursor",
  separator = nil,
})

--linter and formatter
vim.lsp.enable('biome')
vim.lsp.config("biome", {
  filetypes = {

    --"htmldjango", "astro", "css", "graphql", "html", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescriptreact", "vue" 
    "htmldjango", "javascript", "css", "html", "json", "jsonc"
  }

})

-- Enable toml lsp
vim.lsp.enable('taplo')

--vim.lsp.enable('luau_lsp')
--vim.lsp.enable('lua_ls')

vim.lsp.enable('tailwindcss')
vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      includeLanguages = {
        htmldjango = "html",
      },
      classAttributes = {
        "class", "className", "class:list", "classList", "ngClass",
        "extra_class", ".*className", "add_class", "extra_class="
      },
      classFunctions = { "tw", "clsx", "tw\\.[a-z-:]+" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
        usedBlocklistedClass = "warning",
        suggestCanonicalClasses = "warning",
      },
      sortSelection = true,
      codeAction = true,
      validate = true,
    }
  },
})

vim.lsp.enable("marksman")
--vim.lsp.enable("html")
--vim.lsp.config("html", { filetypes = { "html", "templ" } })
--vim.lsp.enable("superhtml")

-- local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
-- cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- vim.lsp.enable("cssls")
-- vim.lsp.config("cssls", {
--   capabilities = cssls_capabilities,
--   settings = {
--     css = { lint = { unknownAtRules = "ignore" } }
--   }
-- })

--vim.lsp.enable('pyrefly')
vim.lsp.config("ty", {
  settings = {
    ty = {
      experimental = {
        rename = true,
        autoImport = true,
      },
    },
  },
})
vim.lsp.enable('ty')

vim.lsp.enable("ruff")
vim.lsp.config("ruff", {
  init_options = {
    settings = { format = { preview = true } }
  }
})

vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", {
  settings = {
    completions = { completeFunctionCalls = true }
  }
})

vim.lsp.enable("jsonls")
vim.lsp.enable("ruby_lsp")
vim.lsp.config("ruby_lsp", {
  init_options = {
    formatter = "auto",
    linters = { "rubocop_internal", "erb_lint" },
    filetypes = { "ruby", "eruby" },
  }
})

vim.lsp.enable('herb_ls')
vim.lsp.config("herb_ls", {
  filetypes = { 'html', 'eruby', 'htmldjango' }
})

local lint = require("lint")
lint.linters_by_ft = {
  eruby = { "erb_lint" },
}
lint.linters.erb_lint = require("lint.util").wrap(lint.linters.erb_lint, function(diagnostic)
  diagnostic.severity = vim.diagnostic.severity.ERROR
  return diagnostic
end)

-- local django_settings_module = os.getenv("DJANGO_SETTINGS_MODULE") or "default.settings"
-- vim.lsp.enable("djlsp")
-- vim.lsp.config("djlsp", {
--   cmd = { "/Users/sajoku/.pyenv/shims/djlsp" },
--   init_options = { django_settings_module = django_settings_module },
-- })

-- vim.lsp.enable("rust_analyzer")
-- vim.lsp.config("rust_analyzer", {
--   settings = { ["rust-analyzer"] = {} }
-- })
--

vim.lsp.enable('djls')

--run conform on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

local blink = require("blink.cmp")
blink.setup({
  keymap = { preset = "enter" },
  cmdline = { enabled = true },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
    menu = { auto_show = true },
    ghost_text = { enabled = true },
  },
  signature = { enabled = true },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {
          prefix_min_len = 3,
          context_size = 5,
          max_filesize = "1M",
          additional_rg_options = {},
        },
      },
    },
  },
})

-- Diagnostics & LSP keymaps
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Show warning and errors on the current line
vim.diagnostic.config({
  --virtual_text = { source = "if_many", prefix = "" },
  virtual_text = { current_line = true },
  float = { source = "if_many" },
  --virtual_lines = true,
  { virtual_lines = { current_line = true }, virtual_text = true }
})

require('hlchunk').setup({
  chunk = {
    enable = true
  },
  indent = {
    enable = false
  }
})



vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Auto format on save via the LSP
-- This runs format for all file types and any lsp supporting formatting
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})


vim.keymap.set('n', 'g/', function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })
vim.keymap.set('n', '<C-p>', function() require('fff').find_files() end, { desc = 'FFFind files' })

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

require("todo-comments").setup()

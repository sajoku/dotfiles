-- Require config files
require("lua.config.options")
require("lua.config.filetypes")
require("lua.config.keymaps")

require("nvim-highlight-colors").setup {
  render = "virtual",
}
require('mini.pairs').setup()
require('mini.cursorword').setup({ delay = 650 })

require("catppuccin").setup({
  background = {
    light = "latte",
    dark = "frappe",
  },
})

-- Set initial colorscheme based on current background
if vim.o.background == 'light' then
  vim.cmd('colorscheme catppuccin-latte')
else
  vim.cmd('colorscheme catppuccin-frappe')
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    print("Changing color")
    if vim.o.background == "light" then
      vim.cmd("colorscheme catppuccin-latte")
    else
      vim.cmd("colorscheme catppuccin-frappe")
    end
  end,
})


require("lualine").setup {
  options = {
    theme = "catppuccin",
    icons_enabled = true,
  }
}

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "lua", "rust", "ruby", "python", "json", "vim", "yaml", "html",
    "css", "htmldjango", "javascript", "typescript", "query"
  },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  endwise = { enable = true },
  indent = { enable = true },
  matchup = { enable = true, disable = {} },
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

--vim.lsp.enable('luau_lsp')
vim.lsp.enable('lua_ls')

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

local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.enable("cssls")
vim.lsp.config("cssls", {
  capabilities = cssls_capabilities,
  settings = {
    css = { lint = { unknownAtRules = "ignore" } }
  }
})

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
  --virtual_text = { current_line = true },
  float = { source = "always" },
  virtual_lines = true,
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

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})

local fzf = require("fzf-lua")
fzf.setup({ { "telescope", "ivy" }, fzf_colors = { true } })

vim.keymap.set("n", "<leader>ff", fzf.files, {})
vim.keymap.set("n", "<C-p>", fzf.files, {})
vim.keymap.set("n", "<leader>fg", fzf.live_grep_native or fzf.live_grep, {})
vim.keymap.set("n", "<C-f>", fzf.live_grep_native or fzf.live_grep, {})
vim.keymap.set("n", "g/", fzf.live_grep_native or fzf.live_grep, {})
vim.keymap.set("n", "<leader>fb", fzf.buffers, {})
vim.keymap.set("n", "<leader>fh", fzf.help_tags, {})

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

require("todo-comments").setup()

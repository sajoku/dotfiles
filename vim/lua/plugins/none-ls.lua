local null_ls = require("null-ls")

-- Define a custom erblint formatter

-- local erblint = null_ls.builtins.formatting.stylua.with({
--   name = "erblint",
--   filetypes = { "eruby", "html.erb" },
--   command = "erblint",
--   args = { "--autocorrect", "--stdin", "$FILENAME" },
--   to_stdin = true,
--   from_stderr = true,
-- })

local erblint = null_ls.builtins.formatting.erb_lint.with({
  on_output = function(params, done)
    local output = params.output
    if output:find("No errors were found in ERB files") then
      return done()
    end

    local metadata_end = output:match(".*==()") + 1
    return done({ { text = output:sub(metadata_end) } })
  end,
})

-- Create a named augroup and save the ID
local formatting_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
  sources = {
    -- Linting with djlint
    null_ls.builtins.diagnostics.djlint.with({
      args = { "--lint", "-" },
      filetypes = { "htmldjango", "html" },
      to_stdin = true,
    }),

    -- Formatting with erblint
    --erblint,
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      -- Clear previous autocmds in the group
      vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = bufnr })

      -- Create the format-on-save autocmd
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatting_group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,

  flags = {
    debounce_text_changes = 250,
  },

  logging = true,
  log_level = "debug",
})

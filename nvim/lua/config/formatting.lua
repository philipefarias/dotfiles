-- Formatting and Linting Configuration
-- none-ls setup for formatters and linters

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- JavaScript/TypeScript
    null_ls.builtins.formatting.prettier,
    -- Ruby
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.diagnostics.rubocop,
  },
  -- Auto-format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

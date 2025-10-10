-- LSP Configuration
-- Mason setup for LSP servers

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { 
    "eslint",           -- JavaScript linter
    "ts_ls",            -- TypeScript/JavaScript LSP
    "ruby_lsp",         -- Ruby LSP (official)
    "solargraph",       -- Ruby language server (alternative)
    "rubocop"           -- Ruby linter/formatter
  },
  automatic_installation = true,
})

-- Get capabilities for LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common on_attach function for LSP servers
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

-- Setup LSP servers
local lspconfig = require('lspconfig')

-- TypeScript/JavaScript LSP (ts_ls is the new name for tsserver)
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- ESLint LSP
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Auto-fix on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- Ruby LSP (official Ruby LSP server)
lspconfig.ruby_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "ruby-lsp" },
  filetypes = { "ruby" },
  init_options = {
    formatter = "rubocop",
    linters = { "rubocop" },
  },
  settings = {
    rubyLsp = {
      enabledFeatures = {
        "documentSymbols",
        "documentHighlights",
        "foldingRanges",
        "selectionRanges",
        "semanticHighlighting",
        "formatting",
        "codeActions",
      },
    },
  },
})

-- Solargraph (alternative Ruby language server, good for Rails)
lspconfig.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
      hover = true,
      formatting = true,
      symbols = true,
      definitions = true,
      rename = true,
      references = true,
    },
  },
})

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
})

-- Show diagnostics in a floating window
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

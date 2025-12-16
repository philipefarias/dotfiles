-- Treesitter Configuration
-- Syntax highlighting and text objects

require('nvim-treesitter.config').setup({
  ensure_installed = { 
    -- JavaScript/Node.js
    "javascript", "json", "bash", "markdown", "yaml", "lua",
    -- Ruby/Rails
    "ruby", "embedded_template", "sql", "html", "css"
  },
  highlight = { enable = true },
  indent = { enable = true },
  -- Additional text object support
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

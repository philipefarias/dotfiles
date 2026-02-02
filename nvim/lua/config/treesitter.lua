-- Treesitter Configuration
-- Syntax highlighting and text objects

require('nvim-treesitter.config').setup({
  ensure_installed = { 
    -- Ruby/Rails
    "ruby",
    "embedded_template",  -- ERB
    
    -- JavaScript/TypeScript/React
    "javascript",
    "typescript",
    "tsx",
    "jsdoc",
    
    -- Web (HTML/CSS)
    "html",
    "css",
    "scss",
    
    -- Data formats
    "json",
    "jsonc",              -- JSON with comments (VS Code configs)
    "yaml",
    "toml",
    "sql",
    
    -- Shell/Scripts
    "bash",
    
    -- Config files
    "dockerfile",
    "vim",
    "vimdoc",
    "lua",
    "luadoc",
    "regex",
    "query",              -- Treesitter queries
    
    -- Git
    "git_config",
    "gitcommit",
    "gitignore",
    "diff",
    
    -- Documentation
    "markdown",
    "markdown_inline",
  },
  highlight = { enable = true },
  indent = { enable = true },
  -- Text objects temporarily disabled due to plugin incompatibility
  -- Re-enable when nvim-treesitter-textobjects is updated
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     lookahead = true,
  --     keymaps = {
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --     },
  --   },
  -- },
})

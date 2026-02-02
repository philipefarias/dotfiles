-- Treesitter Configuration
-- Syntax highlighting and text objects

require('nvim-treesitter.config').setup({
  -- Auto-install missing parsers when entering a buffer
  auto_install = true,
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
})

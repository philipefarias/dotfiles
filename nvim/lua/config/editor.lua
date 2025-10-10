-- Editor Enhancements Configuration
-- Autopairs, comments, and which-key

-- Auto pairs
require('nvim-autopairs').setup({})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- Comment.nvim
require('Comment').setup()

-- which-key.nvim
require('which-key').setup({
  preset = 'modern',
  delay = 500,
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,    -- adds help for operators like d, y, c
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  win = {
    border = 'rounded',
    padding = { 1, 2 },
  },
})

-- Define key groups
local wk = require("which-key")
wk.add({
  -- Test commands
  { "<leader>t", desc = "Test nearest" },
  { "<leader>T", desc = "Test file" },
  { "<leader>a", desc = "Test suite" },
  { "<leader>l", desc = "Test last" },
  { "<leader>g", desc = "Test visit" },
  
  -- LSP commands
  { "<leader>d", desc = "Show diagnostics" },
  { "<leader>rn", desc = "Rename symbol" },
  { "<leader>ca", desc = "Code actions" },
  { "gd", desc = "Go to definition" },
  { "gr", desc = "Find references" },
  { "gi", desc = "Go to implementation" },
  { "K", desc = "Hover documentation" },
  { "[d", desc = "Previous diagnostic" },
  { "]d", desc = "Next diagnostic" },
  
  -- Rails navigation
  { "<leader>r", group = "Rails" },
  { "<leader>rc", desc = "Go to Controller" },
  { "<leader>rm", desc = "Go to Model" },
  { "<leader>rv", desc = "Go to View" },
  { "<leader>rs", desc = "Go to Spec" },
  { "<leader>rf", desc = "Go to Factory" },
  { "<leader>rC", desc = "Go to Controller (split)" },
  { "<leader>rM", desc = "Go to Model (split)" },
  { "<leader>rV", desc = "Go to View (split)" },
  { "<leader>rS", desc = "Go to Spec (split)" },
  { "<leader>rt", desc = "Run nearest test" },
  { "<leader>ra", desc = "Run all tests" },
  { "<leader>rl", desc = "Run last test" },
  
  -- FZF commands
  { "<leader><tab>", desc = "FZF mappings" },
  { "<C-x><C-k>", mode = "i", desc = "Complete word" },
  { "<C-x><C-f>", mode = "i", desc = "Complete path" },
  { "<C-x><C-l>", mode = "i", desc = "Complete line" },
  
  -- ALE navigation
  { "<C-k>", desc = "Previous error/warning" },
  { "<C-j>", desc = "Next error/warning" },
  
  -- Git commands (vim-fugitive)
  { ":Git", desc = "Git status" },
  { ":Git blame", desc = "Git blame" },
  { ":Git diff", desc = "Git diff" },
  { ":Git log", desc = "Git log" },
  { ":Git commit", desc = "Git commit" },
  { ":Git push", desc = "Git push" },
  { ":Git pull", desc = "Git pull" },
  { ":Gread", desc = "Git checkout file" },
  { ":Gwrite", desc = "Git add file" },
  { ":Gdiffsplit", desc = "Git diff split" },
  
  -- LocalLeader commands
  { "<LocalLeader>r", group = "Reload/Edit" },
  { "<LocalLeader>rs", desc = "Reload vimrc" },
  { "<LocalLeader>rt", desc = "Edit vimrc (tab)" },
  { "<LocalLeader>re", desc = "Edit vimrc" },
  { "<LocalLeader>rd", desc = "Open .vim directory" },
  { "<LocalLeader>[", desc = "Previous tab" },
  { "<LocalLeader>]", desc = "Next tab" },
})

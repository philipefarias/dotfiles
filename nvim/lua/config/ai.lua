-- AI Assistants Configuration
-- Claude Code bridge. Experimental: start Neovim with NVIM_AI=0 to skip it.

if vim.env.NVIM_AI == '0' then
  return
end

local wk = require('which-key')

-- Claude Code (coder/claudecode.nvim)
-- Run `claude` in a tmux pane from the same project, then `/ide` to connect.
-- Edits Claude proposes open here as diffs to accept or deny.
-- Set provider to 'native' to run Claude in a Neovim split instead.
local claude_ok, claudecode = pcall(require, 'claudecode')
if claude_ok then
  claudecode.setup({
    terminal = { provider = 'none' },
    log_level = 'warn',
  })

  vim.keymap.set('v', '<leader>cs', '<cmd>ClaudeCodeSend<CR>', { desc = 'Send selection to Claude' })
  vim.keymap.set('n', '<leader>cb', '<cmd>ClaudeCodeAdd %<CR>', { desc = 'Add buffer to Claude' })
  vim.keymap.set('n', '<leader>ca', '<cmd>ClaudeCodeDiffAccept<CR>', { desc = 'Accept Claude diff' })
  vim.keymap.set('n', '<leader>cd', '<cmd>ClaudeCodeDiffDeny<CR>', { desc = 'Deny Claude diff' })

  wk.add({
    { '<leader>c', group = 'Claude' },
  })
end

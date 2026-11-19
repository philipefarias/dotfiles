-- AI Assistants Configuration
-- Claude Code bridge and Copilot suggestions.
-- Experimental: start Neovim with NVIM_AI=0 to skip both.

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

-- Copilot (zbirenbaum/copilot.lua)
-- Ghost-text suggestions in insert mode: <M-l> accept, <M-]>/<M-[> cycle,
-- <C-]> dismiss. Run :Copilot auth once. Uses the plugin's native server,
-- so it needs no Node. Set up on first InsertEnter to keep startup fast.
local secret_patterns = { '^%.env', '%.key$', '%.pem$', 'credentials' }

local function copilot_should_attach(bufnr, bufname)
  if not vim.bo[bufnr].buflisted or vim.bo[bufnr].buftype ~= '' then
    return false
  end
  local name = vim.fs.basename(bufname)
  for _, pattern in ipairs(secret_patterns) do
    if name:find(pattern) then
      return false
    end
  end
  return true
end

vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = function()
    local copilot_ok, copilot = pcall(require, 'copilot')
    if not copilot_ok then
      return
    end
    copilot.setup({
      suggestion = { auto_trigger = true },
      panel = { enabled = false },
      should_attach = copilot_should_attach,
    })
  end,
})

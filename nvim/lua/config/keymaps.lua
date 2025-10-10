-- Additional Keymaps Configuration
-- Rails and RSpec specific keymaps

-- Rails-specific settings and keymappings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    
    -- Set up Rails-specific keymaps if vim-rails is present
    if vim.fn.exists(':Rails') == 2 then
      -- Navigate to related files
      vim.keymap.set('n', '<leader>rc', ':Econtroller<CR>', { buffer = true, desc = 'Go to Controller' })
      vim.keymap.set('n', '<leader>rm', ':Emodel<CR>', { buffer = true, desc = 'Go to Model' })
      vim.keymap.set('n', '<leader>rv', ':Eview<CR>', { buffer = true, desc = 'Go to View' })
      vim.keymap.set('n', '<leader>rs', ':Espec<CR>', { buffer = true, desc = 'Go to Spec' })
      vim.keymap.set('n', '<leader>rf', ':Efactory<CR>', { buffer = true, desc = 'Go to Factory' })
      
      -- Vertical split versions
      vim.keymap.set('n', '<leader>rC', ':Vcontroller<CR>', { buffer = true, desc = 'Go to Controller (split)' })
      vim.keymap.set('n', '<leader>rM', ':Vmodel<CR>', { buffer = true, desc = 'Go to Model (split)' })
      vim.keymap.set('n', '<leader>rV', ':Vview<CR>', { buffer = true, desc = 'Go to View (split)' })
      vim.keymap.set('n', '<leader>rS', ':Vspec<CR>', { buffer = true, desc = 'Go to Spec (split)' })
    end
  end,
})

-- RSpec integration (works with vim-test)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    -- Quick RSpec commands
    vim.keymap.set('n', '<leader>rt', ':TestNearest<CR>', { buffer = true, desc = 'Run nearest test' })
    vim.keymap.set('n', '<leader>rf', ':TestFile<CR>', { buffer = true, desc = 'Run test file' })
    vim.keymap.set('n', '<leader>ra', ':TestSuite<CR>', { buffer = true, desc = 'Run all tests' })
    vim.keymap.set('n', '<leader>rl', ':TestLast<CR>', { buffer = true, desc = 'Run last test' })
  end,
})

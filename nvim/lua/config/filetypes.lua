-- Filetype Detection Configuration
-- Custom filetype mappings for dotfiles without extensions

vim.filetype.add({
  filename = {
    ['gitconfig'] = 'gitconfig',
    ['gitignore_global'] = 'gitignore',
    ['gitmessage'] = 'gitcommit',
    ['gittheme'] = 'gitconfig',
  },
})

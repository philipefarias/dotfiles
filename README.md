# Dotfiles

Personal development environment configuration for Vim/Neovim, Tmux, and Bash on macOS and Linux.

## Features

- **Neovim/Vim**: LSP support (JavaScript/TypeScript, Ruby/Rails), autocompletion, Treesitter syntax
- **Tmux**: Terminal multiplexer with plugin management
- **Bash**: Optimized shell with git prompt and completions
- **Git**: Aliases, signed commits, custom workflow

## Requirements

- macOS (Apple Silicon/Intel) or modern Linux
- Bash 4+
- Git 2.0+
- Homebrew (macOS) or equivalent package manager

## Installation

```bash
git clone https://github.com/philipefarias/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The install script will:

- Create symlinks for all config files
- Set up Vim/Neovim with vim-plug
- Configure Tmux with TPM (Tmux Plugin Manager)
- Create necessary directories

## Personal Configuration

Create `~/.gitconfig.local` for personal Git settings:

```ini
[user]
    name = Your Name
    email = your.email@example.com
    signingkey = YOUR_GPG_KEY
[credential "https://github.com"]
    username = yourusername
```

## Key Bindings

### Vim/Neovim

- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>rc/rm/rv/rs/rf` - Rails navigation (controller/model/view/spec/factory)

### Tmux

- `Ctrl-a` - Prefix key
- `Ctrl-a |` - Split vertically
- `Ctrl-a -` - Split horizontally
- `Ctrl-a r` - Reload config

## Structure

```text
.
├── vimrc                 # Vim/Neovim configuration
├── tmux.conf             # Tmux configuration
├── bashrc                # Bash shell configuration
├── bash_profile          # Bash login configuration
├── gitconfig             # Git configuration (generic)
├── gitignore_global      # Global gitignore patterns
├── gitmessage            # Commit message template
├── install               # Installation script
└── bin/                  # Custom scripts
    ├── docker-clean      # Docker cleanup utility
    ├── git-both-merged   # Show merged branches
    └── replace           # Find and replace with ripgrep
```

## Updating

Pull latest changes and re-run install:

```bash
cd ~/.dotfiles
git pull
./install
```

For Vim plugins: `:PlugUpdate` in Vim/Neovim  
For Tmux plugins: `<prefix> + I` in Tmux

## Customization

Configuration files use conditional logic for cross-platform compatibility. Edit files directly or override in local configs:

- Bash: Add to `~/.bash_profile.local` or `~/.bashrc.local`
- Git: Add to `~/.gitconfig.local`

## License

MIT

# Dotfiles

Personal development environment configuration for Vim/Neovim, Tmux, and Bash on macOS and Linux.

## Features

- **Neovim/Vim**: LSP support (JavaScript/TypeScript, Ruby/Rails), autocompletion, Treesitter syntax
- **Tmux**: Terminal multiplexer with plugin management
- **Bash**: Optimized shell with git prompt and completions
- **Git**: Aliases, signed commits, custom workflow

## Requirements

- macOS (Apple Silicon/Intel) or modern Linux
- Bash 5+
- Git 2+
- Homebrew (macOS) or equivalent package manager

## Installation

### Quick Start

```bash
git clone https://github.com/philipefarias/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
brew bundle install  # Install dependencies (macOS)
./install            # Link dotfiles and setup plugins
```

### What Gets Installed

**Brewfile** installs:

- Shell: bash, bash-completion, bash-git-prompt, tmux
- Editor: neovim
- Modern CLI tools: bat (cat), eza (ls), fd (find), zoxide (smart cd), ripgrep, fzf
- Data tools: jq (JSON), yq (YAML)
- Utilities: btop (process viewer), tldr (man pages), httpie (HTTP client)
- Development: git, git-delta, asdf
- Security: gnupg, pinentry-mac
- Font: Fira Code Nerd Font

**install script**:

- Creates symlinks for all config files
- Sets up Vim/Neovim with vim-plug
- Configures Tmux with TPM (Tmux Plugin Manager)
- Creates necessary directories

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

Type `?` in your terminal for a comprehensive keybinding reference covering Bash, Git, Tmux, and Vim/Neovim.

### Quick Reference

**Vim/Neovim:**

- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>rc/rm/rv/rs/rf` - Rails navigation (controller/model/view/spec/factory)

**Tmux:**

- `Ctrl-a` - Prefix key
- `Ctrl-a |` - Split vertically
- `Ctrl-a -` - Split horizontally
- `Ctrl-a r` - Reload config

## Modern CLI Tools

These tools are aliased to replace standard commands:

- `cat` → **bat** - Syntax highlighting, git integration, line numbers
- `ls` → **eza** - Better colors, git status, icons
- `find` → **fd** - Simpler syntax, respects .gitignore
- `cd` → **z** (zoxide) - Jump to frequent directories (e.g., `z dotfiles`)
- `curl` → **httpie** - Human-friendly HTTP client with `http` command

Additional utilities:

- **jq/yq** - Process JSON/YAML (`cat file.json | jq '.key'`)
- **tldr** - Quick command examples (`tldr tar`)
- **btop** - Beautiful system monitor
- **fzf+fd** - Fuzzy file search with smart defaults

## Structure

```text
.
├── Brewfile              # Homebrew dependencies
├── vimrc                 # Vim/Neovim configuration
├── tmux.conf             # Tmux configuration
├── bashrc                # Bash shell configuration
├── bash_profile          # Bash login configuration
├── gitconfig             # Git configuration (generic)
├── gitignore_global      # Global gitignore patterns
├── gitmessage            # Commit message template
├── install               # Installation script
└── bin/                  # Custom scripts
    ├── ?                 # Quick keybinding reference
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

Update components:

- **Vim plugins**: `:PlugUpdate` in Neovim
- **LSP servers**: `:MasonUpdate` in Neovim
- **Treesitter parsers**: `:TSUpdate` in Neovim
- **Tmux plugins**: `<prefix> + U` in Tmux (or `<prefix> + I` to install new plugins)

**Note**: On first launch, Neovim automatically installs configured LSP servers (Mason) and syntax parsers (Treesitter) based on your `vimrc` settings.

## Customization

Configuration files use conditional logic for cross-platform compatibility. Edit files directly or override in local configs:

- Bash: Add to `~/.bash_profile.local` or `~/.bashrc.local`
- Git: Add to `~/.gitconfig.local`

## License

MIT

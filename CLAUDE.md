# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup Commands

```bash
brew bundle install          # Install all Homebrew dependencies
./install                    # Symlink dotfiles, install vim-plug plugins, setup TPM
```

After changes: re-run `./install` to re-link. For Neovim plugin updates: `:PlugUpdate`, `:TSUpdate`, `:MasonUpdate`.

## Architecture

This is a personal dotfiles repo for macOS (Apple Silicon/Intel) and Linux. The `install` script symlinks config files to `$HOME` (prefixed with `.`) and links `bin/` scripts to `~/.bin/`.

### Vim/Neovim Dual Setup

`vimrc` is the single entry point for both Vim and Neovim. It uses `has('nvim')` / `!has('nvim')` guards throughout to conditionally load features:
- Vim gets vim-polyglot for language support, matchit.vim, and manual settings that Neovim sets by default
- Neovim loads Lua modules from `nvim/lua/config/` at the bottom of vimrc via an inline `lua << EOF` block

The install script symlinks `~/.vim` to `~/.config/nvim` and `~/.vimrc` to `~/.config/nvim/init.vim`, so both editors share the same plugin directory and vimrc.

### Neovim Lua Modules (`nvim/lua/config/`)

Each module is loaded explicitly in the vimrc lua block — order matters:
1. `filetypes.lua` — custom filetype detection for extensionless dotfiles
2. `treesitter.lua` — parser list and highlight/indent config
3. `editor.lua` — autopairs, Comment.nvim, which-key setup and key group definitions
4. `keymaps.lua` — Rails navigation and RSpec keymaps (buffer-local, set via FileType autocmd)

### Key Conventions

- **Theme**: Dracula everywhere (Vim, airline, bat, tmux via tmuxline)
- **Plugin manager**: vim-plug (Vim/Neovim), TPM (tmux)
- **Linting**: ALE with LSP disabled (`ale_disable_lsp = 1`) — LSP is handled separately
- **Testing**: vim-test + neoterm (runs tests in background terminal)
- **Search**: ripgrep powers both shell (`rg`) and Vim (`:Ack` via ack.vim)
- **Tmux prefix**: `Ctrl-a`
- **Git commits**: GPG-signed by default, template in `gitmessage` (50-char subject, 72-char body wrap)
- **Git config**: `gitconfig` is generic; personal settings go in `~/.gitconfig.local` (included via `[include]`)
- **Shell aliases**: modern CLI tools (bat, eza, fd, zoxide) replace standard commands when available, with graceful fallbacks

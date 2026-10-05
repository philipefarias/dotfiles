# AGENTS.md

Working notes for anyone, human or automated, changing this repository. See
README.md for installation, key bindings, and the tools it sets up; this file
covers how to change it.

Personal dotfiles for a terminal-only setup on macOS (Apple Silicon and Intel)
and Linux: Bash, Vim/Neovim, tmux, and Git.

## Commands

| Task | Command | Notes |
|---|---|---|
| Install dependencies | `brew bundle install` | Reads `Brewfile` |
| Link dotfiles | `./install` | Idempotent (`ln -sf`); safe to re-run after any change |
| Shell syntax | `bash -n bashrc && bash -n install` | |
| Shell lint | `shellcheck bin/* install` | If shellcheck is installed |
| Editor health | `nvim --headless +qa` | Must exit 0 with no error output; `:checkhealth` for detail |
| Plugin updates | `:PlugUpdate`, `:TSUpdate` | From inside Neovim |

There is no test suite. A change is ready when the relevant checks above pass
and the affected tool starts cleanly: open a new shell, start Neovim, or
reload tmux.

## Layout

| Path | Purpose |
|---|---|
| `install` | Symlinks each dotfile to `$HOME` (prefixed with `.`), links `bin/` to `~/.bin/`, installs vim-plug and TPM. Source of truth for what gets linked |
| `bashrc` | Env vars, PATH, aliases, completions, prompt, tool init |
| `bash_profile` | Login shell; sources `bashrc` |
| `vimrc` | Single entry point for both Vim and Neovim |
| `nvim/lua/config/` | Neovim-only Lua modules |
| `tmux.conf` | tmux config, plugins via TPM |
| `gitconfig` | Generic Git settings; includes `~/.gitconfig.local` |
| `gitignore_global`, `gitmessage`, `gittheme` | Global ignores, commit template, diff colors |
| `Brewfile` | Homebrew dependencies |
| `bin/` | Custom scripts, linked to `~/.bin/` |
| `claude/` | Claude Code global instructions (`CLAUDE.md`), linked into `~/.claude/`. `~/.claude/settings.json` is not tracked: Claude Code rewrites it in place and it holds machine-specific data |

### Vim and Neovim share one config

`install` links `~/.vim` to `~/.config/nvim` and `~/.vimrc` to
`~/.config/nvim/init.vim`, so both editors share `vimrc` and the plugin
directory. `vimrc` uses `has('nvim')` / `!has('nvim')` guards throughout:

- Vim gets vim-polyglot, matchit, and settings Neovim sets by default.
- Neovim loads Lua modules from an inline `lua << EOF` block at the bottom of
  `vimrc`. Load order matters:
  1. `filetypes.lua` — filetype detection for extensionless dotfiles
  2. `treesitter.lua` — parser list, highlight and indent config
  3. `editor.lua` — autopairs, Comment.nvim, which-key and its key groups
  4. `keymaps.lua` — Rails navigation and RSpec keymaps, buffer-local via
     FileType autocmds

## Conventions

- **Dracula everywhere**: Vim, airline, bat (`BAT_THEME`), tmux via tmuxline.
- **Plugin managers**: vim-plug for Vim/Neovim, TPM for tmux.
- **Linting**: ALE, with its LSP integration off (`ale_disable_lsp = 1`). There
  is no LSP client, completion, or formatter setup; those plugins were removed.
- **Testing in the editor**: vim-test + neoterm, running in a background terminal.
- **Search**: ripgrep for both the shell (`rg`) and Vim (`:Ack`).
- **tmux prefix**: `C-a`.
- **Leader key**: `\` (the default). Rails navigation under `<leader>r`
  (`rc` controller, `rm` model, `rv` view, `rs` spec, `rf` factory).
- **Graceful fallbacks**: aliases that replace standard commands (bat, eza, fd,
  zoxide) check `command -v` first and keep the fallback.
- **Cross-platform**: `bashrc` uses `uname` checks for macOS vs Linux and
  `/opt/homebrew` vs `/usr/local`. Keep the guards; never hard-code one path.
- **Git config is generic**: identity, signing key, credential helpers, and
  machine-specific paths go in `~/.gitconfig.local`, never in `gitconfig`.

## How to make common changes

- **Vim/Neovim plugin**: add the `Plug` line to the right group in `vimrc`.
  Neovim-only config goes in a `nvim/lua/config/` module; Vim-only config inside
  `if !has('nvim')`. Settings that must apply after load go after `plug#end()`.
  A new module needs its `require` added to the `vimrc` Lua block in load order.
  Run `:PlugInstall`.
- **New dotfile**: create it at the repo root and add it to the `for file in`
  loop in `install`.
- **Shell tool or alias**: add it to the matching `bashrc` section, guard it
  with `command -v`, and add its package to `Brewfile`. A startup hook must
  stay silent when the tool is installed but broken.
- **Script**: create it in `bin/` with `#!/usr/bin/env bash`, `chmod +x`, then
  run `./install`.
- **Git alias**: add it under `[alias]` in `gitconfig`, matching existing style.
- **tmux binding**: add it to `tmux.conf` with a comment, clear of the `C-a`
  prefix and existing bindings; plugin lines go before the TPM `run` line.

Before removing a plugin, check what else depends on it; before adding one,
check nothing already installed covers the same job. Keep the tmux/Vim
integration (pane navigation, copy and paste) working.

Style: two-space indentation in Vimscript and Lua, double-quote comments in
Vimscript, alphabetical order where a file already uses it. Keep comments short
and free of company or project names.

## Committing

Changes land directly on `master` and are pushed to `origin`. There are no
pull requests and no CI, so run the checks above before committing.

- **Atomic**: one logical change per commit.
- **Signed**: `commit.gpgsign = true`. Signing uses an SSH key
  (`gpg.format = ssh`), configured per machine in `~/.gitconfig.local`; do
  not bypass it.
- **Subject**: imperative mood, under 50 characters, no conventional-commit
  prefixes (`feat:`, `fix:`). Common verbs: Add, Remove, Replace, Change, Fix,
  Update, Set, Use, Organize, Refactor.
- **Body**: optional, wrapped at 72. Use it when the why isn't obvious from the
  subject: rationale, compatibility issues, scope of a refactor.

```
Replace null-ls.nvim for none-ls.nvim

null-ls.nvim is archived and incompatible with Neovim 0.11.
none-ls.nvim is a maintained fork with the same API.
```

Never commit secrets (keys, tokens, `.gpg` files), work-specific config
(company names, internal URLs, work email), local state, caches, or
`.tool-versions`.

## Gotchas

- **A broken shell**: start `bash --norc`, then `source ~/.bashrc` to see the
  error.
- **Neovim won't start after a plugin change**: check `:messages`, or comment
  out the failing module's `require` in `vimrc` to isolate it.
- **`command -v` does not prove a tool works**: a pipx or venv shim whose Python
  was removed by a Homebrew upgrade still resolves, then fails with
  `bad interpreter` on every new shell.
- **`gitignore_global` ignores `AGENTS.md` and `CLAUDE.md` everywhere**; this
  repo's `.gitignore` re-includes `AGENTS.md` so it can be tracked here.
- **GUI-only settings don't belong here**: this setup is terminal-only.

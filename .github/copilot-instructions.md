# Copilot Instructions

## Project Context
Personal dotfiles for Vim/Neovim + Tmux development environment with Git version control.

## Configuration Files
- `vimrc` - Neovim/Vim configuration with LSP, completion, and language support
- `tmux.conf` - Tmux terminal multiplexer settings
- `bashrc`, `bash_profile` - Shell configuration
- `gitconfig` - Git settings (personal info in `~/.gitconfig.local`, not tracked)
- `gitignore_global`, `gitmessage` - Git ignore patterns and commit template
- `bin/` - Custom shell scripts and utilities

**Note**: Personal Git configuration (user name, email, signing key, credentials) is stored in `~/.gitconfig.local` which is included but not tracked in this repository.

## Development Stack
- **Editor**: Neovim with vim-plug plugin manager and Lua configuration
- **Languages**: JavaScript/TypeScript, Ruby/Rails, with LSP support (ts_ls, eslint, ruby_lsp, solargraph)
- **Tools**: Mason (LSP installer), Treesitter (syntax), nvim-cmp (completion), none-ls (formatting/linting)
- **Shell**: Bash (preferred shell)
- **VCS**: Git only

## Code Style Guidelines
- **Documentation**: Keep all documentation, comments, and explanations concise - no fluff, only essential information
- **Vimscript**: Use double quotes for comments, maintain existing indentation (2 spaces)
- **Lua blocks**: Indent with 2 spaces, use descriptive variable names
- **Bash scripts**: Follow existing bin/ script patterns, use `#!/usr/bin/env bash` shebang, include comments
- **Config files**: Maintain alphabetical ordering where applicable, group related settings

## When Editing Configuration
- Always preserve existing plugin organization and grouping
- Test LSP/plugin changes don't break compatibility with Neovim 0.10+
- Keep comments concise and descriptive, avoid project-specific references
- Maintain backward compatibility with non-Neovim Vim where possible (check `has('nvim')`)
- Use absolute paths in documentation, relative paths in config

## Common Tasks
- Adding plugins: Insert in appropriate group in `vimrc`, run `:PlugInstall`
- LSP servers: Add to Mason `ensure_installed`, configure with `lspconfig.setup()`
- Git aliases: Add to `gitconfig` under `[alias]` section
- Git interactive rebase: Use `GIT_SEQUENCE_EDITOR` with `sed` for automated rebase operations
- Tmux bindings: Add to `tmux.conf`, prefix existing bindings with comments
- Bash utilities: Create in `bin/` with executable permissions, use bash-specific syntax

## Key Mappings Convention
- Leader key: `\` (default, not explicitly set)
- Rails navigation: `<leader>r` prefix (rc=controller, rm=model, rv=view, rs=spec, rf=factory)
- Diagnostics: `[d`, `]d` (previous/next), `<leader>d` (float)
- LSP: `gd` (definition), `gr` (references), `K` (hover), `<leader>rn` (rename), `<leader>ca` (code actions)

## Commit Message Pattern
**CRITICAL: Commits must be atomic** - each commit should contain one logical change that can stand alone.

**CRITICAL: All commits must be GPG signed** - ensure `commit.gpgsign = true` is set and your GPG key is valid.

Use imperative mood with action verbs. Keep subject line under 50 characters. Add a short description (1-2 lines) when the change benefits from additional context.

**Format:**
```
Subject line (imperative, <50 chars)

Optional short description providing context or rationale.
Use when the "why" isn't obvious from the subject alone.
```

**Common patterns:**
- `Add <component>` - New features, plugins, configs, scripts
- `Remove <component>` - Delete unused/redundant features
- `Replace <old> for <new>` - Swap implementations
- `Change <component>` - Modify existing behavior
- `Fix <issue>` - Bug fixes and corrections
- `Update <component>` - Version bumps, refresh configs
- `Set <setting>` - Configuration changes
- `Use <tool/approach>` - Switch to different tool/method
- `Organize <area>` - Restructure without functionality change
- `Refactor <component>` - Improve code structure without changing behavior

**Examples:**
```
Add vim plugin nvim-treesitter/nvim-treesitter

Remove redundant tmux configuration

Replace null-ls.nvim for none-ls.nvim

null-ls.nvim is archived and incompatible with Neovim 0.11.
none-ls.nvim is a maintained fork with the same API.

Fix dracula colors inside tmux

Set bash globstar option

Refactor ? script following bash best practices

Applies DRY principle with reusable functions and constants.
Uses set -euo pipefail for better error handling.
```

**When to add description:**
- Explaining rationale for architectural decisions
- Documenting compatibility issues or breaking changes
- Providing context for non-obvious fixes
- Clarifying scope of refactoring changes
- Not needed for self-explanatory changes (most commits)

## What NOT to Commit
- Secrets: API keys, tokens, passwords, private SSH/GPG keys, certificates
- Personal files: `.gpg` files, work-specific configs
- Work-specific: Company names, internal URLs, VPN configs, work email addresses
- Temporary: Local state, cache directories, backup files, `.tool-versions`
- Binary/Generated: Logs, compiled files (except custom scripts in `bin/`)

## Don't
- Reference specific company/project names in configs or comments
- Remove existing plugins without understanding dependencies
- Add GUI-only settings (this is terminal-only setup)
- Suggest plugins that duplicate existing functionality
- Break Tmux/Vim integration (copy/paste, navigation)
- Use conventional commit prefixes (feat:, fix:, chore:) - use simple imperative verbs instead

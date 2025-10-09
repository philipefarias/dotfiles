""
"" Basic Setup
""

set number                 " Show line numbers
set ruler                  " Show line and column number
set cursorline             " Highlight the line the cursor is on
set showcmd                " Show incomplete cmds at the bottom
set ttimeout               " activate timeout feature
set ttimeoutlen=100        " decrease timeout for faster insert with 'O'
set updatetime=250         " Decrease time for faster gitgutter refresh
set clipboard+=unnamedplus " use the clipboard for all operations
set noshowmode             " Don't show vim mode below the statusline

" Settings that aren't needed by neovim (usually they are set by default)
if !has('nvim')
  " Use Vim settings, rather then Vi settings. This setting must be as early
  " as possible, as it has side effects.
  set nocompatible

  set encoding=utf-8 " Set default encoding to UTF-8
  set laststatus=2   " Always show the status bar

  " Switch syntax highlighting on, when the terminal has colors
  " Also switch on highlighting the last used search pattern.
  if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
  endif
end

""
"" Plugins and Macros
""

" Initialize plug.vim
call plug#begin('~/.vim/plugged')

" Language support - general
Plug 'sheerun/vim-polyglot'

" LSP and language server support
Plug 'neovim/nvim-lspconfig'                      " LSP configuration
Plug 'williamboman/mason.nvim'                    " LSP server installer
Plug 'williamboman/mason-lspconfig.nvim'          " Bridge mason and lspconfig

" Autocompletion
Plug 'hrsh7th/nvim-cmp'                           " Completion engine
Plug 'hrsh7th/cmp-nvim-lsp'                       " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'                         " Buffer completions
Plug 'hrsh7th/cmp-path'                           " Path completions
Plug 'L3MON4D3/LuaSnip'                           " Snippet engine
Plug 'saadparwaiz1/cmp_luasnip'                   " Snippet completions

" Formatting and linting
Plug 'nvimtools/none-ls.nvim'                     " Formatter/linter integration
Plug 'nvim-lua/plenary.nvim'                      " Required by none-ls

" Syntax highlighting and code intelligence
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Advanced syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter-textobjects' " Additional textobjects

" Code editing helpers
Plug 'windwp/nvim-autopairs'                      " Auto close brackets
Plug 'numToStr/Comment.nvim'                      " Better commenting

" Ruby and Rails
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rails'
Plug 'sunaku/vim-ruby-minitest'

" Markdown and writing
Plug 'reedes/vim-pencil'

" Helpers and tooling
Plug 'janko-m/vim-test'
Plug 'kassio/neoterm'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'zaiste/tmux.vim'
Plug 'sickill/vim-pasta'
Plug 'godlygeek/tabular'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Color schemes and some bling
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" All of your Plugins must be added before the following line
call plug#end()

" % to bounce from do to end etc.
runtime macros/matchit.vim


""
"" Plugins configs
""

let g:airline_theme='dracula'
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1
let g:tmuxline_powerline_separators = 0

" Use ripgrep for faster searches if installed
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  " Use ripgrep over Grep
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

  let g:ackprg = 'rg --vimgrep --smart-case --hidden --follow'
  cnoreabbrev rg Ack
  cnoreabbrev rG Ack
  cnoreabbrev Rg Ack
  cnoreabbrev RG Ack
endif

" use postgres syntax as default for sql
let g:sql_type_default = 'pgsql'

" configure vim-test and neoterm
if has("nvim")
  let g:test#strategy = 'neoterm'
  let g:neoterm_shell = 'bash'
  let g:neoterm_run_tests_bg = 1
endif


""
"" Whitespace
""

set nowrap       " don't wrap lines
set tabstop=2    " a tab is two spaces
set shiftwidth=2 " an autoindent (with <<) is two spaces
set expandtab    " use spaces, not tabs
set list         " Show invisible characters

" List chars
set listchars=""                      " Reset the listchars
set listchars+=tab:▸\ ,trail:⋅,nbsp:⋅ " Display tabs and trailing spaces
"set listchars+=eol:¬                  " Display end-of-line
set listchars+=extends:»              " The character to show in the last column when wrap is
                                      " off and the line continues beyond the right of the screen
set listchars+=precedes:«             " The character to show in the last column when wrap is
                                      " off and the line continues beyond the right of the screen

if !has('nvim')
  set backspace=indent,eol,start " backspace through everything in insert mode
end


""
"" Searching
""

set ignorecase " searches are case insensitive...
set smartcase  " ... unless they contain at least one capital letter

if !has('nvim')
  set hlsearch  " highlight matches
  set incsearch " incremental searching
end


""
"" Theme
""

if exists('$TMUX')
  let g:dracula_italic=0
  let g:dracula_colorterm = 0
endif

silent! colors dracula


""
"" Wild settings
""

" At command line, complete longest common command, then list alternatives
set wildmode=longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=vendor/gems/*,vendor/cache/*,.bundle/*,.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*


""
"" Backup and swap files
""

set backupdir=~/.vim/backup//   " where to put backup files.
set directory=~/.vim/swap//      " where to put swap files.


""
"" AutoCommands
""

if has("autocmd")
  if has("gui_running")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif

  " Set *.template.yaml as AWS CloudFormation files
  au BufRead,BufNewFile template.yaml set filetype=yaml.cloudformation

  " Turn on language specific omnifuncs
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
endif


"""
""" Key Mappings
"""

" Reload and edit vimrc
nnoremap <silent> <LocalLeader>rs :source ~/.vimrc<CR>
nnoremap <silent> <LocalLeader>rt :tabnew ~/.dotfiles/vimrc<CR>
nnoremap <silent> <LocalLeader>re :e ~/.dotfiles/vimrc<CR>
nnoremap <silent> <LocalLeader>rd :e ~/.vim/ <CR>

" Tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>

" vim-test mappings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" ALE mappings to navigate between warnings and errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" "
" FZF
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

"""
""" Neovim Lua Configuration (for JavaScript/Node.js development)
"""

if has('nvim')
lua << EOF
-- Suppress deprecation warnings until the new API is stable
vim.deprecate = function() end

-- Mason setup for LSP servers
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { 
    "eslint",           -- JavaScript linter
    "ts_ls",            -- TypeScript/JavaScript LSP
    "ruby_lsp",         -- Ruby LSP (official)
    "solargraph",       -- Ruby language server (alternative)
    "rubocop"           -- Ruby linter/formatter
  },
  automatic_installation = true,
})

-- Get capabilities for LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common on_attach function for LSP servers
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

-- Setup LSP servers manually (compatible with older mason-lspconfig)
local lspconfig = require('lspconfig')

-- TypeScript/JavaScript LSP (ts_ls is the new name for tsserver)
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- ESLint LSP
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Auto-fix on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- Ruby LSP (official Ruby LSP server)
lspconfig.ruby_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "ruby-lsp" },
  filetypes = { "ruby" },
  init_options = {
    formatter = "rubocop",
    linters = { "rubocop" },
  },
  settings = {
    rubyLsp = {
      enabledFeatures = {
        "documentSymbols",
        "documentHighlights",
        "foldingRanges",
        "selectionRanges",
        "semanticHighlighting",
        "formatting",
        "codeActions",
      },
    },
  },
})

-- Solargraph (alternative Ruby language server, good for Rails)
-- Comment this out if you prefer ruby_lsp only
lspconfig.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
      hover = true,
      formatting = true,
      symbols = true,
      definitions = true,
      rename = true,
      references = true,
    },
  },
})

  -- Configure none-ls for formatting and linting
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      -- JavaScript/TypeScript
      null_ls.builtins.formatting.prettier,
      -- Ruby
      null_ls.builtins.formatting.rubocop,
      null_ls.builtins.diagnostics.rubocop,
    },
    -- Auto-format on save
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
  })-- Treesitter setup
require('nvim-treesitter.configs').setup({
  ensure_installed = { 
    -- JavaScript/Node.js
    "javascript", "json", "bash", "markdown", "yaml", "lua",
    -- Ruby/Rails
    "ruby", "embedded_template", "sql", "html", "css"
  },
  highlight = { enable = true },
  indent = { enable = true },
  -- Additional Ruby/Rails specific settings
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

-- Autocomplete setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Auto pairs
require('nvim-autopairs').setup({})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- Comment.nvim
require('Comment').setup()

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
})

-- Show diagnostics in a floating window
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

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

EOF
endif

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
"" Macros and Plugins
""

filetype off
" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Initialize plug.vim
call plug#begin('~/.vim/plugged')

" Languages support
Plug 'sheerun/vim-polyglot'

" Ruby and Rails
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rails'
Plug 'sunaku/vim-ruby-minitest'

" Other languages
Plug 'bitc/vim-hdevtools'       " for haskell; must install hdevtools
Plug 'reedes/vim-pencil'
Plug 'lifepillar/pgsql.vim'

" Helpers and tooling
Plug 'janko-m/vim-test'
Plug 'kassio/neoterm'
Plug 'w0rp/ale'
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
Plug 'tmux-plugins/vim-tmux-focus-events'

" Color schemes and some bling
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" All of your Plugins must be added before the following line
call plug#end()

filetype plugin indent on    " required


""
"" Plugins configs
""

let g:airline_theme='dracula'
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1
let g:tmuxline_powerline_separators = 0

" Use The Silver Searcher for faster searches if installed
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
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

silent! colors dracula


""
"" Gui options
""

set guifont=Monofur\ for\ Powerline:h18 " If you're not in a terminal look first for gvimrc
set guioptions-=T
set guioptions-=r

if has("gui_running")
  set visualbell " Don't beep
  colors dracula

  if has("gui_macvim")
      set fuoptions=maxhorz,maxvert " Fullscreen takes up entire screen
  endif

  if exists("g:enable_mvim_shift_arrow")
    let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
  endif
endif


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

  " Set the Ruby filetype for a number of common Ruby files without .rb
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set ft=ruby
  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript
  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif

  " Turn on language specific omnifuncs
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
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
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

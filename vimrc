""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
set cursorline        " Highlight the line the cursor is on
set showcmd           " Show incomplete cmds at the bottom
set laststatus=2      " Always show the status bar
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set guifont=Monaco\ for\ Powerline:h14 " If you're not in a terminal look first for gvimrc

set ttimeout          " activate timeout feature
set ttimeoutlen=100   " decrease timeout for faster insert with 'O'


""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                      " Reset the listchars
set listchars+=tab:▸\ ,trail:⋅,nbsp:⋅ " Display tabs and trailing spaces
"set listchars+=eol:¬                  " Display end-of-line
set listchars+=extends:»              " The character to show in the last column when wrap is
                                      " off and the line continues beyond the right of the screen
set listchars+=precedes:«             " The character to show in the last column when wrap is
                                      " off and the line continues beyond the right of the screen


""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter


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

set backupdir=~/.vim/.backup//    " where to put backup files.
set directory=~/.vim/.tmp//      " where to put swap files.


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
nnoremap <silent> <LocalLeader>rt :tabnew ~/.vim/vimrc<CR>
nnoremap <silent> <LocalLeader>re :e ~/.vim/vimrc<CR>
nnoremap <silent> <LocalLeader>rd :e ~/.vim/ <CR>

" Tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>


""
"" Scripts and Bundles
""

filetype off
" % to bounce from do to end etc.
runtime! macros/matchit.vim

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'altercation/vim-colors-solarized'

Bundle 'othree/html5.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'elixir-lang/vim-elixir'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'StanAngeloff/php.vim'

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'mmalecki/vim-node.js'
Bundle 'leshill/vim-json'
Bundle 'tpope/vim-haml'
Bundle 'juvenn/mustache.vim'
Bundle 'tpope/vim-markdown'
Bundle 'timcharper/textile.vim'
Bundle 'zaiste/tmux.vim'

Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sleuth'
Bundle 'kien/ctrlp.vim'
Bundle 'sickill/vim-pasta'
Bundle 'godlygeek/tabular'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'jszakmeister/vim-togglecursor'

" Automatically detect file types
filetype plugin indent on


""
"" Plugins configs
""

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


""
"" Theme
""

se t_Co=256
set background=dark
silent! colors solarized

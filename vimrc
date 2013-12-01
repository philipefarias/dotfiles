""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
set cursorline        " Highlight the line the cursor is on
set showcmd           " Show incomplete cmds at the bottom
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set guifont=Monaco\ for\ Powerline:h12 " If you're not in a terminal look first for gvimrc


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
"" Status line
""

if has("statusline") && !&cp
  let g:airline_powerline_fonts = 1

  " Normal Vim options
  set laststatus=2  " always show the status bar
endif


""
"" AutoCommands
""

if has("autocmd")
  if has("gui_running")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif

  " Set the Ruby filetype for a number of common Ruby files without .rb
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript
  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
  " Follow Zend Framework standards for PHP
  au FileType php set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=80
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
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'StanAngeloff/php.vim'

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'mmalecki/vim-node.js'
Bundle 'tpope/vim-haml'
Bundle 'juvenn/mustache.vim'
Bundle 'tpope/vim-markdown'
Bundle 'timcharper/textile.vim'

Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'sickill/vim-pasta'
Bundle 'godlygeek/tabular'
Bundle 'bling/vim-airline'

" Automatically detect file types
filetype plugin indent on


""
"" Theme
""

se t_Co=256
set background=dark
color solarized

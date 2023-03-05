" vim configuration

let mapleader = ' '              " leader key

set encoding=utf-8               " set encoding
set clipboard=unnamedplus        " Plug system clipboard
set mouse=a                      " enable mouse
set backspace=indent,eol,start   " backspacing

set showcmd                      " show normal mode cammand before executing
set nohidden                     " set if buffers are hidden
set fileencoding=utf-8           " set encoding for the current buffer
set noshowmode                   " set show mode
set noruler                      " show cursor position
set wildmode=longest:full,full	 " tab completions
set wildmenu                     " set wildmenu completion
set completeopt=menuone,noselect " settings for completion

set number                       " show line numbers
set norelativenumber             " set if numbers are relative to cursor
set cursorline                   " visual line on cursor line
set termguicolors                " set 24-bit colors
set nowrap                       " set line wraping
set scrolloff=0                  " set line amount for scrolling
set conceallevel=0               " setting for 'conceal' text
set splitbelow                   " set horizontal split to bottom screen
set splitright                   " set vertical split to right screen
set showtabline=1                " always show tabs
set guicursor=n-v-c-i:block      " set instert cursor to block

set showmatch                    " show matching character pairs
set hlsearch                     " highlight search results
set incsearch                    " incremental searching
set ignorecase                   " ingmore case of a search
set smartcase                    " only ingnores case if no capital letters

set tabstop=4                    " length of tabs
set softtabstop=0                " multiple spaces as tabstops for <BS>
set shiftwidth=4                 " width for autoindents
set expandtab                    " converts tabs to spaces
set breakindent                  " indent wraped lines relative to original
set smarttab                     " set tabs to adapt to other options
set autoindent                   " indent the same amount as previous line
set nosmartindent                " indents the right amount in more contexts

call plug#begin()

    Plug 'ayu-theme/ayu-vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'Yggdroot/indentLine'

call plug#end()

" colorscheme
let ayucolor="mirage" " for mirage version of theme
colorscheme ayu

" indent plugin
let g:indentLine_char = '|'

" navigate quickfix
:nmap <C-j> :cn<CR>
:nmap <C-k> :cp<CR>

" navigate buffers
:nmap <C-h> :bn<CR>
:nmap <C-l> :bp<CR>

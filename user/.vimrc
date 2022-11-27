" vim configuration

let mapleader = ' '              " leader key

set encoding=utf-8               " set encoding
set clipboard=unnamedplus        " use system clipboard
set mouse=a                      " set mouse

set showcmd                      " show normal mode cammand before executing
set nohidden                     " set if buffers are hidden
set fileencoding=utf-8           " set encoding for the current buffer
set noshowmode                   " set show mode
set noruler                      " show cursor position
set wildmode=longest:full,full	 " tab completions
set wildmenu                     " set if wildmenu is enabled
set completeopt=menuone,noselect " settings for completion

set number                       " show line numbers
set norelativenumber             " set if numbers are relative to cursor
set cursorline                   " visual line on cursor line
set termguicolors                " set 24-bit colors
set nowrap                       " set line wraping
set scrolloff=5                  " set line amount for scrolling
set conceallevel=0               " setting for 'conceal' text
set splitbelow                   " set horizontal split to bottom screen
set splitright                   " set vertical split to right screen
set showtabline=2                " always show tabs

set showmatch                    " show matching character pairs
set hlsearch                     " highlight search results
set incsearch                    " incremental searching
set ignorecase                   " ingmore case of a search
set smartcase                    " only ingnores case if no capital letters

set tabstop=2                    " length of tabs
set softtabstop=0                " multiple spaces as tabstops for <BS>
set shiftwidth=2                 " width for autoindents
set expandtab                    " converts tabs to spaces
set breakindent                  " indent wraped lines relative to original
set smarttab                     " set tabs to adapt to other options
set autoindent                   " indent the same amount as previous line
set smartindent                  " indents the right amount in more contexts

call plug#begin()

  Plug 'gosukiwi/vim-smartpairs' " auto pairs
  Plug 'junegunn/fzf.vim'        " fuzzy finder
  Plug 'Yggdroot/indentLine'     " indent lines
  Plug 'lifepillar/vim-gruvbox8' " theme

call plug#end()

set background=dark
colorscheme gruvbox8

" menus
:nmap <leader>m; :PlugInstall<CR>
:nmap <leader>m' :PlugClean<CR>
:nmap <leader>p :Files<CR>

" navigation
:nmap <S-h> :bn<CR>
:nmap <S-l> :bp<CR>

:nmap <S-j> :cn<CR>
:nmap <S-k> :cp<CR>

" move visual selection
:xmap <S-h> <gv
:xmap <S-l> >gv

:xmap <S-j> :m '>+1<CR>gv=gv
:xmap <S-k> :m '<-2<CR>gv=gv

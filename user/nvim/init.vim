" neovim configuration

source ~/.vimrc

call plug#begin()

    " lsp servers
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'

    " completion
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'

    " snipets
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    " syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " auto pairs/indent lines
    Plug 'windwp/nvim-autopairs'
    Plug 'lukas-reineke/indent-blankline.nvim'

    " theme
    Plug 'ayu-theme/ayu-vim'

call plug#end()

let ayucolor="mirage"
colorscheme ayu

lua << EOF

  -- IMPORTANT: config filenames cannot share plugin names
  local modules = { 'plugins' }

  -- reload modules when this file is read
  for _, v in pairs(modules) do
    package.loaded[v] = nil
    require(v)
  end

EOF

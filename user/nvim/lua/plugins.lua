-- neovim plugins

require('packer').startup (function(use)

  -- plugin manager
  use 'wbthomason/packer.nvim'

  -- quick motions
  use 'ggandor/leap.nvim'

  -- auto commenting
  use 'numToStr/Comment.nvim'

  -- lsp -> IMPORTANT: order matters
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  -- completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- snipets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

end)

require('leap').set_default_keymaps()

require('Comment').setup{
  opleader = {
    line  = '<leader>cc',
    block = '<leader>cb',
  }
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua' },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = false
  }
}

require('mason').setup {
  ui = {
    icons = {
      package_installed   = '✓',
      package_pending     = '➜',
      package_uninstalled = '✗'
    }
  },
}

require('mason-lspconfig').setup {}

local lsp_servers = { 'sumneko_lua', 'pyright', 'clangd' }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(lsp_servers) do
  require('lspconfig')[lsp].setup { capabilities = capabilities }
end

local cmp = require('cmp')

cmp.setup {
  snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert{
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  }, 
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  }
}

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

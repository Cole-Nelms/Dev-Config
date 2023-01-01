-- neovim configuration

local lsp_servers = {
    'sumneko_lua',
    'tsserver',
    'tailwindcss',
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

require('mason-lspconfig').setup {
    ensure_installed = lsp_servers,
    automatic_installation = true,
}

local cmp = require('cmp')
local cap = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(lsp_servers) do
    require('lspconfig')[lsp].setup { capabilities = cap }
end

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
        ['<C-y>'] = cmp.mapping.scroll_docs(-4),
        ['<C-e>'] = cmp.mapping.scroll_docs(4),
        ['<C-q>'] = cmp.mapping.abort(),
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

require('nvim-treesitter.configs').setup {
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },
    indent = {
        enable = false
    }
}

require("nvim-autopairs").setup {}
require("indent_blankline").setup {}

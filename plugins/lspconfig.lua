--[[ Standart plugin for setup language servers. ]]

local plugin = { -- returns at the end of file
  'neovim/nvim-lspconfig',

  YOUR_LSP_LIST = { -- Add another your lsp, used for plugins/cmp.lua
    'lua_ls',
    'clangd',
    'marksman',
    'sqlls',
    'ruff',
    'pyright'
  },

  config = function()
    local lspconfig = require('lspconfig')

    vim.diagnostic.config {
      virtual_text = true,
    }

    -- Activate specific Language Servers
    -- Check before YOUR_LSP_LIST field value
    lspconfig.clangd.setup {}
    lspconfig.ruff.setup {
      init_options = {
        settings = {
          -- Ruff language server settings go here
        }
      }
    }
    lspconfig.pyright.setup { -- from ruff documentation
      settings = {
        pyright = {
          -- Using Ruff's import organizer
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            -- Ignore all files for analysis to exclusively use Ruff for linting
            ignore = { '*' },
          },
        },
      },
    }
    lspconfig.sqlls.setup {}
    lspconfig.marksman.setup {}
    lspconfig.volar.setup {}
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    }
  end
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

local map = vim.keymap.set

map('n', 'gh', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'gtd', vim.lsp.buf.type_definition, opts)

    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    map({ 'n', 'v' }, '<leader>.', vim.lsp.buf.code_action, opts)
    map('n', '<leader>r', vim.lsp.buf.rename, opts)
  end,
})

return plugin


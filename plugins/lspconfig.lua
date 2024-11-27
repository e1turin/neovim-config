--[[ Standart plugin for setup language servers. ]]

local plugin = { -- returns at the end of file
  'neovim/nvim-lspconfig',

  YOUR_LSP_LIST = { -- Add another your lsp, used for plugins/cmp.lua
    'lua_ls',
    'clangd',
    'marksman',
    'sqlls',
    'ruff'
  },

  config = function()
    local lspconfig = require('lspconfig')

    vim.diagnostic.config({
      virtual_text = true,
    })

    -- Activate specific Language Servers
    -- Check before YOUR_LSP_LIST field value
    lspconfig.clangd.setup {}
    lspconfig.ruff.setup {}
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
map('n', '<leader>q', vim.diagnostic.setloclist)

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
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- map('n', '<leader>cd', vim.lsp.buf.add_workspace_folder, opts) -- idk not use
    -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- map('n', '<leader>wl', function()
      -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    map('n', 'gtd', vim.lsp.buf.type_definition, opts)
    map('n', '<leader>rr', vim.lsp.buf.rename, opts) -- fefactor rename
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('v', '<leader>f', function() -- I use Vgq
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

return plugin


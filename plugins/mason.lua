--[[ Additional tools package manager (LSP, DAP, Linters, Formatters) ]]

return {
  'williamboman/mason.nvim',

  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },

  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()
  end,

  priority = 1000 -- start before lspconfig
}

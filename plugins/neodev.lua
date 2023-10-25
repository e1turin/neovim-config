--[[ Neovim configuring helper ]]

return {
  'folke/neodev.nvim',

  config = function()
    require('neodev').setup {}
  end,

  priority = 1000 -- start before lspconfig
}

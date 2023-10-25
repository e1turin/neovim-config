--[[ Neovim shortcuts for managing surrounding char sequences ]]

return {
  'kylechui/nvim-surround',

  version = '*',

  event = 'VeryLazy',

  config = function()
    require('nvim-surround').setup {}
  end
}

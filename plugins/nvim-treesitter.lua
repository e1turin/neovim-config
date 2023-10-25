--[[ Treesitter utilite support for Neovim ]]

return {
  'nvim-treesitter/nvim-treesitter',

  config = function()
    vim.cmd([[:TSUpdate]])
  end
}

--[[ Comment plugin with lots of motions ]]

return {
  'numToStr/Comment.nvim',

  lazy = false,

  config = function()
    require('Comment').setup()
  end
}
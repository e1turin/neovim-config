--[[ Comment plugin with lots of motions ]]

return {
  'numToStr/Comment.nvim',

  lazy = false,

  config = function()
    require('Comment').setup()

    local api = require('Comment.api')
    local map = vim.keymap.set

    map('n', '<C-_>', function () -- CTRL + / for comment and step next line
      api.toggle.linewise.current()
      vim.api.nvim_feedkeys('j', 'n', false)
    end)

    local esc = vim.api.nvim_replace_termcodes( '<ESC>', true, false, true)
    -- Toggle selection (linewise) CTRL + /
    -- NOTE: Unable to comment CTRL + SHIFT + / for block comment as it is aliased to <Del>
    map('x', '<C-_>', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.toggle.linewise(vim.fn.visualmode())
    end)
  end
}

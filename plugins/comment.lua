--[[ Comment plugin with lots of motions ]]

return {
  'numToStr/Comment.nvim',

  lazy = false,

  config = function()
    require('Comment').setup()

    local api = require('Comment.api')
    local map = vim.keymap.set

    local comment_line_go_next = function () -- CTRL + / for comment and step next line
      api.toggle.linewise.current()
      vim.api.nvim_feedkeys('j', 'n', false)
    end
    map('n', '<C-_>', comment_line_go_next)

    local esc = vim.api.nvim_replace_termcodes( '<ESC>', true, false, true)
    local comment_block_linewise = function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.toggle.linewise(vim.fn.visualmode())
    end
    -- Toggle selection (linewise) CTRL + /
    -- NOTE: Unable to comment CTRL + SHIFT + / for block comment as it is aliased to <Del>
    map('x', '<C-_>', comment_block_linewise)

    map('x', 'gC', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.toggle.blockwise(vim.fn.visualmode())
    end)

  end
}

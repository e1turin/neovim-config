return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local builtin = require('telescope.builtin')

    local map = vim.keymap.set

    map('n', '<leader>sf', builtin.find_files, {})
    map('n', '<leader>sg', builtin.live_grep, {})
    map('n', '<leader>sb', builtin.buffers, {})
    map('n', '<leader>sh', builtin.help_tags, {})
  end
}


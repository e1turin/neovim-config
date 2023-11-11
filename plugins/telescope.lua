--[[ Powerful search engine ]]

-- get selected text
function vim.getVisualSelection()  
  --[[ https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1122642431 ]]
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

return {
  'nvim-telescope/telescope.nvim',

  tag = '0.1.3',

  dependencies = {
    'nvim-lua/plenary.nvim'
  },

  config = function()
    local builtin = require('telescope.builtin')

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true } -- idk what

    -- [[ <space> Search <something> ]]
    map('n', '<leader>ss', builtin.builtin, opts) -- search available searches
    map('n', '<leader>sf', builtin.find_files, opts)
    map('n', '<leader>sg', builtin.live_grep, opts)
    map('n', '<leader>sb', builtin.buffers, opts)
    map('n', '<leader>sh', builtin.help_tags, opts)
    map('n', '<leader>ff', builtin.current_buffer_fuzzy_find, opts)
    map('n', '<leader>sd', builtin.diagnostics, opts)

    map('v', '<leader>ff', function() -- fuzzy find selected text
      local text = vim.getVisualSelection()
      builtin.current_buffer_fuzzy_find({ default_text = text })
    end, opts)

    map('v', '<leader>sg', function() -- grep selected text
      local text = vim.getVisualSelection()
      builtin.live_grep({ default_text = text })
    end, opts)

    map('v', '<leader>sr', function() -- search references of selected text
      local text = vim.getVisualSelection()
      builtin.lsp_references({ default_text = text })
    end, opts)
  end
}


return {
  'akinsho/git-conflict.nvim',
  version = "*",
  config = function()
    require('git-conflict').setup {
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = 'copen',   -- command or function to open the conflicts list
      highlights = {           -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    }

    -- local map = vim.keymap.set
    -- map('n', 'co', '<Plug>(git-conflict-ours)')
    -- map('n', 'ct', '<Plug>(git-conflict-theirs)')
    -- map('n', 'cb', '<Plug>(git-conflict-both)')
    -- map('n', 'c0', '<Plug>(git-conflict-none)')
    -- map('n', ']x', '<Plug>(git-conflict-prev-conflict)')
    -- map('n', '[x', '<Plug>(git-conflict-next-conflict)')
  end
}

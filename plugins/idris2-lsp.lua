-- [ Idris2 LSP Plugin ]

return {
  'ShinKage/idris2-nvim',

  dependencies = {
    -- 'neovim/nvim-lspconfig',
    'MunifTanjim/nui.nvim'
  },

  config = function()
    local map = vim.keymap.set

    map('n', '<leader><leader>e', vim.diagnostic.open_float)    -- shortcut for displaying error messages in a separate window.
    map('n', '<leader><leader>el', vim.diagnostic.setloclist)

    -- command to run after every code action.
    local function save_hook(action)
      vim.cmd('silent write')
    end

    require('idris2').setup {
      client = {
        hover = {
          use_split = false,         -- Persistent split instead of popups for hover
          split_size = '30%',        -- Size of persistent split, if used
          auto_resize_split = false, -- Should resize split to use minimum space
          split_position = 'bottom', -- bottom, top, left or right
          with_history = false,      -- Show history of hovers instead of only last
          use_as_popup = false,      -- Close the split on cursor movement
        },
      },

      autostart_semantic = true,             -- Should start and refresh semantic highlight automatically
      code_action_post_hook = save_hook,     -- Function to execute after a code action is performed:
      use_default_semantic_hl_groups = true, -- Set default highlight groups for semantic tokens
      default_regexp_syntax = true,          -- Enable default highlight groups for traditional syntax based highlighting

      server = {
        on_attach = function()
          map('n', 'gd', vim.lsp.buf.definition)
          map('n', 'K', vim.lsp.buf.hover)

          local ca = require('idris2.code_action')
          map('n', '<leader>c', ca.case_split)
          map('n', '<leader>mc', ca.make_case)
          map('n', '<leader>mw', ca.make_with)
          map('n', '<leader>ml', ca.make_lemma)
          map('n', '<leader>a', ca.add_clause)
          map('n', '<leader>o', ca.expr_search)
          map('n', '<leader>gd', ca.generate_def)
          map('n', '<leader>rh', ca.refine_hole)

          local hover = require('idris2.hover')
          map('n', '<leader>so', hover.open_split)
          map('n', '<leader>sc', hover.close_split)

          local mv = require('idris2.metavars')
          map('n', '<leader>mm', mv.request_all)
          map('n', '<leader>mn', mv.goto_next)
          map('n', '<leader>mp', mv.goto_prev)

          local browse = require('idris2.browse')
          map('n', '<leader>br', browse.browse)

          local repl = require('idris2.repl')
          map('n', '<leader>x', repl.evaluate)
        end,

        init_options = {
          logFile = "~/.cache/idris2-lsp/server.log",
          longActionTimeout = 2000, -- 2 second
        },
      },
    }
  end
}

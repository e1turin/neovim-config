-- [ Idris2 LSP Plugin ]

return {
  'ShinKage/idris2-nvim',

  dependencies = {
    -- 'neovim/nvim-lspconfig',
    -- 'MunifTanjim/nui.nvim' -- required! but buggy
  },

  config = function()
    -- vim.g.maplocalleader=' ' -- by default equal to <Leader>

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
          local map = vim.keymap.set

          local ca = require('idris2.code_action')
          map('n', '<LocalLeader>c', ca.case_split)
          map('n', '<LocalLeader>mc', ca.make_case)
          map('n', '<LocalLeader>mw', ca.make_with)
          map('n', '<LocalLeader>ml', ca.make_lemma)
          map('n', '<LocalLeader>a', ca.add_clause)
          map('n', '<LocalLeader>o', ca.expr_search)
          map('n', '<LocalLeader>gd', ca.generate_def)
          map('n', '<LocalLeader>rh', ca.refine_hole)

          local hover = require('idris2.hover')
          map('n', '<LocalLeader>so', hover.open_split)
          map('n', '<LocalLeader>sc', hover.close_split)

          local metavars = require('idris2.metavars')
          map('n', '<LocalLeader>mm', metavars.request_all)
          map('n', '<LocalLeader>mn', metavars.goto_next)
          map('n', '<LocalLeader>mp', metavars.goto_prev)

          local browse = require('idris2.browse')
          map('n', '<LocalLeader>br', browse.browse)

          local repl = require('idris2.repl')
          map('n', '<LocalLeader>e', repl.evaluate)
        end,

        init_options = {
          logFile = "~/.cache/idris2-lsp/server.log",
          longActionTimeout = 2000, -- 2 second
        },

        -- before_init = function (params)
        --    params.processId = vim.NIL
        -- end,
        -- cmd = {
        --   'docker', 'run', '-i', '--rm', '-v', 'D:/Projects/itmo-fp/lab-1/task-13:/mnt/projects/itmo-fp/lab-1/task-13', 'idris2-pack-lsp', 'idris2-lsp'
        -- }
      },
    }
  end
}

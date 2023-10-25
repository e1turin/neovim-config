--[[ Line for visualizing openned buffers as tabs ]]

return {
  'akinsho/bufferline.nvim',

  version = '*',

  dependencies = 'nvim-tree/nvim-web-devicons',

  config = function() -- see :h bufferline-configuration
    vim.opt.termguicolors = true
    require('bufferline').setup {
      options = {
        diagnostics = "nvim_lsp",   --false | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or ""
          return " " .. icon .. count
        end,
        close_command = "bdelete %d",           -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = false,            --"bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = 'buffer %d',       -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = "bdelete %d",    -- can be a string | function, | false see "Mouse actions"

        -- For 2.)8.) - change the order of arguments to change the order in the string
        numbers = function(opts)
          --return string.format('%s.)%s.)', opts.ordinal, opts.id)
          return string.format('<%s>', opts.id)
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            text_align = "left"
          }
        }
      },
      --highlights = {}
    }
  end
}

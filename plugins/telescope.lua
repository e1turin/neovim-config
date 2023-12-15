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

local vis = function(func) -- provides default text from selected one in V-Mode
  return function()
    local text = vim.getVisualSelection()
    func({ default_text = text })
  end
end

return {
  'nvim-telescope/telescope.nvim',

  -- tag = '0.1.3',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim'
  },

  config = function()
    require('telescope').setup {
      defaults = {
        layout_strategy = "flex", -- "horizontal"/"vertival"/"flex"/"cursor"
        layout_config = {
          vertical = {
            prompt_position = "top",
            mirror = true,
          },
          horizontal = {
            prompt_position = "top",
          },
        },
        sorting_strategy = "ascending",
        preview_cutoff = 1,
        path_display = { "smart" } -- "smart"/"shorten"/...
      },

      pickers = {
        buffers = {
          show_all_buffers = true,
          sort_mru = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
            n = {
              ["<c-d>"] = "delete_buffer",
            },
          },
          -- layout_strategy = "vertical",
          layout_config = {
            vertical = {
              prompt_position = "top",
              mirror = false
            }
          }
        },
        find_files = {
          hidden = true,
        }
      },

      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        }
      }
    }
    require('telescope').load_extension('ui-select')

    local builtin = require('telescope.builtin')

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true } -- idk what

    -- [[ <space> Search <something> ]]
    map('n', '<leader>ss', builtin.builtin, opts) -- search available searches
    map('n', '<leader>sf',    builtin.find_files, opts)
    map('n', '<leader><CR>',  builtin.find_files, opts) -- fast open file
    map('n', '<leader>sb',        builtin.buffers, opts)
    map('n', '<leader><leader>',  builtin.buffers, opts) -- fast jump between buffers
    map('n', '<leader>sg', builtin.live_grep, opts)
    map('n', '<leader>ff',  builtin.current_buffer_fuzzy_find, opts)
    map('n', '<leader>/',   builtin.current_buffer_fuzzy_find, opts)
    map('n', '<leader>sd', builtin.diagnostics, opts)

    map('v', '<leader>ff', vis(builtin.current_buffer_fuzzy_find), opts)
    map('v', '<leader>/', vis(builtin.current_buffer_fuzzy_find), opts)
    map('v', '<leader>sg', vis(builtin.live_grep), opts)
    map('v', '<leader>sr', vis(builtin.lsp_references), opts)
  end
}


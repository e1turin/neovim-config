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
    'nvim-telescope/telescope-ui-select.nvim',
    "nvim-telescope/telescope-file-browser.nvim", -- additional file browser
  },

  config = function()
    local fb_actions = require "telescope._extensions.file_browser.actions"

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
        },
        ["file_browser"] = {
          -- theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          -- hijack_netrw = true,
          path = vim.loop.cwd(),
          cwd = vim.loop.cwd(),
          cwd_to_path = false,
          grouped = false,
          files = true,
          add_dirs = true,
          depth = 1,
          auto_depth = false,
          select_buffer = false,
          hidden = { file_browser = false, folder_browser = false },
          respect_gitignore = vim.fn.executable "fd" == 1,
          no_ignore = false,
          follow_symlinks = false,
          browse_files = require("telescope._extensions.file_browser.finders").browse_files,
          browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
          hide_parent_dir = false,
          collapse_dirs = false,
          prompt_path = false,
          quiet = false,
          dir_icon = "",
          dir_icon_hl = "Default",
          display_stat = { date = true, size = true, mode = true },
          hijack_netrw = false,
          use_fd = true,
          git_status = true,
          mappings = {
            ["i"] = {
              ["<A-c>"] = fb_actions.create,
              ["<S-CR>"] = fb_actions.create_from_prompt,
              ["<A-r>"] = fb_actions.rename,
              ["<A-m>"] = fb_actions.move,
              ["<A-y>"] = fb_actions.copy,
              ["<A-d>"] = fb_actions.remove,
              -- ["<C-o>"] = fb_actions.open,
              ["<C-o>"] = function() end,
              ["<C-g>"] = fb_actions.goto_parent_dir,
              ["<C-e>"] = fb_actions.goto_home_dir,
              ["<C-w>"] = fb_actions.goto_cwd,
              ["<C-t>"] = fb_actions.change_cwd,
              ["<C-f>"] = fb_actions.toggle_browser,
              ["<C-h>"] = fb_actions.toggle_hidden,
              ["<C-s>"] = fb_actions.toggle_all,
              ["<bs>"] = fb_actions.backspace,
            },
            ["n"] = {
              ["c"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,
              ["d"] = fb_actions.remove,
              -- ["o"] = fb_actions.open,
              ["o"] = function() end,
              ["g"] = fb_actions.goto_parent_dir,
              ["e"] = fb_actions.goto_home_dir,
              ["w"] = fb_actions.goto_cwd,
              ["t"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,
              ["h"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
            },
          },
        },
      }
    }
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('file_browser')

    local builtin = require('telescope.builtin')

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true } -- idk what

    -- [[ <space> Search <something> ]]
    map('n', '<leader>s', builtin.builtin, opts)        -- available searches
    map('n', '<leader>f', builtin.find_files, opts)
    map('n', '<leader><CR>', builtin.find_files, opts)  -- fast open file
    map('n', '<leader>b', builtin.buffers, opts)
    map('n', '<leader><leader>', builtin.buffers, opts)  -- fast jump between buffers
    map('n', '<leader>g', builtin.live_grep, opts)
    map('n', '<leader>n', builtin.lsp_document_symbols, opts)
    map('n', '<leader>N', builtin.lsp_dynamic_workspace_symbols, opts)
    -- map('n', '<leader>f',  builtin.current_buffer_fuzzy_find, opts)
    map('n', '<leader>/',   builtin.current_buffer_fuzzy_find, opts)
    -- map('n', '<leader>sd', builtin.diagnostics, opts)
    map("n", "<leader>d", ":Telescope file_browser<CR>") -- path=%:p:h select_buffer=true -- param for opening in current dir
    map("n", "<leader>t", ":Telescope ") -- shortcut to call any Telescope picker

    map('v', '<leader>ff', vis(builtin.current_buffer_fuzzy_find), opts)
    map('v', '<leader>/', vis(builtin.current_buffer_fuzzy_find), opts)
    map('v', '<leader>sg', vis(builtin.live_grep), opts)
    map('v', '<leader>sr', vis(builtin.lsp_references), opts)

  end
}


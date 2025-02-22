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
    local T = require("telescope")
    local fb = T.extensions.file_browser
    local fb_actions = fb.actions

    T.setup {
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
          -- require("telescope.themes").get_dropdown {
          --   -- even more opts
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
          hidden = { file_browser = true, folder_browser = false },
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
    T.load_extension('ui-select')
    T.load_extension('file_browser')

    local TB = require('telescope.builtin')
    local TU = require('telescope.utils')

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true } -- idk what

    local find_in_current_dir = function()
      TB.find_files({ cwd = TU.buffer_dir() })
    end
    local file_browser_in_current_dir = function()
      fb.file_browser({
        path = TU.buffer_dir(),
        select_buffer = true
      })
    end

    -- omni
    map('n', '<leader><leader>', TB.resume, opts) -- fast jump between buffers
    map('n', '<leader>s', TB.builtin, opts)       -- available searches
    map("n", "<leader>t", ":Telescope ")               -- shortcut to call any Telescope picker from command line

    -- buffers
    map('n', '<leader>b', TB.buffers, opts)
    map('n', '<leader><CR>', TB.buffers, opts)

    -- files
    map('n', '<leader>\\', TB.find_files, opts) -- fast open file
    map('n', '<leader>d', find_in_current_dir, opts)
    map('n', '<leader>f', file_browser_in_current_dir) -- opening in current dir
    map('n', '<leader>F', fb.file_browser)             -- opening in start up dir

    -- greping
    map('n', '<leader>g', TB.live_grep, opts)
    map('v', '<leader>g', vis(TB.live_grep), opts)
    map('n', '<leader>/', TB.current_buffer_fuzzy_find, opts)
    map('v', '<leader>/', vis(TB.current_buffer_fuzzy_find), opts)

    -- LSP
    map('n', '<leader>n', TB.lsp_document_symbols, opts)
    map('v', '<leader>n', vis(TB.lsp_references), opts)
    map('n', '<leader>N', TB.lsp_dynamic_workspace_symbols, opts)
    map('n', '<leader>i', TB.diagnostics, opts) -- *show issues*
  end
}

--[[ Beautiful status line ]]

local function myLocation()
  local r, c = unpack(vim.api.nvim_win_get_cursor(0))
  return r .. ':' .. c .. ' / ' .. vim.fn.line('$')
end

local myFileformat = {
  'fileformat',
  symbols = {
    unix = 'unix', -- '', -- e712 = linux penguin
    dos = 'dos',   -- '', -- e70f = windsows
    mac = 'mac',   -- '', -- e711 = apple
  }
}

local myFilename = {
  'filename',
  file_status = true,     -- Displays file status (readonly status, modified status)
  newfile_status = false, -- Display new file status (new file means no write after created)
  path = 4,
  -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory
  -- 4: Filename and parent dir, with tilde as the home directory
  shorting_target = 40,           -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = '[+]',      -- Text to show when the file is modified.
    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New]',     -- Text to show for newly created file before first write
  }
}

local myDiff = {
  'diff',
  colored = true, -- Displays a colored diff status if set to true
  -- diff_color = {
  --   -- Same color values as the general color option can be used here.
  --   added    = 'LuaLineDiffAdd',    -- Changes the diff's added color
  --   modified = 'LuaLineDiffChange', -- Changes the diff's modified color
  --   removed  = 'LuaLineDiffDelete', -- Changes the diff's removed color you
  -- },
  symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
  source = nil, -- A function that works as a data source for diff.
                -- It must return a table as such:
                --   { added = add_count, modified = modified_count, removed = removed_count }
                -- or nil on failure. count <= 0 won't be displayed.
}

return {
  'nvim-lualine/lualine.nvim',

  version = '*',

  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 500,
          tabline = 1000,
          winbar = 1000,
        }
      },

      sections = {
        -- lualine_a = { vim.fn.mode }, -- short form of mode insted of full for 'mode'.
        -- unused as there is original vim description on the bottom line
        lualine_a = {
          { 'branch' },
        },
        lualine_b = {
          myDiff,
        },
        lualine_c = {
          myFilename,
          { 'diagnostics' },
        },
        lualine_x = {
          { 'encoding' },
          myFileformat
        },
        lualine_y = {},
        lualine_z = {
          myLocation
        }
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {
          { 'branch' },
          myDiff
        },
        lualine_c = {
          myFilename,
          { 'diagnostics' },
        },
        lualine_x = {
          { 'encoding' },
          myFileformat
        },
        lualine_y = {},
        lualine_z = {
          { 'progress' }
        }
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}

--[[ Directory tree window ]]
-- use 'g?' for Help 

return {
  'nvim-tree/nvim-tree.lua',

  version = '*',

  -- lazy = false,

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('nvim-tree').setup {}

    local function opts(desc)
      return {
        desc = 'nvim-tree: ' .. desc,
        --buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
      }
    end

    local api = require('nvim-tree.api')
    local map = vim.keymap.set
    map('n', '+', api.tree.change_root_to_node, opts('CD'))
    -- map('n', 'za', api.node.open, opts('Toggle folder'))
  end,
}
--[[ Default mappings: :h nvim-tree-mappings-default
  '<C-]>',----------->'CD'
  '<C-e>',----------->'Open: In Place'
  '<C-k>',----------->'Info'
  '<C-r>',----------->'Rename: Omit Filename'
  '<C-t>',----------->'Open: New Tab'
  '<C-v>',----------->'Open: Vertical Split'
  '<C-x>',----------->'Open: Horizontal Split'
  '<BS>',------------>'Close Directory'
  '<CR>',------------>'Open'
  '<Tab>',----------->'Open Preview'
  '>',--------------->'Next Sibling'
  '<',--------------->'Previous Sibling'
  '.',--------------->'Run Command'
  '-',--------------->'Up'
  'a',--------------->'Create'
  'bd',-------------->'Delete Bookmarked'
  'bt',-------------->'Trash Bookmarked'
  'bmv',------------->'Move Bookmarked'
  'B',--------------->'Toggle Filter: No Buffer'
  'c',--------------->'Copy'
  'C',--------------->'Toggle Filter: Git Clean'
  '[c',-------------->'Prev Git'
  ']c',-------------->'Next Git'
  'd',--------------->'Delete'
  'D',--------------->'Trash'
  'E',--------------->'Expand All'
  'e',--------------->'Rename: Basename'
  ']e',-------------->'Next Diagnostic'
  '[e',-------------->'Prev Diagnostic'
  'F',--------------->'Clean Filter'
  'f',--------------->'Filter'
  'g?',-------------->'Help'
  'gy',-------------->'Copy Absolute Path'
  'H',--------------->'Toggle Filter: Dotfiles'
  'I',--------------->'Toggle Filter: Git Ignore'
  'J',--------------->'Last Sibling'
  'K',--------------->'First Sibling'
  'm',--------------->'Toggle Bookmark'
  'o',--------------->'Open'
  'O',--------------->'Open: No Window Picker'
  'p',--------------->'Paste'
  'P',--------------->'Parent Directory'
  'q',--------------->'Close'
  'r',--------------->'Rename'
  'R',--------------->'Refresh'
  's',--------------->'Run System'
  'S',--------------->'Search'
  'u',--------------->'Rename: Full Path'
  'U',--------------->'Toggle Filter: Hidden'
  'W',--------------->'Collapse'
  'x',--------------->'Cut'
  'y',--------------->'Copy Name'
  'Y',--------------->'Copy Relative Path'
  '<2-LeftMouse>', -->'Open'
  '<2-RightMouse>',-->'CD'
]]

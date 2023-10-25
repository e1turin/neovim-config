--[[ Lazy plugin manager setup ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)



-- Include plugins (additional setup is required for each of them)
require('lazy').setup {

  --[[ Autocompletion ]]
  -- Completion
  require('plugins.cmp'),
  -- Snippets
  require('plugins.vim-vsnip'), -- for cmp

  --[[ Additional devtools ]]
  -- Standart LSP setup helper
  require('plugins.lspconfig'),
  -- Neovim configuring helper
  require('plugins.neodev'),
  -- Package manager for LSP, DAP, Linters, etc.
  require('plugins.mason'),


  --[[ Layout, TUI tools ]]
  -- Powerful search through Neovim
  require('plugins.telescope'),
  -- Directory tree
  require('plugins.nvim-tree'),
  -- Statusline
  require('plugins.lualine'),
  -- Tabs for vim's buffers
  require('plugins.bufferline'),
  -- Git Integration
  require('plugins.gitsigns'),

  --[[ Plugins that eliminate routine ]]
  -- Comments
  require('plugins.comment'),
  -- Pair brackets
  require('plugins.nvim-autopairs'),
  -- Manage surrounding symbols
  require('plugins.nvim-surround'),
  -- Auto save
  require('plugins.auto-save'),

  --[[ UI improvements ]]
  -- Indentation Highlighting
  require('plugins.indent-blankline'),
  -- Highlight code for colorings
  require('plugins.nvim-highlight-colors'),

  -- [[ Treesitter ]]
  require('plugins.nvim-treesitter'),

  --[[ Color schemes ]]
  require('plugins.themes.moonfly'),
}


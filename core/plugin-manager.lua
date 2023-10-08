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
require("lazy").setup {

  -- Completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',

  -- Snippets
  { 'hrsh7th/vim-vsnip', }, -- Is needed for cmp

  -- Standart LSP setup helper
  require("plugins.lspconfig"),

  -- File search
  require("plugins.telescope"),

  -- File tree
  require("plugins.nvim-tree"),

  -- Statusline
  require("plugins.lualine"),

  -- Package manager for LSP, DAP, Linters...
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Neovim config helper
  { 
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {}
    end
  },

}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  "folke/neodev.nvim",
  "neovim/nvim-lspconfig",

  -- cmp
  'hrsh7th/cmp-nvim-lsp', 
  'hrsh7th/cmp-buffer', 
  'hrsh7th/cmp-path', 
  'hrsh7th/cmp-cmdline', 
  'hrsh7th/nvim-cmp',

  -- snippets
  'hrsh7th/vim-vsnip',

  -- pachage manager
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

})

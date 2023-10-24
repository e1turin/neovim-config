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

  { -- Completion
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', },
      { 'hrsh7th/cmp-buffer', },
      { 'hrsh7th/cmp-path', },
      { 'hrsh7th/cmp-cmdline', },

      -- Snippets
      { 'hrsh7th/vim-vsnip', }, -- Is needed for cmp
    }
  },

  { -- Standart LSP setup helper
    "neovim/nvim-lspconfig",
  },

  { -- Comments
    'numToStr/Comment.nvim',
    lazy = false,
    config = function ()
      require('Comment').setup()
    end
  },

  -- File search
  require("plugins.telescope"),

  -- File tree
  require("plugins.nvim-tree"),

  -- Statusline
  require("plugins.lualine"),
  require("plugins.bufferline"),

  { -- Package manager for LSP, DAP, Linters...
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    }
  },

  { -- Neovim config helper
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {}
    end
  },

  { -- Indentation Highlighting
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup {}
    end
  },

  { -- Git Integration
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = { --[[e.g. ▏, ▎, ╍, ┃, │, █, ·, …, ⋯ ]]
          add          = { text = '·' },
          change       = { text = '·' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = ':' },
        },
      }
      -- overrides by color scheme
    end,
  },

  { -- Highlight code for colorings
    'brenoprata10/nvim-highlight-colors'
  },

  { -- Pair brackets
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  },

  { -- Auto save
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {}
    end,
  },

  { -- Treesitter
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      vim.cmd([[:TSUpdate]])
    end
  },

  -- Color schemes
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000
  },
}


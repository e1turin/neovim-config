--[[ Treesitter utilite support for Neovim ]]

return {
  'nvim-treesitter/nvim-treesitter',

  config = function()
    require('nvim-treesitter.configs').setup {
      modules = {},
      -- ensure_installed = { "c", "cpp", "python", "markdown", "lua", "vim", "vimdoc" },
      ensure_installed = {}, -- avoid errors on first start

      sync_install = false,

      auto_install = false,

      ignore_install = { "javascript" }, -- example

      highlight = {
        enable = true,

        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        additional_vim_regex_highlighting = true,
      },
    }

    -- Treesitter folding
    -- vim.wo.foldmethod = 'expr'
    -- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
  end
}

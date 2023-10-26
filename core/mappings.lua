--[[ Additional keyboard mappings ]]

vim.g.mapleader = ' ' -- space for <leader> key

-- https://github.com/ibhagwan/nvim-lua/blob/82daba2fd86fd388bc61dedb49126fb7cb12ccae/lua/keymaps.lua
local map = vim.keymap.set

-- Navigate buffers
map('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '[B', ':bfirst<CR>', { desc = 'First buffer' })
map('n', ']B', ':blast<CR>', { desc = 'Last buffer' })

map('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
map('i', '<C-v>', '<C-o>"+p', { desc = 'Paste from system clipboard' })
map('n', '<C-a>', 'ggVG', { desc = 'Select all content' })

vim.cmd([[let g:ftplugin_sql_omni_key = '<C-\>']])

-- Show directory tree
map('n', '<leader>d', function ()
  require('nvim-tree.api').tree.focus()
end , { desc = 'Focus on directory tree window' })
